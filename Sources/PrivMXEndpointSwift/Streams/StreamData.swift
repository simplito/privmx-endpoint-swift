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
import PrivMXEndpointSwiftNative
import PrivMXEndpointStreamsLow
import WebRTC

final class StreamData:Sendable{
	init(
		capturers: [Int64:RTCVideoCapturer]
	){
		self.capturers = MutexGuarded<[Int64:RTCVideoCapturer]>(capturers)
	}
	nonisolated(unsafe) var capturers : MutexGuarded<[Int64:RTCVideoCapturer]>
	
}
#endif
