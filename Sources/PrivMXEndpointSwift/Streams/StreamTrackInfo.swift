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

public struct DataChannelMeta: Hashable{
	var name: String
}

struct StreamTrackInfo:Hashable,Identifiable{
	var id: String
	var streamId:Stream? = nil
	var streamHandle: privmx.endpoint.stream.StreamHandle
	var track: RTCMediaStreamTrack? = nil
	var dataChannelMeta: DataChannelMeta? = nil
	var published: Bool
	var markedToRemove: Bool? = nil
}
#endif // Streams
