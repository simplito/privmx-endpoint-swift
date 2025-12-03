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

import os.lock

public final class MutexGuarded<T>:Sendable{
	init(_ value: T) {
		self._value = value
	}
	let lock = OSAllocatedUnfairLock()
	nonisolated(unsafe) private var _value : T
	
	public var value: T {
		get {
			lock.lock()
			defer{lock.unlock()}
			return _value
			
		}
		set {
			lock.lock()
			_value = newValue
			lock.unlock()
		}
	}
	
}
