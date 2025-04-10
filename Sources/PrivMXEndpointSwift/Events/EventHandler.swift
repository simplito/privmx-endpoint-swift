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

/// `EventHandler` is a collection of static methods that provide type-checking and event extraction capabilities for events held within `EventHolder` objects.
/// These methods verify if specific events, such as connection and disconnection events, are contained within an `EventHolder`,
/// and extract the events if present. It acts as a Swift wrapper for PrivMX Core Event handling mechanisms.
public enum EventHandler{
	
	/// Checks if the `EventHolder` contains a `LibConnectedEvent`.
	///
	/// This method queries the provided `EventHolder` to determine if it contains an event that corresponds to a `LibConnectedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the `EventHolder` contains a `LibConnectedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isLibConnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.CoreEventHandlerWrapper.isLibConnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `LibDisconnectedEvent`.
	///
	/// This method queries the provided `EventHolder` to determine if it contains an event that corresponds to a `LibDisconnectedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the `EventHolder` contains a `LibDisconnectedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isLibDisconnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.CoreEventHandlerWrapper.isLibDisconnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `LibPlatformDisconnectedEvent`.
	///
	/// This method queries the provided `EventHolder` to determine if it contains an event that corresponds to a `LibPlatformDisconnectedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the `EventHolder` contains a `LibPlatformDisconnectedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isLibPlatformDisconnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.CoreEventHandlerWrapper.isLibPlatformDisconnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `LibConnectedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `LibConnectedEvent`.
	/// - Returns: The extracted `LibConnectedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractLibConnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibConnectedEvent {
		let res = privmx.CoreEventHandlerWrapper.extractLibConnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `LibDisconnectedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `LibDisconnectedEvent`.
	/// - Returns: The extracted `LibDisconnectedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractLibDisconnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibDisconnectedEvent {
		let res = privmx.CoreEventHandlerWrapper.extractLibDisconnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `LibPlatformDisconnectedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `LibPlatformDisconnectedEvent`.
	/// - Returns: The extracted `LibPlatformDisconnectedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractLibPlatformDisconnectedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibPlatformDisconnectedEvent {
		let res = privmx.CoreEventHandlerWrapper.extractLibPlatformDisconnectedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `LibBreakEvent`.
	///
	/// This method queries the provided `EventHolder` to determine if it contains a `LibBreakEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the `EventHolder` contains a `LibBreakEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isLibBreakEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool{
		let res = privmx.CoreEventHandlerWrapper.isLibBreakEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `LibBreakEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `LibBreakEvent`.
	/// - Returns: The extracted `LibBreakEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractLibBreakEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibBreakEvent{
		let res = privmx.CoreEventHandlerWrapper.extractLibBreakEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreCreatedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreCreatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreCreatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreUpdatedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreUpdatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreUpdatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreDeletedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreDeletedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreDeletedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreStatsChangedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreStatsChangedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreStatsChangedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreStatsChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreStatsChangedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreFileCreatedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreFileCreatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreFileCreatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreFileCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreFileCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreFileUpdatedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreFileUpdatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreFileUpdatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreFileUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreFileUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `StoreFileDeletedEvent`.
	///
	/// This method queries the provided `EventHolder` instance to determine if it holds an event
	/// that corresponds to a `StoreFileDeletedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance to be queried.
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreFileDeletedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in querying the event.
	public static func isStoreFileDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StoreEventHandler.isStoreFileDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreCreatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreCreatedEvent`.
	/// - Returns: The extracted `StoreCreatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreCreatedEvent {
		let res = privmx.StoreEventHandler.extractStoreCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreCreatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreCreatedEvent`.
	/// - Returns: The extracted `StoreCreatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreUpdatedEvent {
		let res = privmx.StoreEventHandler.extractStoreUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreDeletedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreDeletedEvent`.
	/// - Returns: The extracted `StoreDeletedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreDeletedEvent {
		let res = privmx.StoreEventHandler.extractStoreDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreStatsChangedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreStatsChangedEvent`.
	/// - Returns: The extracted `StoreStatsChangedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreStatsChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreStatsChangedEvent {
		let res = privmx.StoreEventHandler.extractStoreStatsChangedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreFileCreatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreFileCreatedEvent`.
	/// - Returns: The extracted `StoreFileCreatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreFileCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileCreatedEvent {
		let res = privmx.StoreEventHandler.extractStoreFileCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreFileUpdatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreFileUpdatedEvent`.
	/// - Returns: The extracted `StoreFileUpdatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreFileUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileUpdatedEvent {
		let res = privmx.StoreEventHandler.extractStoreFileUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts a `StoreFileDeletedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` containing a `StoreFileDeletedEvent`.
	/// - Returns: The extracted `StoreFileDeletedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractStoreFileDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileDeletedEvent {
		let res = privmx.StoreEventHandler.extractStoreFileDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	
	/// Checks if the `EventHolder` contains a `ThreadCreatedEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadCreatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadCreatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadUpdatedEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadUpdatedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadUpdatedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadDeletedEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadDeletedEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadDeletedEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadStatsEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadStatsEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadStatsEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadStatsEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadStatsEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadNewMessageEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadNewMessageEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadNewMessageEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadNewMessageEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadNewMessageEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadDeletedMessageEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadDeletedMessageEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadDeletedMessageEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	@available(*, deprecated, renamed: "isThreadMessageDeletedEvent(eventHolder:)", message: "This method has been renamed")
	public static func isThreadDeletedMessageEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadDeletedMessageEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadMessageEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadDeletedMessageEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadDeletedMessageEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadMessageDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadMessageDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Checks if the `EventHolder` contains a `ThreadDeletedMessageEvent`.
	///
	/// This method verifies whether the provided `EventHolder` instance contains an event
	/// that corresponds to a `privmx.endpoint.thread.ThreadDeletedMessageEvent`.
	///
	/// - Parameter eventHolder: The `EventHolder` instance containing an event to check.
	/// - Returns: `true` if the `EventHolder` contains a `ThreadDeletedMessageEvent`; otherwise, `false`.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs during querying.
	public static func isThreadMessageUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.ThreadEventHandler.isThreadMessageUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	
	/// Extracts a `ThreadCreatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadCreatedEvent`.
	/// - Returns: The extracted `ThreadCreatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadCreatedEvent {
		let res = privmx.ThreadEventHandler.extractThreadCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadUpdatedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadUpdatedEvent`.
	/// - Returns: The extracted `ThreadUpdatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadUpdatedEvent {
		let res = privmx.ThreadEventHandler.extractThreadUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadDeletedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadDeletedEvent`.
	/// - Returns: The extracted `ThreadDeletedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadDeletedEvent {
		let res = privmx.ThreadEventHandler.extractThreadDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadStatsEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadStatsEvent`.
	/// - Returns: The extracted `ThreadStatsEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadStatsEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadStatsChangedEvent {
		let res = privmx.ThreadEventHandler.extractThreadStatsEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadNewMessageEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadNewMessageEvent`.
	/// - Returns: The extracted `ThreadNewMessageEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadNewMessageEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadNewMessageEvent {
		let res = privmx.ThreadEventHandler.extractThreadNewMessageEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	/// Extracts a `ThreadDeletedMessageEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadDeletedMessageEvent`.
	/// - Returns: The extracted `ThreadDeletedMessageEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	@available(*, deprecated, renamed: "extractThreadMessageDeletedEvent(eventHolder:)")
	public static func extractThreadDeletedMessageEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadMessageDeletedEvent {
		let res = privmx.ThreadEventHandler.extractThreadDeletedMessageEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadMessageDeletedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadMessageDeletedEvent`.
	/// - Returns: The extracted `ThreadMessageDeletedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadMessageDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadMessageDeletedEvent {
		let res = privmx.ThreadEventHandler.extractThreadMessageDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Extracts a `ThreadMessageDeletedEvent` from the provided `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the `ThreadMessageUpdatedEvent`.
	/// - Returns: The extracted `ThreadMessageUpdatedEvent`.
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if extraction fails.
	public static func extractThreadMessageUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadMessageUpdatedEvent {
		let res = privmx.ThreadEventHandler.extractThreadMessageUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder indicates an inbox creation.
	///
	/// This method checks if the event within the provided `EventHolder` instance represents
	/// an inbox creation event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is an inbox creation event (`true`) or not (`false`).
	public static func isInboxCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.InboxEventHandler.isInboxCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the inbox creation event from the provided event holder.
	///
	/// This method retrieves an `InboxCreatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `InboxCreatedEvent` containing the details of the created inbox event.
	public static func extractInboxCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxCreatedEvent {
		let res = privmx.InboxEventHandler.extractInboxCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder indicates an inbox update.
	///
	/// This method checks if the event within the provided `EventHolder` instance represents
	/// an inbox update event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is an inbox update event (`true`) or not (`false`).
	public static func isInboxUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.InboxEventHandler.isInboxUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the inbox update event from the provided event holder.
	///
	/// This method retrieves an `InboxUpdatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `InboxUpdatedEvent` containing the details of the updated inbox event.
	public static func extractInboxUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxUpdatedEvent {
		let res = privmx.InboxEventHandler.extractInboxUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder indicates an inbox deletion.
	///
	/// This method checks if the event within the provided `EventHolder` instance represents
	/// an inbox deletion event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is an inbox deletion event (`true`) or not (`false`).
	public static func isInboxDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.InboxEventHandler.isInboxDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the inbox deletion event from the provided event holder.
	///
	/// This method retrieves an `InboxDeletedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `InboxDeletedEvent` containing the details of the deleted inbox event.
	public static func extractInboxDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxDeletedEvent {
		let res = privmx.InboxEventHandler.extractInboxDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder indicates the creation of an inbox entry.
	///
	/// This method checks if the event within the provided `EventHolder` instance represents
	/// an inbox entry creation event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is an inbox entry creation event (`true`) or not (`false`).
	public static func isInboxEntryCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.InboxEventHandler.isInboxEntryCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the inbox entry creation event from the provided event holder.
	///
	/// This method retrieves an `InboxEntryCreatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `InboxEntryCreatedEvent` containing the details of the created inbox entry event.
	public static func extractInboxEntryCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxEntryCreatedEvent {
		let res = privmx.InboxEventHandler.extractInboxEntryCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder indicates the deletion of an inbox entry.
	///
	/// This method checks if the event within the provided `EventHolder` instance represents
	/// an inbox entry deletion event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is an inbox entry deletion event (`true`) or not (`false`).
	public static func isInboxEntryDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.InboxEventHandler.isInboxEntryDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the inbox entry deletion event from the provided event holder.
	///
	/// This method retrieves an `InboxEntryDeletedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `InboxEntryDeletedEvent` containing the details of the deleted inbox entry event.
	public static func extractInboxEntryDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxEntryDeletedEvent {
		let res = privmx.InboxEventHandler.extractInboxEntryDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder is a Custom Event.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a Custom Event.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isContextCustomEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.CustomEventHandler.isContextCustomEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `ContextCustomEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `ContextCustomEvent` that wa emitted by one of the users of the Context.
	public static func extractContextCustomEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.event.ContextCustomEvent {
		let res = privmx.CustomEventHandler.extractContextCustomEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder is a `KvdbCreatedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbCreatedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbCreatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbCreatedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbCreatedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	/// Determines if the event contained in the event holder is a `KvdbUpdatedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbUpdatedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbUpdatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbUpdatedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbUpdatedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

	/// Determines if the event contained in the event holder is a `KvdbStatsChangedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbStatsChangedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbStatsChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbStatsChangedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbStatsChangedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbStatsChangedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbStatsChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbStatsChangedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbStatsChangedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

	/// Determines if the event contained in the event holder is a `KvdbDeletedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbDeletedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbDeletedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbDeletedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbDeletedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

	
	/// Determines if the event contained in the event holder is a `KvdbNewItemEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbNewItemEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbNewItemEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbNewItemEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbNewItemEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbNewItemEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbNewItemEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbNewItemEvent {
		let res = privmx.KvdbEventHandler.extractKvdbNewItemEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

	
	/// Determines if the event contained in the event holder is a `KvdbItemUpdatedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbItemUpdatedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbItemUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbItemUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbItemUpdatedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbItemUpdatedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbItemUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbItemUpdatedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbItemUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

	/// Determines if the event contained in the event holder is a `KvdbItemDeletedEvent`.
	///
	/// This method checks if the event within the provided `EventHolder` instance is a `KvdbItemDeletedEvent`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be checked.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	/// - Returns: A `Bool` indicating whether the event is a Custom Event (`true`) or not (`false`).
	public static func isKvdbItemDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbItemDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	
	/// Extracts the custom event from the provided event holder.
	///
	/// This method retrieves an `KvdbItemDeletedEvent` object from the event contained in the given `EventHolder`.
	///
	/// - Parameter eventHolder: An `EventHolder` instance containing the event to be extracted.
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if the extraction process fails.
	/// - Returns: An `KvdbItemDeletedEvent` that wa emitted by one of the users of the Context.
	public static func extractKvdbItemDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbItemDeletedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbItemDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}

}
