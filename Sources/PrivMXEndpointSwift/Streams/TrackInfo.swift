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

class AudioTrackInfo{
	init(track: RTCAudioTrack, sender: RTCRtpSender, frameCryptor: PMXFrameCryptorTransformer) {
		self.track = track
		self.sender = sender
		self.frameCryptor = frameCryptor
	}
	var track: RTCAudioTrack
	var sender: RTCRtpSender
	var frameCryptor: PMXFrameCryptorTransformer
}

class VideoTrackInfo{
	init(track: RTCVideoTrack, sender: RTCRtpSender, frameCryptor: PMXFrameCryptorTransformer) {
		self.track = track
		self.sender = sender
		self.frameCryptor = frameCryptor
	}
	var track: RTCVideoTrack
	var sender: RTCRtpSender
	var frameCryptor: PMXFrameCryptorTransformer
}

class DesktopTrackInfo{
	init(track: RTCVideoTrack, sender: RTCRtpSender, frameCryptor: PMXFrameCryptorTransformer) {
		self.track = track
		self.sender = sender
		self.frameCryptor = frameCryptor
	}
	var track : RTCVideoTrack
	var sender: RTCRtpSender
	var frameCryptor: PMXFrameCryptorTransformer
	
}
// #endif // Streams
