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
import Foundation
import WebRTC
import PrivMXEndpointStreamsLow

public final class JanusConnection: @unchecked Sendable{
	var peerConnection : RTCPeerConnection
	var sessionId: Int64
	var hasSubscriptions : Bool
	
	init(
		peerConnection: RTCPeerConnection,
		sessionId: Int64,
		hasSubscriptions: Bool
	) {
		self.peerConnection = peerConnection
		self.sessionId = sessionId
		self.hasSubscriptions = hasSubscriptions
	}
}
#endif // Streams
