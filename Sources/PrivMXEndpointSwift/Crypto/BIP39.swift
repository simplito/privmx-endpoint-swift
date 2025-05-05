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

public struct BIP39{
	
	internal var wrapped: privmx.endpoint.crypto.BIP39_t
	
	public var ext_key:ExtKey
	
	public var mnemonic:std.string{
		get{
			wrapped.mnemonic
		}
		set(val){
			wrapped.mnemonic = val
		}
	}
	
	public var entropy: privmx.endpoint.core.Buffer{
		get{
			wrapped.entropy
		}
		set(val){
			wrapped.entropy = val
		}
	}
	
	init(wrapping: privmx.endpoint.crypto.BIP39_t) {
		self.wrapped = wrapping
		self.ext_key = ExtKey(wrapped:wrapping.ext_key)
	}
	
}
