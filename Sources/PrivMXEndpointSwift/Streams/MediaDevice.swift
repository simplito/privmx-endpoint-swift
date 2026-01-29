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

import ScreenCaptureKit

public enum TrackType:Equatable{
	case Audio(Id:String)
	case Video(Id:String)
	case Desktop(Id:String,filter: SCContentFilter)
	
	func getId(
	) -> String {
		switch self{
				case .Audio(let id),
					.Desktop(let id,_),
					.Video(let id):
				return id
		}
	}
	
	func getFilter(
	) -> SCContentFilter?{
		switch self {
			case .Desktop(_,let filter):filter
			default: nil
		}
	}
}
