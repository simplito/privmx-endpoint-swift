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

/// 'ThreadApi' is a class representing Endpoint's API for Threads and their messages.
public class ThreadApi{
	
	/// An instance of the wrapped C++ class.
	internal var api: privmx.NativeThreadApiWrapper
	
	private init(api: privmx.NativeThreadApiWrapper) {
		self.api = api
	}
	
	/// Creates an instance of 'ThreadApi'.
	///
	/// - Parameter connection: instance of 'Connection'
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingThreadApi` if an error occurs during the initialization.
	///
	/// - Returns: ThreadApi object
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
	
	/// Creates a new Thread in given Context.
	///
	/// - Parameter contextId: ID of the Context to create the Thread in
	/// - Parameter users: vector of UserWithPubKey structs which indicates who will have access to the created Thread
	/// - Parameter managers: vector of UserWithPubKey structs which indicates who will have access (and management rights) to
	///   the created Thread
	/// - Parameter publicMeta: public (unencrypted) metadata
	/// - Parameter privateMeta: private (encrypted) metadata
	/// - Parameter policies: Thread's policies
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingThread` if the Thread creation fails.
	///
	/// - Returns: ID of the created Thread
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
	
	/// Gets a Thread by given Thread ID.
	///
	/// - Parameter threadId: ID of Thread to get
	///
	/// - Throws: `PrivMXEndpointError.failedGettingThread` if fetching Thread details fails.
	///
	/// - Returns: Thread struct containing info about the Thread
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
	
	/// Updates an existing Thread.
	///
	/// - Parameter threadId: ID of the Thread to update
	/// - Parameter version: vector of UserWithPubKey structs which indicates who will have access to the created Thread
	/// - Parameter users: vector of UserWithPubKey structs which indicates who will have access (and management rights) to
	/// - Parameter managers: public (unencrypted) metadata
	/// - Parameter publicMeta: private (encrypted) metadata
	/// - Parameter privateMeta: current version of the updated Thread
	/// - Parameter force: force update (without checking version)
	/// - Parameter forceGenerateNewKey: force to regenerate a key for the Thread
	/// - Parameter policies: Thread's policies
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
	
	/// Deletes a Thread by given Thread ID.
	///
	/// - Parameter threadId: ID of the Thread to delete
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
	
	/// Gets a list of Threads in given Context.
	///
	/// - Parameter contextId: ID of the Context to get the Threads from
	/// - Parameter pagingQuery: struct with list query parameters
	///
	/// - Throws: `PrivMXEndpointError.failedListingThreads` if the listing process fails.
	///
	/// - Returns: struct containing a list of Threads
	public func listThreads(
		contextId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.ThreadList {
		let res = api.listThreads(contextId,pagingQuery)
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
	@available(*, deprecated, renamed: "listThreads(contextId:pagingQuery:)")
	public func listThreads(
		contextId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.ThreadList{
		try listThreads(contextId: contextId, pagingQuery: query)
	}
	
	/// Sends a message in a Thread.
	///
	/// - Parameter threadId: ID of the Thread to send message to
	/// - Parameter publicMeta: public message metadata
	/// - Parameter privateMeta: private message metadata
	/// - Parameter data: content of the message
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingMessage` if the message creation fails.
	///
	/// - Returns: ID of the new message
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
	
	/// Deletes a message by given message ID.
	///
	/// - Parameter messageId: ID of the message to delete
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
	
	/// Gets a message by given message ID.
	///
	/// - Parameter messageId: of the message to get
	///
	/// - Throws: `PrivMXEndpointError.failedGettingMessage` if retrieving the message fails.
	///
	/// - Returns: struct containing the message
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
	
	/// Gets a list of messages from a Thread.
	///
	/// - Parameter threadId: ID of the Thread to list messages from
	/// - Parameter pagingQuery: struct with list query parameters
	///
	/// - Throws: `PrivMXEndpointError.failedListingMessages` if listing the messages fails.
	///
	/// - Returns: struct containing a list of messages
	public func listMessages(
		threadId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.MessageList {
		let res = api.listMessages(threadId,pagingQuery)
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
	
	@available(*, deprecated, renamed: "listMessages(threadId:pagingQuery:)")
	public func listMessages(
		threadId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.MessageList {
		try listMessages(threadId: threadId, pagingQuery: query)
	}
	
	/// Update message in a Thread.
	///
	/// - Parameter messageId: ID of the message to update
	/// - Parameter publicMeta: public message metadata
	/// - Parameter privateMeta: private message metadata
	/// - Parameter data: content of the message
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
	
	/// Subscribe for the Thread events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries
	public func subscribeFor(
		subscriptionQueries: privmx.SubscriptionQueryVector
	) throws -> privmx.SubscriptionIdVector {
		let res = api.subscribeFor(subscriptionQueries)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedSubscribingForEvents(err)
		}
		return result
	}
	
	/// Unsubscribe from events for the given subscriptionId.
	///
	/// - Parameter subscriptionIds: list of subscriptionId
	///
	/// - Throws: When unsubscribing fails.
	public func unsubscribeFrom(
		subscriptionIds: privmx.SubscriptionIdVector
	) throws -> Void {
		let res = api.unsubscribeFrom(subscriptionIds)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Generate subscription Query for the Thread events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter selectorType: scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQuery(
		eventType: privmx.endpoint.thread.EventType,
		selectorType: privmx.endpoint.thread.EventSelectorType,
		selectorId: std.string
	) throws -> privmx.SubscriptionQuery {
		let res = api.buildSubscriptionQuery(eventType, selectorType, selectorId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(err)
		}
		return result
	}
}
