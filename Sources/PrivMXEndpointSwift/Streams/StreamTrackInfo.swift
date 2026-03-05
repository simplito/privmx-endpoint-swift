//
// PrivMX Endpoint Swift
// Copyright © 2026 Simplito sp. z o.o.
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
import PrivMXEndpointSwiftNative

public struct DataChannelMeta: Hashable{
	var name: String
	// TODO: fill Data Channel Metadata or remove
}


public struct StreamTrackInfo:Hashable,Identifiable{
	public var id: String
	var streamId:String? = nil
	var streamHandle: privmx.endpoint.stream.StreamHandle
	public var track: RTCMediaStreamTrack? = nil
	var cameraCapturer: RTCCameraVideoCapturer? = nil
	#if os(macOS)
	var desktopCapturer: PMXDesktopCapturer? = nil
	#endif
	var dataChannelMeta: DataChannelMeta? = nil
	var published: Bool
	var markedToRemove: Bool? = nil
}

public struct AudioTrackInfo{
	public var track: RTCAudioTrack
	public var sender: RTCRtpSender
	public var frameCryptor: PMXFrameCryptorTransformer
	public var frameCryptorDelegate: PMXFrameCryptorObserver?
}

public struct VideoTrackInfo{
	public var track: RTCVideoTrack
	public var sender: RTCRtpSender
	public var frameCryptor: PMXFrameCryptorTransformer
	public var frameCryptorDelegate: PMXFrameCryptorObserver?
}
// #endif // Streams
