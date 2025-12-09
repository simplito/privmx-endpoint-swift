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
	let peerConnectionManager: PeerConnectionManager
	let webRtcInstance: privmx.WebRtcInterfaceInstance
	
	var turnCredntials: [privmx.endpoint.stream.TurnCredentials] = []
	var clientId: String?
	var initOptions: InitOptions?
	
	var keyStore = PMXKeyStore()
	
	var lastProcessedAnswer: [String:privmx.endpoint.stream.SdpWithRoomModel]
	
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
	
	init(
		options:InitOptions? = nil
	){
		self.initOptions = options
		self.webRtcInstance = privmx.WebRtcInterfaceInstance(
			{ streamRoomId in//CreateOfferAndSetLocalDescription
				var result: privmx.StringWithError
				var done = false
				Task.detached(){
					if let pc = try? self.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Publisher).peerConnection{
						do{
						let res = try await pc.offer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]))
							result = privmx.StringWithError(
								result: privmx.makeOptional(std.string(res.sdp)),
								error: nil)
							done=true
						} catch let err{
							result = privmx.StringWithError(
								result: nil,
								error: privmx.makeOptional(privmx.InternalError(
									name:"Failed creating SDP",
									message: "",
									description: err.localizedDescription)))
							done = true
						}
						
					}
				}
				while !done {
					usleep(100)
				}
				return result
			},
			{ streamRoomId, sdp, type in//CreateAnswerAndSetDescriptions
				var result: privmx.StringWithError
				var done = false
				Task.detached{
					defer {done = true}
					if let pc = try? self.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Publisher).peerConnection{
						do{
							let desc = try await pc.answer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]))
							do{
								try await pc.setLocalDescription(desc)
								
								result = privmx.StringWithError(
									result: privmx.makeOptional(std.string(desc.sdp)),
									error: nil)
								
							}catch let err2{
								result = privmx.StringWithError(
									result: nil,
									error: privmx.makeOptional(privmx.InternalError(
										name:"Failed setting local desctiption",
										message: "",
										description: err2.localizedDescription)))
							}
						} catch let err {
							result = privmx.StringWithError(
								result: nil,
								error: privmx.makeOptional(privmx.InternalError(
									name:"Failed creating answer",
									message: "",
									description: err.localizedDescription)))
						}
					} else {
						result = privmx.StringWithError(
							result: nil,
							error: privmx.makeOptional(privmx.InternalError(
								name:"could not get a PeerConnection",
								message: "",
								description: "")))
					}
				}
				while !done {
					usleep(100)
				}
				return result
			},
			{ streamRoomId, sdp, type in//SetAnswerAndSetRemoteDescription
				//TODO: Impl saasrd
				var res = privmx.NullWithError()
				var done = false
				Task.detached{
					do{
						var pc = try self.peerConnectionManager.getConnectionWithSession(
							streamRoomId: String(streamRoomId),
							connectionType: .Publisher).peerConnection
						let tp:RTCSdpType? = switch type{
							case "answer":RTCSdpType.answer
							case "offer": RTCSdpType.offer
							case "pranswer":RTCSdpType.prAnswer
							case "rollback":RTCSdpType.rollback
							default:nil
						}
						if let tp{
							try await pc.setRemoteDescription(RTCSessionDescription(type: tp, sdp: String(sdp)))
						} else {
							res.error = privmx.makeOptional(privmx.InternalError(
								name: "Unknown type",
								message: "",
								description: "got \(type) but couldn't map it to RTCSdpType"))
						}
					}catch let err{
						res.error = privmx.makeOptional(privmx.InternalError(
							name: "Error Updating Session",
							message: "",
							description: err.localizedDescription))
					}
					done = true
				}
				while !done {
					usleep(100)
				}
				return res
			},
			{ streamRoomId, sessionId, connectiontype in//UpdateSessionId
				var res = privmx.NullWithError()
				do{
					if String(connectiontype) == ConnectionType.Publisher.rawValue{
						try self.peerConnectionManager.updateSessionForConnection(
							streamRoomId: String(streamRoomId),
							connectionType: .Publisher, sessionId: sessionId)
					} else if String(connectiontype) == ConnectionType.Subscriber.rawValue {
						try self.peerConnectionManager.updateSessionForConnection(
							streamRoomId: String(streamRoomId),
							connectionType: .Subscriber, sessionId: sessionId)
					} else {
						res.error = privmx.makeOptional(privmx.InternalError(
							name: "Unknown ConnectionType",
							message: "", description: ""))
					}
				}catch let err{
					res.error = privmx.makeOptional(privmx.InternalError(
						name: "Error Updating Session",
						message: "",
						description: err.localizedDescription))
				}
				return res
			},
			{ steramRoomId, keys in//UpdateKeys
				var res = privmx.NullWithError()
				var nkeys = [PMXKSKey]()
				for k in keys{
					nkeys.append(PMXKSKey.init(native: k))
				}
				for c in self.peerConnectionManager.connections.value{
					for peer in c.value.values{
						peer.delegate.currentKeys.setKeys(nkeys)
					}
				}
				return res
			},
			{ streamRoomId in//Close
				var res = privmx.NullWithError()
				do{
					try self.peerConnectionManager.getConnectionWithSession(
						streamRoomId: String(streamRoomId),
						connectionType: .Publisher)
					.peerConnection.close()
					
					try self.peerConnectionManager.getConnectionWithSession(
						streamRoomId: String(streamRoomId),
						connectionType: .Subscriber)
					.peerConnection.close()
				}catch let err{
					res.error = privmx.makeOptional(privmx.InternalError(
						name: "Error Updating Session",
						message: "",
						description: err.localizedDescription))
				}
				return res
			})
		self.peerConnectionManager = PeerConnectionManager()
	}
	
	func addAudioTrack(_ track: StreamTrackInfo){}
	func addVideoTrack(_ track: StreamTrackInfo){}
	func addDesktopTrack(_ track: StreamTrackInfo){}
}
#endif
