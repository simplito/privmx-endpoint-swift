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


public enum ConnectionType:Sendable{
	case Subscriber
	case Publisher
}

public class PeerConnection: @unchecked Sendable{
	var rtcPeerConnection: RTCPeerConnection
	var rtcPeerConnectionObserver: PmxPeerConnectionObserver
	var audioTracks = MutexGuarded<[String:AudioTrackInfo]>([:])
	var videoTracks = MutexGuarded<[String:VideoTrackInfo]>([:])
	var keys : PMXKeyStore
	
	init(rtcPeerConnection: RTCPeerConnection,
		 rtcPeerConnectionObserver: PmxPeerConnectionObserver,
		 keys: PMXKeyStore
	) {
		self.rtcPeerConnection = rtcPeerConnection
		self.rtcPeerConnectionObserver = rtcPeerConnectionObserver
		self.rtcPeerConnection.delegate = self.rtcPeerConnectionObserver
		self.keys = keys
	}
	
}

#endif // Streams
