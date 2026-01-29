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

//#if Streams
import WebRTC
import AVFoundation

public final class PMXAudioPlayer: NSObject, RTCAudioRenderer{
	public let node: AVAudioPlayerNode = AVAudioPlayerNode()
	public func render(pcmBuffer: AVAudioPCMBuffer) {
		do{
			try node.scheduleBuffer(pcmBuffer) {
				print("scheduled")
			}
		}catch {
			print(error)
		}
	}
}
//#endif
