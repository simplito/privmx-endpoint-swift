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

final class WebRTCClient: Sendable{
	private let peerConnectionManager: PeerConnectionManager
	private let webRtcInstance: privmx.WebRtcInterfaceInstance
	
	nonisolated(unsafe) var peerConnectionFactory = RTCPeerConnectionFactory()
	
	func bindTrickleImpl(
		_ trickleImpl:@escaping @Sendable (Int64,String)->Void
	) {
		peerConnectionManager._onTrickle = trickleImpl
	}
	
	init(){
		self.webRtcInstance = privmx.WebRtcInterfaceInstance(
			{ streamRoomId in//CreateOfferAndSetLocalDescription
				var res = std.string()
				//TODO: Impl coasld
				return res
			},
			{ streamRoomId, sdp, type in//CreateAnswerAndSetDescriptions
				var res = std.string()
				//TODO: Impl caasd
				return res
			},
			{ streamRoomId, sdp, type in//SetAnswerAndSetRemoteDescription
				//TODO: Impl saasrd
			},
			{ streamRoomId, sessionId, connectiontype in//UpdateSessionId
				//TODO: Impl us
			},
			{ steramRoomId, keys in//UpdateKeys
				//TODO: Impl uk
			},
			{ streamRoomId in//Close
				//TODO: Impl c
			})
		self.peerConnectionManager = PeerConnectionManager(
			_createPeerConnection: { streamRoomId in
				var observer = PmxPeerConnectionObserver(
					streamRoomId: streamRoomId,
					peerConnectionFactory: self.peerConnectionFactory)
				if var pc = self.peerConnectionFactory.peerConnection(
					with: RTCConfiguration(),
					constraints: RTCMediaConstraints.init(
						mandatoryConstraints: [:],
						optionalConstraints: nil),
					delegate: observer){
					return RTCPeerConnection(
						rtcPeerConnection:pc,
						rtcPeerConnectionObserver: observer,
						keys: PMXKeyStore())
				},
				_onTrickle: T##(Int64, String) throws -> Void)
			})
	}
}
#endif
