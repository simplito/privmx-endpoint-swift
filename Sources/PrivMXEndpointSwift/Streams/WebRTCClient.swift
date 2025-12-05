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
@preconcurrency import WebRTC

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
	//var initOptions: InitOptions
	
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
			
			return self.peerConnectionFactory.peerConnection(
				with: RTCConfiguration(),
				constraints: RTCMediaConstraints.init(
					mandatoryConstraints: [:],
					optionalConstraints: nil),
				delegate: observer)
		}
	}
	
	init(){
		self.webRtcInstance = privmx.WebRtcInterfaceInstance(
			{ streamRoomId in//CreateOfferAndSetLocalDescription
				var result: privmx.StringWithError
				if let pc = try? self.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Publisher).peerConnection{
					pc.offer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]), completionHandler: {
						res, err in
						if let sdp = res?.sdp{
							result = privmx.StringWithError(
								result: privmx.makeOptional(std.string(sdp)),
								error: nil)
						} else if let err{
							result = privmx.StringWithError(
								result: nil,
								error: privmx.makeOptional(privmx.InternalError(
									name:"Failed creating SDP",
									message: "",
									description: err.localizedDescription)))
						} else {
							result = privmx.StringWithError(
								result: nil,
								error: privmx.makeOptional(privmx.InternalError(
									name:"Failed creating SDP",
									message: "",
									description: "Unknown error, both result and  error were nil")))
						}
						
					})
					return result
				}
				
				return privmx.StringWithError(
					result: nil,
					error: privmx.makeOptional(privmx.InternalError(
						name:"Failed creating SDP",
						message: "",
						description: "Unknown error: PeerConnection was nil")))
			},
			{ streamRoomId, sdp, type in//CreateAnswerAndSetDescriptions
				var result: privmx.StringWithError
				if let pc = try? self.peerConnectionManager.getConnectionWithSession(streamRoomId: String(streamRoomId), connectionType: .Publisher).peerConnection{
					pc.answer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: [:]), completionHandler: {
						desc, err in
						if let err{
							
						} else if let desc{
							pc.setLocalDescription(desc){
								 err2 in
								if let err2{
									result = privmx.StringWithError(
										result: nil,
										error: privmx.makeOptional(privmx.InternalError(
											name:"Failed creating SDP",
											message: "",
											description: err2.localizedDescription)))
								}else{
									result = privmx.StringWithError(
										result: privmx.makeOptional(std.string(desc.sdp)),
										error: nil)
								}
							}
						} else {
							
						}
					})
				}
				// some solution for the above warnings might be needed
				return result
			},
			{ streamRoomId, sdp, type in//SetAnswerAndSetRemoteDescription
				//TODO: Impl saasrd
			},
			{ streamRoomId, sessionId, connectiontype in//UpdateSessionId
				//TODO: Impl us
			},
			{ steramRoomId, keys in//UpdateKeys
				//TODO: Impl uk
				var nkeys = [PMXKSKey]()
				for k in keys{
					nkeys.append(PMXKSKey.init(native: k))
				}
				for c in self.peerConnectionManager.connections.value{
					for peer in c.value.values{
						
						(peer.peerConnection.delegate as? PmxPeerConnectionObserver)?.currentKeys.setKeys(nkeys)
					}
				}
			},
			{ streamRoomId in//Close
				//TODO: Impl c
			})
		self.peerConnectionManager = PeerConnectionManager()
	}
	
	func addAudioTrack(){}
	func addVideoTrack(){}
	func addDesktopTrack(){}
}
#endif
