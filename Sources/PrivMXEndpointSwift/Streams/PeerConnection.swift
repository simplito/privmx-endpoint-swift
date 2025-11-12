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
import WebRTC

public class PeerConnection{
	let rtcPeerConnection: RTCPeerConnection
	let rtcPeerConnectionObserver: PmxPeerConnectionObserver
	
	init(rtcPeerConnection: RTCPeerConnection, rtcPeerConnectionObserver: PmxPeerConnectionObserver) {
		self.rtcPeerConnection = rtcPeerConnection
		self.rtcPeerConnectionObserver = rtcPeerConnectionObserver
	}
	
}

#endif
