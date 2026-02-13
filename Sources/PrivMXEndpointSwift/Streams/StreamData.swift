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
import PrivMXEndpointSwiftNative
import WebRTC

final public class StreamData:@unchecked Sendable{
	public enum Status{
		case Offline,Online
	}
	
	public internal(set) var status: Status
	public internal(set) var roomId : String
	public internal(set) var trackIds: [String]
	
	init(
		roomId: String,
		trackIds:[String] = []
	){
		self.status = .Offline
		self.roomId = roomId
		self.trackIds = trackIds
	}
}
// #endif
