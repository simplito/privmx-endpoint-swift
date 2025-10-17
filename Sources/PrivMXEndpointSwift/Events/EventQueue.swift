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

import Foundation
import PrivMXEndpointSwiftNative

/// Swift wrapper for `privmx.NativeEventQueueWrapper`, providing functionality to interact with the event queue within PrivMX platform.
public class EventQueue {
	
	/// Instance of the native event queue wrapper.
	package var api: privmx.NativeEventQueueWrapper
	
	/// Initializes a new `EventQueue` with the provided native wrapper.
	///
	/// - Parameter api: An instance of `privmx.NativeEventQueueWrapper` to initialize the event queue.
	private init(api: privmx.NativeEventQueueWrapper) {
		self.api = api
	}
	
	/// Gets the EventQueue instance.
	///
	/// - Returns: EventQueue object
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingEventQueue` if an error occurs while instantiating the event queue.
	public static func getInstance(
	) throws -> EventQueue{
		let res = privmx.NativeEventQueueWrapper.getInstance()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedInstantiatingEventQueue(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedInstantiatingEventQueue(err)
		}
		return EventQueue(api: result)
	}
	
	/// Puts the break event on the events queue.
	///
	/// You can use it to break the `waitEvent` loop.
	///
	/// - Throws: `PrivMXEndpointError.failedEmittingBreakEvent` if an error occurs during event emission.
	public func emitBreakEvent(
	) throws -> Void{
		let res = api.emitBreakEvent()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEmittingBreakEvent(res.error.value!)
		}
	}
	
	/// Starts a loop waiting for an Event.
	///
	/// - Returns: EventHolder object
	///
	/// - Throws: `PrivMXEndpointError.failedWaitingForEvent` if an error occurs while waiting for the event.
	public func waitEvent(
	) throws -> privmx.endpoint.core.EventHolder{
		let res = api.waitEvent()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWaitingForEvent(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedWaitingForEvent(err)
		}
		return result
	}
	
	/// Gets the first event from the events queue.
	/// 
	/// - Returns: EventHolder object (optional)
	/// 
	/// - Throws: `PrivMXEndpointError.failedGettingEvent` if an error occurs while retrieving the event.
	public func getEvent(
	) throws -> privmx.endpoint.core.EventHolder?{
		let res = api.getEvent()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingEvent(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingEvent(err)
		}
		return result.value
	}
	
}
