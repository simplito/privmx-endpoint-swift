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
	private var api: privmx.NativeEventQueueWrapper
	
	/// Initializes a new `EventQueue` with the provided native wrapper.
	///
	/// - Parameter api: An instance of `privmx.NativeEventQueueWrapper` to initialize the event queue.
	private init(api: privmx.NativeEventQueueWrapper) {
		self.api = api
	}
	
	/// Retrieves a singleton instance of `EventQueue`.
	///
	/// This method attempts to access the global instance of `EventQueue`, ensuring only one instance
	/// of the event queue wrapper exists. It should be used whenever event queue interaction is needed.
	///
	/// - Returns: The singleton `EventQueue` instance.
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
	
	/// Inserts a special break event into the event queue.
	///
	/// This method emits a special event, `privmx.endpoint.core.libBreakEvent`, into the event queue.
	/// This break event can be used to interrupt or signal specific conditions in the event processing flow.
	///
	/// - Throws: `PrivMXEndpointError.failedEmittingBreakEvent` if an error occurs during event emission.
	public func emitBreakEvent(
	) throws -> Void{
		let res = api.emitBreakEvent()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEmittingBreakEvent(res.error.value!)
		}
	}
	
	/// Waits for the next event in the queue.
	///
	/// This method will pause and wait until a new event arrives in the queue. If there are
	/// any unprocessed events already in the queue, it will return the first unprocessed event.
	/// The returned event should be queried using `is*Event` methods and extracted with the appropriate method.
	///
	/// - Returns: An `EventHolder` object containing the next available event.
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
	
	/// Attempts to retrieve the next unprocessed event from the queue.
	///
	/// This method retrieves the next unprocessed event from the queue without waiting. If there are
	/// no unprocessed events, it will simply return `nil`. The returned event, if present, should be
	/// queried using `is*Event` methods and extracted with the appropriate method.
	///
	/// - Returns: An `EventHolder` containing the next unprocessed event, or `nil` if no unprocessed events are available.
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
