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

// #if Streams
import Foundation
import WebRTC
import PrivMXEndpointStreamsLow

public struct DataChannelMeta: Hashable{
	var name: String
	// TODO: fill Data Channel Metadata
}
public struct StreamTrackInfo:Hashable,Identifiable{
	public var id: String
	var streamId:String? = nil
	var streamHandle: privmx.endpoint.stream.StreamHandle
	public var track: RTCMediaStreamTrack? = nil
	var cameraCapturer: RTCCameraVideoCapturer? = nil
	var desktopCapturer: RTCDesktopCapturer? = nil
	var dataChannelMeta: DataChannelMeta? = nil
	var published: Bool
	var markedToRemove: Bool? = nil
}
// #endif // Streams
