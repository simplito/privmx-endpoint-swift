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

import PrivMXEndpointSwiftNative
import Foundation

public final class KvdbApi: @unchecked Sendable{
	private var api:privmx.NativeKvdbApiWrapper
	init(api:privmx.NativeKvdbApiWrapper){
		self.api = api
	}
}
