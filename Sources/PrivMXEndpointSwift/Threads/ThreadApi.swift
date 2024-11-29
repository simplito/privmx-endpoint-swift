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
import Cxx
import CxxStdlib
import PrivMXEndpointSwiftNative

/// Swift wrapper for `privmx.NativeThreadApiWrapper`, providing Thread-related operations within PrivMX platform.
public class ThreadApi{
	
	/// An instance of the wrapped C++ class.
	var api: privmx.NativeThreadApiWrapper
	
	private init(api: privmx.NativeThreadApiWrapper) {
		self.api = api
	}
	
	/// Creates a new instance of `ThreadApi` from a `Connection` object.
	///
	/// This method initializes the `ThreadApi` instance, enabling Thread-related operations over the specified connection.
	///
	/// - Parameter connection: The connection object to be used for interacting with Threads.
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingThreadApi` if an error occurs during the initialization.
	///
	/// - Returns: A newly created `ThreadApi` instance.
	public static func create(
		connection: inout Connection
	) throws -> ThreadApi{
		let res = privmx.NativeThreadApiWrapper.create(&connection.api)
		guard res.error.value == nil  else {
			throw PrivMXEndpointError.failedInstantiatingThreadApi(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedInstantiatingThreadApi(err)
		}
		return ThreadApi(api: result)
	}
	
	/// Creates a new Thread within PrivMX Bridge.
	///
	/// This method creates a new Thread in the specified context, assigning users and managers to it. Note that managers must be added explicitly as users to access the Thread.
	///
	/// - Parameters:
	///   - contextId: The context in which the Thread should be created.
	///   - users: A vector of users who will have access to the Thread.
	///   - managers: A vector of managers responsible for the Thread.
	///   - publicMeta: Public metadata for the Thread, which will not be encrypted.
	///   - privateMeta: Private metadata for the Thread, which will be encrypted.
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingThread` if the Thread creation fails.
	///
	/// - Returns: The ID of the newly created Thread as a `std.string`.
	public func createThread(
		contextId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		policies: privmx.endpoint.core.ContainerPolicy? = nil
	)throws -> std.string {
		
		var optPolicies = privmx.OptionalContainerPolicy()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = api.createThread(contextId,
								   users,
								   managers,
								   publicMeta,
								   privateMeta,
								   optPolicies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingThread(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingThread(err)
		}
		return result
	}
	
	/// Retrieves detailed information about a specific Thread.
	///
	/// - Parameter threadId: The unique identifier of the Thread to retrieve.
	///
	/// - Throws: `PrivMXEndpointError.failedGettingThread` if fetching Thread details fails.
	///
	/// - Returns: A `privmx.endpoint.thread.Thread` instance representing the Thread details.
	public func getThread(
		threadId: std.string
	) throws -> privmx.endpoint.thread.Thread {
		
		let res = api.getThread(threadId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingThread(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingThread(err)
		}
		return result
	}
	
	/// Updates an existing Thread with new values.
	///
	/// This method updates the metadata, users, and managers of a Thread. The update can be forced, and a new key can be generated if needed.
	///
	/// - Parameters:
	///   - threadId: The unique identifier of the Thread to be updated.
	///   - version: The current version of the Thread to ensure version consistency.
	///   - users: A vector of users who will have access to the Thread.
	///   - managers: A vector of managers responsible for the Thread.
	///   - publicMeta: New public metadata for the Thread, which will not be encrypted.
	///   - privateMeta: New private metadata for the Thread, which will be encrypted.
	///   - force: Whether to force the update, bypassing version control.
	///   - forceGenerateNewKey: Whether to generate a new key for the Thread.
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingThread` if the update process fails.
	public func updateThread(
		threadId : std.string,
		version: Int64,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		force: Bool,
		forceGenerateNewKey: Bool,
		policies: privmx.endpoint.core.ContainerPolicy? = nil
	) throws -> Void {
		
		var optPolicies = privmx.OptionalContainerPolicy()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = api.updateThread(threadId,
								   users,
								   managers,
								   publicMeta,
								   privateMeta,
								   version,
								   force,
								   forceGenerateNewKey,
								   optPolicies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingThread(res.error.value!)
		}
	}
	
	/// Deletes a specified Thread.
	///
	/// - Parameter threadId: The unique identifier of the Thread to delete.
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingThread` if the deletion fails.
	public func deleteThread(
		threadId: std.string
	) throws -> Void {
		
		let res = api.deleteThread(threadId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingThread(res.error.value!)
		}
	}
	
	/// Lists all Threads accessible to the user within a specified context.
	///
	/// - Parameters:
	///   - contextId: The unique identifier of the context from which to list Threads.
	///   - query: A query object to filter and paginate the results.
	///
	/// - Throws: `PrivMXEndpointError.failedListingThreads` if the listing process fails.
	///
	/// - Returns: A `privmx.ThreadList` instance containing the list of Threads.
	public func listThreads(
		contextId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.ThreadList {
		let res = api.listThreads(contextId,query)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingThreads(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingThreads(err)
		}
		return result
	}
	
	/// Sends a message in a Thread.
	///
	/// - Parameters:
	///   - threadId: The unique identifier of the Thread to send the message to.
	///   - publicMeta: Public metadata for the message, which will not be encrypted.
	///   - privateMeta: Encrypted metadata for the message.
	///   - data: The actual content of the message.
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingMessage` if the message creation fails.
	///
	/// - Returns: The ID of the created message as a `std.string`.
	public func sendMessage(
		threadId: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer
	) throws -> std.string{
		let res = api.sendMessage(threadId,
								  publicMeta,
								  privateMeta,
								  data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingMessage(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingMessage(err)
		}
		return result
	}
	
	/// Deletes a specified message.
	///
	/// - Parameter messageId: The unique identifier of the message to delete.
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingMessage` if the deletion process fails.
	public func deleteMessage(
		_ messageId: std.string
	) throws -> Void {
		let res = api.deleteMessage(messageId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingMessage(res.error.value!)
		}
	}
	
	/// Retrieves a specific message by its ID.
	///
	/// - Parameter messageId: The unique identifier of the message to retrieve.
	///
	/// - Throws: `PrivMXEndpointError.failedGettingMessage` if retrieving the message fails.
	///
	/// - Returns: A `privmx.endpoint.thread.Message` instance representing the message details.
	public func getMessage(
		_ messageId: std.string
	) throws -> privmx.endpoint.thread.Message {
		
		let res = api.getMessage(messageId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingMessage(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingMessage(err)
		}
		return result
	}
	
	/// Lists all messages from a specified Thread based on a query.
	///
	/// - Parameters:
	///   - threadId: The unique identifier of the Thread from which to list messages.
	///   - query: A query object to filter and paginate the results.
	///
	/// - Throws: `PrivMXEndpointError.failedListingMessages` if listing the messages fails.
	///
	/// - Returns: A `privmx.MessageList` instance containing the list of messages.
	public func listMessages(
		threadId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.MessageList {
		let res = api.listMessages(threadId,query)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingMessages(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingMessages(err)
		}
		return result
	}
	
	/// Updates an existing message with new metadata and content.
	///
	/// - Parameters:
	///   - messageId: The unique identifier of the message to be updated.
	///   - publicMeta: New public metadata for the message, which will not be encrypted.
	///   - privateMeta: New encrypted metadata for the message.
	///   - data: New content for the message, which will not be encrypted.
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingMessage` if the update fails.
	public func updateMessage(
		messageId: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer
	) throws -> Void {
		let res = api.updateMessage(messageId,
									publicMeta, privateMeta,
									data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingMessage(res.error.value!)
		}
	}
	
	/// Subscribes to Thread-related events, allowing notifications when Thread changes occur.
	///
	/// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to Thread events fails.
	public func subscribeForThreadEvents(
	) throws -> Void {
		let res = api.subscribeForThreadEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	/// Unsubscribes from Thread-related events.
	///
	/// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from Thread events fails.
	public func unsubscribeFromThreadEvents(
	) throws -> Void {
		let res = api.unsubscribeFromThreadEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Subscribes to message-related events within a specific Thread, allowing notifications when messages are updated or received.
	///
	/// - Parameter threadId: The unique identifier of the Thread for which to subscribe to message events.
	///
	/// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to message events fails.
	public func subscribeForMessageEvents(
		threadId: std.string
	) throws -> Void {
		let res = api.subscribeForMessageEvents(threadId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	/// Unsubscribes from message-related events within a specific Thread.
	///
	/// - Parameter threadId: The unique identifier of the Thread for which to unsubscribe from message events.
	///
	/// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from message events fails.
	public func unsubscribeFromMessageEvents(
		threadId: std.string
	) throws -> Void {
		let res = api.unsubscribeFromMessageEvents(threadId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
}
