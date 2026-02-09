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

final class RoomSessionManager{
	private var rtcConfiguration: RTCConfiguration = RTCConfiguration()
	nonisolated(unsafe)var webRtcInstance: privmx.WRTCIIHolder!
	
	
	nonisolated(unsafe) var streamHandles: [privmx.endpoint.stream.StreamHandle:String] = [:]
	nonisolated(unsafe) var roomSessions: [String:RoomJanusSession] = [:]
	
	private let onTrickle: @Sendable (Int64,String) throws -> Void
	let peerConnectionFactory: RTCPeerConnectionFactory
	private var initOptions: InitOptions?
	
	#if os(iOS)
	static func create(
		onTrickle: @escaping @Sendable (Int64,String) throws -> Void,
		audioHandler: AVAudioEngineRTCAudioDevice,
		options: InitOptions?
	) -> RoomSessionManager {
		var encf = RTCDefaultVideoEncoderFactory()
		
		encf.preferredCodec = .init(name: kRTCVp8CodecName)
		
		var mgr = RoomSessionManager(
			onTrickle: onTrickle,
			peerConnectionFactory: RTCPeerConnectionFactory(
				encoderFactory: encf,
			 decoderFactory: RTCDefaultVideoDecoderFactory(),
			 audioDevice: audioHandler)
		)
		mgr.initOptions = options
		setCppCallbacksInManager(&mgr)
		return mgr
	}
	#else
	static func create(
		onTrickle: @escaping @Sendable (Int64,String) throws -> Void,
		options: InitOptions? = nil
	) -> RoomSessionManager {
		var encf = RTCDefaultVideoEncoderFactory()
		
		encf.preferredCodec = .init(name: kRTCVp8CodecName)
		
		var mgr = RoomSessionManager(
			onTrickle: onTrickle,
			peerConnectionFactory: RTCPeerConnectionFactory(
				encoderFactory: encf,
			 decoderFactory: RTCDefaultVideoDecoderFactory())
		)
		//setCppCallbacksInManager(&mgr)
		mgr.initOptions = options
		return mgr
	}
	#endif
	
	func addRoomSessionFor(
		_ roomId: String
	) throws -> Void {
		guard roomSessions[roomId] == nil
		else {
			throw PrivMXEndpointError.otherFailure(.init(
				name: "Room Session already exists",
				message: "",
				description: "")
			)
		}
		var ks = PMXKeyStore()
		var rjs = RoomJanusSession(
			keyStore: ks,
			roomId: roomId,
			_getPeerConnectionWithDelegate:{
				return self.createPeerConnection(keyStore: &ks,streamRoomId: roomId)
			}
		)
		setCppCallbacksInSession(&rjs)
		roomSessions[roomId] = rjs
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
		
		guard var sender = pub.peerConnection.add(track, streamIds: [roomId])
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create sender",
					message: "", description: ""
				)
			)
		}
		
		guard var cryptor = PMXFrameCryptorTransformer(
			for: sender,
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
			sender: sender,
			frameCryptor: cryptor)
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
		
		guard var sender = pub.peerConnection.add(track, streamIds: [roomId])
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create sender",
					message: "", description: ""
				)
			)
		}
		
		guard var cryptor = PMXFrameCryptorTransformer(
			for: sender,
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
			sender: sender,
			frameCryptor: cryptor)
	}
	var onATrack: ((String,RTCAudioTrack) -> Void)?
	func setAudioStreamsHandler(
	_ handler: ((String,RTCAudioTrack) -> Void)?
	) -> Void{
		self.onATrack = handler
	}
	var onVTrack: ((String,RTCVideoTrack) -> Void)?
	func setVideoStreamsHandler(
	_ handler: ((String,RTCVideoTrack) -> Void)?
	) -> Void{
		self.onVTrack = handler
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
		observer.setOnAudioTrackCallback(onATrack)
		observer.setOnVideoTrackCallback(onVTrack)
		return (self.peerConnectionFactory.peerConnection(
			with: RTCConfiguration(),
			constraints: RTCMediaConstraints.init(
				mandatoryConstraints: [:],
				optionalConstraints: nil),
			delegate: observer), observer)
	}
	
	private init(
		onTrickle: @escaping @Sendable (Int64,String) throws -> Void,
		peerConnectionFactory: RTCPeerConnectionFactory
	){
		self.onTrickle = onTrickle
		self.peerConnectionFactory = peerConnectionFactory
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
						print("create offer set loc desc")
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
				//print(sdp)
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
								errname: std.__1.string("\((err as? PrivMXEndpointError)?.getName() ?? "ERROR")"),
								errwhat: std.__1.string("\((err as? PrivMXEndpointError)?.getDescription())")
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
				
				//print(sdp)
				Task.detached{@Sendable in
					do{
						print("set answer and set rem desc")
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
				print("update sessionid")
				var res = privmx.InternalError()
				var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				let streamRoomId = context!.pointee.roomId,
					sessionId = context!.pointee.sessionId,
					connectiontype = context!.pointee.connectionType,
					srid = String(streamRoomId)
				do{
					if connectiontype == ConnectionType.Publisher.rawValue{
						try this.publisher?.updateSessionId(sessionId)
					} else if connectiontype == ConnectionType.Subscriber.rawValue {
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
				print("Updating Keys")
				var res = privmx.InternalError()
				var this = Unmanaged<RoomJanusSession>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				var nkeys = [PMXKSKey]()
				//var dbug = 0
				for k in context!.pointee.keys{
					let ktype = if k.type == privmx.endpoint.stream.LOCAL{PMXKSKeyType.LOCAL} else {PMXKSKeyType.REMOTE}
					let kkey = k.key.getData() ?? Data()
					//print("converted to", kkey.count, "sized Data")
					//print("got key \(k.type) id \(k.keyId) : \(privmx.endpoint.core.Hex.encode(k.key))")
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
				var this = Unmanaged<RoomJanusSession>.fromOpaque(context!).takeUnretainedValue()
				var res = privmx.InternalError()
				let streamRoomId = context!.pointee.roomId
				let srid = String(streamRoomId)
				do{
					try this.publisher?
						.peerConnection.close()
					
					try this.subscriber?
						.peerConnection.close()
					
				}catch let err{
					res = privmx.InternalError(
						name: "Error Updating Session",
						message: "",
						description: err.localizedDescription)
				}
				return res
			},
			Unmanaged.passUnretained(session).toOpaque())

	}
	
}
