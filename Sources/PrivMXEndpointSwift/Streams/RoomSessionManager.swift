//
// PrivMX Endpoint Swift
// Copyright © 2026 Simplito sp. z o.o.
//
// This file is part of PrivMX Platform (https://privmx.dev).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//

import PrivMXEndpointSwiftNative
import WebRTC
import Foundation

public final class RoomSessionManager: Sendable{
	public func muteAudioOutFor(_ roomId:String) -> Void {
		roomSessions[roomId]?.publisher?.audioTracks.forEach {
			$0.value.sender.track = nil
		}
	}
	
	nonisolated(unsafe) var onAudioTrack: ((String,RTCAudioTrack) -> Void)?
	nonisolated(unsafe)var onVideoTrack: ((String,RTCVideoTrack) -> Void)?
	
	nonisolated(unsafe) var streamHandles: [privmx.endpoint.stream.StreamHandle:String] = [:]
	nonisolated(unsafe) var roomSessions: [String:RoomJanusSession] = [:]
	
	private let onTrickle: @Sendable (Int64,String) throws -> Void
	public nonisolated(unsafe) let peerConnectionFactory: RTCPeerConnectionFactory
	
	private let setNewOfferOnReconfigure: @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void
	private let acceptOfferOnReconfigure: @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void
	
	static func create(
		onTrickle: @escaping @Sendable (Int64,String) throws -> Void,
		setNewOfferOnReconfigure: @escaping @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void,
		acceptOfferOnReconfigure: @escaping @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void,
	) -> RoomSessionManager {
		var encf = RTCDefaultVideoEncoderFactory()
		
		encf.preferredCodec = .init(name: kRTCVp8CodecName)
		
		var mgr = RoomSessionManager(
			onTrickle: onTrickle,
			peerConnectionFactory: RTCPeerConnectionFactory(
				encoderFactory: encf,
			 decoderFactory: RTCDefaultVideoDecoderFactory()),
			onSetNewOfferOnReconfigure: setNewOfferOnReconfigure,
			onAcceptOfferOnReconfigure: acceptOfferOnReconfigure
		)
		return mgr
	}
	@discardableResult
	func addRoomSessionFor(
		_ roomId: String
	) throws -> RoomJanusSession {
		guard roomSessions[roomId] == nil
		else {
			throw PrivMXEndpointError.otherFailure(.init(
				name: "Room Session already exists",
				message: "",
				description: "")
			)
		}
		var ks = PMXKeyStore()
		nonisolated(unsafe)var rjs = RoomJanusSession(
			keyStore: ks,
			roomId: roomId,
			_getPeerConnectionWithDelegate:{
				return self.createPeerConnection(keyStore: &ks,streamRoomId: roomId)
			}
		)
		setCppCallbacksInSession(&rjs)
		rjs.publisher?.peerConnectionDelegate.setIceCandidateGeneratedCallback({
			peerConnection, candidate in
			RTCLogEx(.info, "[PMX] will try trickling publisher")
			if !candidate.sdp.isEmpty, let sessionId = rjs.publisher?.sessionId, sessionId > -1{
				var iceCandidate = candidate.sdp
				do{
					RTCLogEx(.info, "[PMX] trickling publisher")
					//try self.onTrickle(sessionId,iceCandidate)
				}catch{
					print("Failed to trickle candidate", error)
				}
			}
		})
		rjs.subscriber?.peerConnectionDelegate.setIceCandidateGeneratedCallback({
			peerConnection, candidate in
			RTCLogEx(.info, "[PMX] will try trickling subscriber")
			if !candidate.sdp.isEmpty, let sessionId = rjs.subscriber?.sessionId, sessionId > -1{
				var iceCandidate = candidate.sdp
				do{
					RTCLogEx(.info, "[PMX] trickling subscriber")
					try self.onTrickle(sessionId,iceCandidate)
				}catch{
					print("Failed to trickle candidate", error)
				}
			}
		})
		rjs.publisher?.peerConnectionDelegate.setShouldRenegotiateCallback({
			pc in
			let offer = try? pc.offer(for: RTCMediaConstraints(mandatoryConstraints:nil,optionalConstraints: nil)) {description,error in
				if let pub = rjs.publisher, let description{
					RTCLogEx(.info, "[PMX][Renegotiate] Has publisher and description")
					let tp = switch description.type {
						case .answer:
							"answer"
						case .prAnswer:
							"prAnswer"
						case .offer:
							"offer"
						case .rollback:
							"rollback"
						@unknown default:
							"UNKNOWN"
					}
					Task{@Sendable in
						let sid = pub.sessionId
						if let swr = await try? pub.reconfigure(sdp: description.sdp, type: String(tp), roomId: rjs.roomId){
							let swt = privmx.endpoint.stream.SdpWithTypeModel(sdp: swr.sdp, type: swr.type )
							try? self.setNewOfferOnReconfigure(sid,swt)
						}
					}
				}
			}
		})
		
		roomSessions[roomId] = rjs
		return rjs
	}
	
	
	func addVideoTrack(
		_ track: RTCVideoTrack,
		to roomId: String
	) throws -> Void {
		guard let session = roomSessions[roomId]
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "No session for room",
					message: "", description: ""
				)
			)
		}
		let pub = try session.getOrCreatePublisher()
		guard nil == pub.videoTracks[track.trackId] else
		{
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Track already added",
					message: "", description: ""
				)
			)
		}
		var tinit = RTCRtpTransceiverInit()
		tinit.direction = .sendOnly
		guard var sender = pub.peerConnection.addTransceiver(with: track, init: tinit)

		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create sender",
					message: "", description: ""
				)
			)
		}
		
		guard var cryptor = PMXFrameCryptorTransformer(
			for: sender.sender,
			   with: peerConnectionFactory,
			pmxKeyStore: session.keyStore.value)
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create cryptor",
					message: "", description: ""
				)
			)
		}
		pub.videoTracks[track.trackId] = VideoTrackInfo(
			track: track,
			sender: sender.sender,
			frameCryptor: cryptor)
		sender.sender.track
	}
	
	func addAudioTrack(
		_ track: RTCAudioTrack,
		to roomId: String
	) throws -> Void {
		guard let session = roomSessions[roomId]
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "No session for room",
					message: "", description: ""
				)
			)
		}
		let pub = try session.getOrCreatePublisher()
		guard nil == pub.videoTracks[track.trackId] else
		{
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Track already added",
					message: "", description: ""
				)
			)
		}
		
		var tinit = RTCRtpTransceiverInit()
		tinit.direction = .sendOnly
		guard var sender = pub.peerConnection.addTransceiver(with: track,init: tinit)
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create sender",
					message: "", description: ""
				)
			)
		}
		
		guard var cryptor = PMXFrameCryptorTransformer(
			for: sender.sender,
			with: peerConnectionFactory,
			pmxKeyStore: session.keyStore.value)
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create cryptor",
					message: "", description: ""
				)
			)
		}
		pub.audioTracks[track.trackId] = AudioTrackInfo(
			track: track,
			sender: sender.sender,
			frameCryptor: cryptor)
	}
	
	func removeVideoTrack(
		_ track: RTCVideoTrack,
		from handle: privmx.endpoint.stream.StreamHandle
	) throws -> Bool {
		guard let rid = streamHandles[handle], let publisher = roomSessions[rid]?.publisher
		else {
			throw PrivMXEndpointError.otherFailure(.init(name: "No publisher found", message: "", description: ""))
		}
		if let sender = publisher.videoTracks[track.trackId]?.sender {
			return publisher.peerConnection.removeTrack(sender)
		} else {
			throw PrivMXEndpointError.otherFailure(.init(name: "No sender for track", message: "", description: ""))
		}
	}
	
	func removeAudioTrack(
		_ track: RTCAudioTrack,
		from handle: privmx.endpoint.stream.StreamHandle
	) throws -> Bool {
		guard let rid = streamHandles[handle], let publisher = roomSessions[rid]?.publisher
		else {
			throw PrivMXEndpointError.otherFailure(.init(name: "No publisher found", message: "", description: ""))
		}
		if let sender = publisher.audioTracks[track.trackId]?.sender {
			return publisher.peerConnection.removeTrack(sender)
		} else {
			throw PrivMXEndpointError.otherFailure(.init(name: "No sender for track", message: "", description: ""))
		}
		
	}
	
	func setAudioStreamsHandler(
	_ handler: ((String,RTCAudioTrack) -> Void)?
	) -> Void{
		self.onAudioTrack = handler
	}
	
	func setVideoStreamsHandler(
	_ handler: ((String,RTCVideoTrack) -> Void)?
	) -> Void{
		self.onVideoTrack = handler
	}
	
	func createPeerConnection(
		keyStore:inout PMXKeyStore,
		streamRoomId: String
	) -> (RTCPeerConnection?, PMXPeerConnectionDelegate){
		var observer = PMXPeerConnectionDelegate(
			streamRoomId: streamRoomId,
			peerConnectionFactory: self.peerConnectionFactory,
			currentKeys: &keyStore
		)
		let it = Unmanaged<PMXPeerConnectionDelegate>.passUnretained(observer)
		observer.setTracksAddedCallback({
			pc, receiver, mediaStreams in
			let that = Unmanaged<PMXPeerConnectionDelegate>.takeUnretainedValue(it)
			if let trackId = receiver.track?.trackId, mediaStreams.count > 0{
				let streamId = mediaStreams[0].streamId
				that().track2Stream[trackId] = streamId
				print("[PMX][Observer]",trackId,that().track2Stream[trackId])
				let ut = that().unprocessedTracks
				for t in ut{
					if t.value.kind == kRTCMediaStreamTrackKindVideo {
						if let track = t.value as? RTCVideoTrack{
							RTCLogEx(.info,"[PMX][Observer]Got an unprocessed Video Track")
							that().onVideoTrack?(streamId, track)
						} else {
							RTCLogEx(.info,"[PMX][Observer]Couldn't cast media track as video track")
						}
					}
					else if t.value.kind == kRTCMediaStreamTrackKindAudio {
						if let track = t.value as? RTCAudioTrack{
							RTCLogEx(.info,"[PMX][Observer]Got an unprocessed Audio Track")
							that().onAudioTrack?(streamId,track)
						}else{
							RTCLogEx(.info,"[PMX][Observer]Couldn't cast media track as audio track")
						}
					}
					that().unprocessedTracks[t.key] = nil
				}
			}
			
		})
		observer.setOnAudioTrackCallback(onAudioTrack)
		observer.setOnVideoTrackCallback(onVideoTrack)
		observer.setStartedReceivingCallback({
			pc,transciever in
			RTCLogEx(.info,"[PMX][Observer]started receiving cb called with \(transciever.receiver.track?.trackId)")
			
			if let track = transciever.receiver.track{
				let that = Unmanaged<PMXPeerConnectionDelegate>.takeUnretainedValue(it)
				if let streamId = that().track2Stream[track.trackId]{
					print("[PMX][Observer] has track",track,"and streamId",streamId)
					if track.kind == kRTCMediaStreamTrackKindVideo {
						if let track = track as? RTCVideoTrack{
							RTCLogEx(.info,"[PMX][Observer]Got a Video Track")
							that().onVideoTrack?(streamId, track)
						} else {
							RTCLogEx(.info,"[PMX][Observer]Couldn't cast media track as video track")
						}
					}
					else if track.kind == kRTCMediaStreamTrackKindAudio {
						if let track = track as? RTCAudioTrack{
							RTCLogEx(.info,"[PMX][Observer]Got an Audio Track")
								that().onAudioTrack?(streamId,track)
						}else{
							RTCLogEx(.info,"[PMX][Observer]Couldn't cast media track as audio track")
						}
					}
				} else {
					print("[PMX][Observer] has track",track,"and no streamID")
					that().unprocessedTracks[track.trackId] = track
				}
			}
		})
		
		return (self.peerConnectionFactory.peerConnection(
			with: RTCConfiguration(),
			constraints: RTCMediaConstraints.init(
				mandatoryConstraints: [:],
				optionalConstraints: nil),
			delegate: observer), observer)
	}
	
	private init(
		onTrickle: @escaping @Sendable (Int64,String) throws -> Void,
		peerConnectionFactory: RTCPeerConnectionFactory,
		onSetNewOfferOnReconfigure: @escaping @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void,
		onAcceptOfferOnReconfigure: @escaping @Sendable (Int64,privmx.endpoint.stream.SdpWithTypeModel) throws -> Void
	){
		self.onTrickle = onTrickle
		self.peerConnectionFactory = peerConnectionFactory
		self.setNewOfferOnReconfigure = onSetNewOfferOnReconfigure
		self.acceptOfferOnReconfigure = onAcceptOfferOnReconfigure
	}
	
	private func setCppCallbacksInSession(
	_ session: inout RoomJanusSession
	) {
		session.webRTCInstance = privmx.WRTCIIHolder(
			{ context in//CreateOfferAndSetLocalDescription
				nonisolated(unsafe)var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe)var result = privmx.StringWithError()
				nonisolated(unsafe)var done = false
				nonisolated(unsafe) let streamRoomId = context!.pointee.roomId
				Task.detached(){
					@Sendable in
					let jc = try this.getOrCreatePublisher()
					let pc = jc.peerConnection
					do{
						let res = try await pc.offer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]))
						result = privmx.StringWithError(
							result: std.string(res.sdp),
							isvalid: true,
							errname: "",
							errwhat: "")
						RTCLogEx(.info,"create offer set loc desc")
						try await pc.setLocalDescription(res)
						done=true
					} catch let err{
						result = privmx.StringWithError(
							result: "",
							isvalid: true,
							errname: "Failed creating SDP",
							errwhat: std.string(err.localizedDescription))
						done = true
					}
					
				}
				while !done {
					usleep(100)
				}
				return result
			},
			{ context in//CreateAnswerAndSetDescriptions
				nonisolated(unsafe) var result = privmx.StringWithError()
				nonisolated(unsafe) var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe) var done = false
				nonisolated(unsafe) let streamRoomId = context!.pointee.roomId,
										sdp = context!.pointee.sdp,
										type = context!.pointee.type
				//RTCLogEx(.info,sdp)
				Task.detached{
					@Sendable in
					defer {done = true}
					if let jc = try? this.getOrCreateSubscriber(){
						do{
							let lpa = try await jc.reconfigure(
								sdp: String(sdp),
								type: String(type),
								roomId: String(streamRoomId)
							)
							result.result = lpa.sdp
							result.isvalid = true
						}catch let err{
							result = privmx.StringWithError(
								result: "",
								isvalid: true,
								errname: std.string("\((err as? PrivMXEndpointError)?.getName() ?? "ERROR")"),
								errwhat: std.string("\((err as? PrivMXEndpointError)?.getDescription())")
							)
						}
					} else {
						result = privmx.StringWithError(
							result: "",
							isvalid: true,
							errname:"could not get a PeerConnection",
							errwhat: "")
					}
				}
				while !done {
					usleep(100)
				}
				return result
			},
			{context in//SetAnswerAndSetRemoteDescription
				//TODO: Impl saasrd
				nonisolated(unsafe) var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe) var res = privmx.InternalError()
				nonisolated(unsafe) var done = false
				nonisolated(unsafe) let streamRoomId = String(context!.pointee.roomId),
										sdp = String(context!.pointee.sdp),
										type = String(context!.pointee.type)
				
				Task.detached{@Sendable in
					do{
						try await this.getOrCreatePublisher()
							.reconfigure(
								sdp: sdp,
								type: type,
								roomId: streamRoomId)
					
					}catch let err{
						res = privmx.InternalError(
							name: "Error Updating Session",
							message: "",
							description: err.localizedDescription)
					}
					done = true
				}
				while !done {
					usleep(100)
				}
				return res
			},
			{ context in//UpdateSessionId
				RTCLogEx(RTCLoggingSeverity.info, "[PMX] Updating Session Id")
				var res = privmx.InternalError()
				var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				let streamRoomId = context!.pointee.roomId,
					sessionId = context!.pointee.sessionId,
					connectiontype = context!.pointee.connectionType,
					srid = String(streamRoomId)
				do{
					if connectiontype == "publisher"{
						try this.publisher?.updateSessionId(sessionId)
					} else if connectiontype == "subscriber" {
						try this.subscriber?.updateSessionId(sessionId)
					} else {
						res = privmx.InternalError(
							name: "Unknown ConnectionType",
							message: "", description: "")
					}
				}catch let err{
					res = privmx.InternalError(
						name: "Error Updating Session",
						message: "",
						description: err.localizedDescription)
				}
				return res
			},
			{ context in//UpdateKeys
				RTCLogEx(RTCLoggingSeverity.info, "[PMX] Updating Keys")
				var res = privmx.InternalError()
				var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				var nkeys = [PMXKSKey]()
				for k in context!.pointee.keys{
					let ktype = if k.type == privmx.endpoint.stream.LOCAL{PMXKSKeyType.LOCAL} else {PMXKSKeyType.REMOTE}
					let kkey = k.key.getData() ?? Data()
					nkeys.append(PMXKSKey.init(
						keyId: String(k.keyId),
						key: kkey,
						type:ktype)
					)
				}
				this.updateKeys(nkeys)
				
				return ""
			},
			{ context in//Close
				RTCLogEx(.info,"[PMX][swift][dbg][close] callback called")
				var res = privmx.InternalError()
				if nil != context{
					RTCLogEx(.info,"[PMX][swift][dbg][close] has context")
					var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeRetainedValue()
					RTCLogEx(.info,"[PMX][swift][dbg][close] has this from context")
					let streamRoomId = context!.pointee.roomId
					RTCLogEx(.info,"[PMX][swift][dbg][close] has roomid from context")
					let srid = String(streamRoomId)
					RTCLogEx(.info,"[PMX][swift][dbg][close] got values")
					do{
						try this.publisher?
							.peerConnection.close()
						RTCLogEx(.info,"[PMX][swift][dbg][close] closed publisher")
						try this.subscriber?
							.peerConnection.close()
						RTCLogEx(.info,"[PMX][swift][dbg][close] closed subscriber")
						
					}catch let err{
						res = privmx.InternalError(
							name: "Error Closing Session",
							message: "",
							description: err.localizedDescription)
						RTCLogEx(.info,"[PMX][swift][dbg][close] caught error")
					}
				} else {
					res.name = "Missing Context"
					RTCLogEx(.info,"[PMX][swift][dbg][close] Missing Context")
				}
				return res
			},
			Unmanaged.passRetained(session).toOpaque())

	}
	
}
