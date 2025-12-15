//
// PrivMX Endpoint Swift
// Copyright © 2024 Simplito sp. z o.o.
//
// This file is part of PrivMX Platform (https://privmx.dev).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//
#if Streams

import PrivMXEndpointSwiftNative
import PrivMXEndpointStreamsLow
import Foundation
import WebRTC

struct InitOptions: @unchecked Sendable{
	var signalingServer: String
	var appServer: String
	var mediaServer: String
	var turnUrls: [URL]?
	var iceTransportPolicy: RTCIceTransportPolicy
	var encKey: String?
}

final class WebRTCClient: @unchecked Sendable{
	nonisolated(unsafe)let peerConnectionManager: PeerConnectionManager
	nonisolated(unsafe)var webRtcInstance: privmx.WRTCIIHolder?
	
	nonisolated(unsafe)var turnCredntials: [privmx.endpoint.stream.TurnCredentials] = []
	nonisolated(unsafe)var clientId: String?
	nonisolated(unsafe)var initOptions: InitOptions?
	
	nonisolated(unsafe)var keyStore = PMXKeyStore()
	nonisolated(unsafe)var constraints = RTCMediaConstraints.init(mandatoryConstraints: [:], optionalConstraints: nil)
	
	nonisolated(unsafe)var lastProcessedAnswer: [String:privmx.endpoint.stream.SdpWithRoomModel] = [:]
	
	nonisolated(unsafe) var peerConnectionFactory = RTCPeerConnectionFactory()
	
	func bindTrickleImpl(
		_ trickleImpl:@escaping @Sendable (Int64,String)->Void
	) {
		peerConnectionManager._onTrickle = trickleImpl
	}
	
	func bindCreatePeerConnectionImpl(
	) {
		peerConnectionManager._createPeerConnection = { streamRoomId in
			var observer = PmxPeerConnectionObserver(
				streamRoomId: streamRoomId,
				peerConnectionFactory: self.peerConnectionFactory,
				peerConnectionManager: self.peerConnectionManager
			)
			
			return (self.peerConnectionFactory.peerConnection(
				with: RTCConfiguration(),
				constraints: RTCMediaConstraints.init(
					mandatoryConstraints: [:],
					optionalConstraints: nil),
				delegate: observer), observer)
		}
	}
	
	static func create(
		with options: InitOptions? = nil
	) -> WebRTCClient{
		nonisolated(unsafe)var client = WebRTCClient(options:options)
		client.webRtcInstance = privmx.WRTCIIHolder(
			{ context in//CreateOfferAndSetLocalDescription
				nonisolated(unsafe)var this = Unmanaged<WebRTCClient>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe)var result = privmx.StringWithError()
				nonisolated(unsafe)var done = false
				nonisolated(unsafe) let streamRoomId = context!.pointee.roomId
				Task.detached(){
					@Sendable in
					if let pc = try? this.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Publisher).peerConnection{
						do{
							try pc.setLocalDescription(context!.pointee.)
						let res = try await pc.offer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]))
							result = privmx.StringWithError(
								result: std.string(res.sdp),
								isvalid: true,
							errname: "",
							errwhat: "")
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
				}
				while !done {
					usleep(100)
				}
				return result
			},
			{ context in//CreateAnswerAndSetDescriptions
				nonisolated(unsafe) var result = privmx.StringWithError()
				nonisolated(unsafe) var this = Unmanaged<WebRTCClient>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe) var done = false
				nonisolated(unsafe) let streamRoomId = context!.pointee.roomId,
										sdp = context!.pointee.sdp,
										type = context!.pointee.type
				Task.detached{
					@Sendable in
					defer {done = true}
					if let pc = try? this.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Subscriber).peerConnection{
						do{
							this.reconfigurePeerConnection(room: String(streamRoomId), sdp: String(sdp), type: type)
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
				nonisolated(unsafe) var this = Unmanaged<WebRTCClient>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				nonisolated(unsafe) var res = privmx.InternalError()
				nonisolated(unsafe) var done = false
				nonisolated(unsafe) let streamRoomId = context!.pointee.roomId,
										sdp = context!.pointee.sdp,
										type = context!.pointee.type
				Task.detached{@Sendable in
					do{
						let tp: RTCSdpType = switch type {
							case "answer","Answer":
								.answer
							case "PrAnswer","pranswer":
								.prAnswer
							case "Offer","offer":
								.offer
							case "rollback","Rollback":
								.rollback
							default:
								throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "Unknown Type", message: "", description: "got \(type) but couldn't map it to RTCSdpType"))
						}
						await this.reconfigurePeerConnection(room: String(streamRoomId), sdp: String(sdp), type: tp)
						
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
				var res = privmx.InternalError()
				var this = Unmanaged<WebRTCClient>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				let streamRoomId = context!.pointee.roomId,
					sessionId = context!.pointee.sessionId,
					connectiontype = context!.pointee.connectionType
				do{
					if String(connectiontype) == ConnectionType.Publisher.rawValue{
						try this.peerConnectionManager.updateSessionForConnection(
							streamRoomId: String(streamRoomId),
							connectionType: .Publisher, sessionId: sessionId)
					} else if String(connectiontype) == ConnectionType.Subscriber.rawValue {
						try this.peerConnectionManager.updateSessionForConnection(
							streamRoomId: String(streamRoomId),
							connectionType: .Subscriber, sessionId: sessionId)
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
				var res = privmx.InternalError()
				var this = Unmanaged<WebRTCClient>.fromOpaque(context!.pointee.context).takeUnretainedValue()
				print("!2")
				var nkeys = [PMXKSKey]()
				var dbug = 0
				for k in context!.pointee.keys{
					print("!3.\(dbug)")
					let ktype = if k.type == privmx.endpoint.stream.LOCAL{PMXKSKeyType.LOCAL} else {PMXKSKeyType.REMOTE}
					if let kkey = k.key.getString(){
						nkeys.append(PMXKSKey.init(
							keyId: String(k.keyId),
							key: kkey,
							type:ktype)
						)
					}
					dbug += 1
				}
				for c in this.peerConnectionManager.connections[String(context!.pointee.roomId)] ?? [:]{
					c.value.delegate.currentKeys.setKeys(nkeys)
				}
				//for c in this.peerConnectionManager.connections.value{
				//	var dbug = 0
				//	print("!4.\(dbug)")
				//	for peer in c.value.values{
				//		peer.delegate.currentKeys.setKeys(nkeys)
				//	}
				//	dbug += 1
				//}
				return ""
			},
			{ context in//Close
				var this = Unmanaged<WebRTCClient>.fromOpaque(context!).takeUnretainedValue()
				var res = privmx.InternalError()
				let streamRoomId = context!.pointee.roomId
				do{
					try this.peerConnectionManager.getConnectionWithSession(
						streamRoomId: String(streamRoomId),
						connectionType: .Publisher)
					.peerConnection.close()
					
					try this.peerConnectionManager.getConnectionWithSession(
						streamRoomId: String(streamRoomId),
						connectionType: .Subscriber)
					.peerConnection.close()
				}catch let err{
					res = privmx.InternalError(
						name: "Error Updating Session",
						message: "",
						description: err.localizedDescription)
				}
				return res
			},
			Unmanaged.passUnretained(client).toOpaque())
		return client
	}
	
	private init(
		options:InitOptions? = nil
	){
		self.initOptions = options
		self.peerConnectionManager = PeerConnectionManager()
		
	}
	
	private func reconfigurePeerConnection(
		room:String,
		sdp: String,
		type: String
	) async throws -> Void{
		let tp: RTCSdpType = switch type {
			case "answer","Answer":
					.answer
			case "PrAnswer","pranswer":
					.prAnswer
			case "Offer","offer":
					.offer
			case "rollback","Rollback":
					.rollback
			default:
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "Unknown Type", message: "", description: "got \(type) but couldn't map it to RTCSdpType"))
		}
		
		var pc = try self.peerConnectionManager.getConnectionWithSession(
			streamRoomId: String(room),
			connectionType: .Subscriber).peerConnection
		
		try await pc.setRemoteDescription(RTCSessionDescription(type: tp, sdp: String(sdp)))
		
		let ans = try await pc.answer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: nil))
		
		self.lastProcessedAnswer[room] = privmx.endpoint.stream.SdpWithRoomModel(roomId: std.__1.string(room), sdp: std.__1.string(sdp), type: std.__1.string(type))
	}
		
	
	func addAudioTrack(
		_ track: inout StreamTrackInfo,
		in streamRoomId: String
	){
		var pc = self.peerConnectionManager.connections[streamRoomId]?[.Publisher]?.peerConnection
		pc?.add(
			track.track!,
			streamIds: [track.streamId!])
		track.published = true
		var source = peerConnectionFactory.audioSource(with: constraints)
		
	}
	func addVideoTrack(_ track: StreamTrackInfo){}
	func addDesktopTrack(_ track: StreamTrackInfo){}
}

#endif
