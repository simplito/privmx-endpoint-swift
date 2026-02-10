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
#if os(macOS)
import ScreenCaptureKit
#endif
import WebRTC

public enum TrackType:Equatable{
	case Audio(Id:String)
	case Video(Id:String)
	#if os(macOS)
	case Desktop(Id:String,filter: SCContentFilter)
	#else
	case Desktop(Id:String)
	#endif
	func getId(
	) -> String {
		switch self{
#if os(macOS)
			case .Audio(let id),
					.Desktop(let id,_),
					.Video(let id):
				return id
#else
			case .Audio(let id),
					.Desktop(let id),
					.Video(let id):
				return id
#endif
		}
	}
	#if os(macOS)
	func getFilter(
	) -> SCContentFilter?{
		switch self {
			case .Desktop(_,let filter):filter
			default: nil
		}
	}
	#endif
}
