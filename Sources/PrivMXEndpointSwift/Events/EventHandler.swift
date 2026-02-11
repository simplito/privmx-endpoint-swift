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
	
	// MARK: - Core
	/// Checks whether event held in the 'EventHolder' is an 'LibConnectedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'LibConnectedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'LibDisconnectedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'LibDisconnectedEvent', else otherwise
	///
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
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'LibPlatformDisconnectedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'CollectionChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'CollectionChangedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isCollectionChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.CoreEventHandlerWrapper.isCollectionChangedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'LibConnectedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'LibConnectedEvent' object
	///
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
	
	/// Gets Event held in the 'EventHolder' as an 'LibDisconnectedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'LibDisconnectedEvent' object
	///
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
	
	/// Gets Event held in the 'EventHolder' as an 'LibPlatformDisconnectedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'LibPlatformDisconnectedEvent' object
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'LibBreakEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'LibBreakEvent', else otherwise
	///
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
	
	/// Gets Event held in the 'EventHolder' as an 'LibBreakEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'LibBreakEvent' object
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ContextUsersStatusChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ContextUsersStatusChangedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isContextUsersStatusChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool{
		let res = privmx.CoreEventHandlerWrapper.isContextUsersStatusChangedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'ContextUsersStatusChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ContextUsersStatusChangedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractContextUsersStatusChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.ContextUsersStatusChangedEvent{
		let res = privmx.CoreEventHandlerWrapper.extractContextUsersStatusChangedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ContextUserAddedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ContextUserAddedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isContextUserAddedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool{
		let res = privmx.CoreEventHandlerWrapper.isContextUserAddedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'ContextUserAddedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ContextUserAddedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractContextUserAddedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.ContextUserAddedEvent{
		let res = privmx.CoreEventHandlerWrapper.extractContextUserAddedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ContextUserRemovedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ContextUserRemovedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs in the underlying C++ code or another issue arises.
	public static func isContextUserRemovedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool{
		let res = privmx.CoreEventHandlerWrapper.isContextUserRemovedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'ContextUserRemovedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ContextUserRemovedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractContextUserRemovedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.ContextUserRemovedEvent{
		let res = privmx.CoreEventHandlerWrapper.extractContextUserRemovedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'CollectionChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'CollectionChangedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an error occurs while extracting the event.
	public static func extractCollectionChangedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.CollectionChangedEvent{
		let res = privmx.CoreEventHandlerWrapper.extractCollectionChangedEvent(eventHolder)
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
	
	//MARK: - Store
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'StoreCreatedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: `true` if the event contained within the `EventHolder` is a `StoreUpdatedEvent`; otherwise, `false`.
	///
	/// - Throws: true for 'StoreUpdatedEvent', else otherwise
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
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns:true for 'StoreDeletedEvent', else otherwise
	///
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
	
	///  Checks whether event held in the 'EventHolder' is an 'StoreStatsChangedEvent'
	///
	/// - Parameter eventHolder:  holder object that wraps the 'Event'
	///
	/// - Returns: true for 'StoreStatsChangedEvent', else otherwise
	///
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
	
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreFileCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'StoreFileCreatedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreFileUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'StoreFileUpdatedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'StoreFileDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'StoreFileDeletedEvent', else otherwise
	///
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreUpdatedEvent'
	///
	/// - Parameter eventHolder:  holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreStatsChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreStatsChangedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreFileCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreFileCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreFileUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreFileUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'StoreFileDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'StoreFileDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	//MARK: - Thread
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadCreatedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadUpdatedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadDeletedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadStatsChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadStatsChangedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadNewMessageEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadNewMessageEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadMessageDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadMessageDeletedEvent', else otherwise
	///
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
	
	/// Checks whether event held in the 'EventHolder' is an 'ThreadMessageUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ThreadMessageUpdatedEvent', else otherwise
	///
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
	
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadStatsChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadStatsChangedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadNewMessageEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadNewMessageEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadMessageDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadMessageDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ThreadMessageUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'ThreadMessageUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	// MARK: - Inbox
	
	/// Checks whether event held in the 'EventHolder' is an 'InboxCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'InboxCreatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'InboxCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'InboxCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractInboxCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxCreatedEvent {
		let res = privmx.InboxEventHandler.extractInboxCreatedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'InboxUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'InboxUpdatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'InboxUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'InboxUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractInboxUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxUpdatedEvent {
		let res = privmx.InboxEventHandler.extractInboxUpdatedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'InboxDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'InboxDeletedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'InboxDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'InboxDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractInboxDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxDeletedEvent {
		let res = privmx.InboxEventHandler.extractInboxDeletedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'InboxEntryCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'InboxEntryCreatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'InboxEntryCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'InboxEntryCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractInboxEntryCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxEntryCreatedEvent {
		let res = privmx.InboxEventHandler.extractInboxEntryCreatedEvent(eventHolder)
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
	
	/// Checks whether event held in the 'EventHolder' is an 'InboxEntryDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'InboxEntryDeletedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'InboxEntryDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'InboxEntryDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractInboxEntryDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.inbox.InboxEntryDeletedEvent {
		let res = privmx.InboxEventHandler.extractInboxEntryDeletedEvent(eventHolder)
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
	
	//MARK: - Event
	
	/// Checks whether event held in the 'EventHolder' is an 'ContextCustomEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'ContextCustomEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'ContextCustomEvent'
	/// 
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	/// 
	/// - Returns: 'ContextCustomEvent' object
	/// 
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	//MARK: - KVDB
	 
	/// Checks whether event held in the 'EventHolder' is an 'KvdbCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbCreatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbCreatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbCreatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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
	
	/// Checks whether event held in the 'EventHolder' is an 'KvdbUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbUpdatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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

 	/// Checks whether event held in the 'EventHolder' is an 'KvdbStatsChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbStatsChangedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbStatsChangedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbStatsChangedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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

	/// Checks whether event held in the 'EventHolder' is an 'KvdbDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbDeletedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbDeletedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
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

	
	/// Checks whether event held in the 'EventHolder' is an 'KvdbNewEntryEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbNewEntryEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	public static func isKvdbNewEntryEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbNewEntryEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbNewEntryEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbNewEntryEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractKvdbNewEntryEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbNewEntryEvent {
		let res = privmx.KvdbEventHandler.extractKvdbNewEntryEvent(eventHolder)
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

	
	/// Checks whether event held in the 'EventHolder' is an 'KvdbEntryUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbEntryUpdatedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	public static func isKvdbEntryUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbEntryUpdatedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbEntryUpdatedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: 'KvdbEntryUpdatedEvent' object
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractKvdbEntryUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbEntryUpdatedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbEntryUpdatedEvent(eventHolder)
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

	/// Checks whether event held in the 'EventHolder' is an 'KvdbEntryDeletedEvent'
	///
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	///
	/// - Returns: true for 'KvdbEntryDeletedEvent', else otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if there is an error during the check.
	public static func isKvdbEntryDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.KvdbEventHandler.isKvdbEntryDeletedEvent(eventHolder)
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
	
	/// Gets Event held in the 'EventHolder' as an 'KvdbEntryDeletedEvent'
	/// 
	/// - Parameter eventHolder: holder object that wraps the 'Event'
	/// 
	/// - Returns: 'KvdbEntryDeletedEvent' object
	/// 
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if the extraction process fails.
	public static func extractKvdbEntryDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.kvdb.KvdbEntryDeletedEvent {
		let res = privmx.KvdbEventHandler.extractKvdbEntryDeletedEvent(eventHolder)
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

	//MARK: - Stream
	
	public static func isStreamRoomCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomCreatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamRoomCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomCreatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomCreatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public static func isStreamRoomUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamRoomUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public static func isStreamRoomDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomDeletedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamRoomDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomDeletedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomDeletedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public static func isStreamJoinedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamJoinedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamJoinedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamJoinedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamJoinedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public static func isStreamUnpublishedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamUnpublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamUnpublishedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamUnpublishedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamUnpublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public static func isStreamPublishedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamPublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamPublishedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamPublishedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamPublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public static func isStreamLeftEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamLeftEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamLeftEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamLeftEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamLeftEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public static func isStreamNewStreamsEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamNewStreamsEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamNewStreamsEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamNewStreamsEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamNewStreamsEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public static func isStreamsUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamsUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamsUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamsUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamsUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public static func isStreamUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public static func extractStreamUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
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
