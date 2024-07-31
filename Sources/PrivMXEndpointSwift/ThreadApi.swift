//
// PrivMX Endpoint Swift
// Copyright © 2024 Simplito sp. z o.o.
//
// This file is part of the PrivMX Platform (https://privmx.cloud).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import Cxx
import CxxStdlib
import PrivMXEndpointSwiftNative

/// Swift wrapper for `privmx.NativeThreadApiWrapper`.
public class ThreadApi{
	/// An instance of the wrapped C++ class.
	internal var api: privmx.NativeThreadApiWrapper
	
	
	/// Creates a new ThreadApi instance.
	///
	/// - Parameter coreApi: a CoreApi instance.
	public init(
		coreApi: inout CoreApi
	){
		self.api = privmx.NativeThreadApiWrapper.create(&coreApi.api)
	}
	
	/// Creates a new Thread on the Platform.
	///
	/// Note that managers do not gain acess to the thread without being added as users.
	///
	/// - Parameter contextId: in which Context should the thread be created
	/// - Parameter users: who can access the Thread
	/// - Parameter managers: who can manage the thread
	/// - Parameter title: the title of the thread
	///
	/// - Returns:Id of the newly created Thread
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingThread` if an exception was thrown in C++ code, or another error occurred.
	public func createThread(
		_ threadName: std.string,
		with users: privmx.UserWithPubKeyVector,
		managedBy managers: privmx.UserWithPubKeyVector,
		in contextId: std.string
	)throws -> std.string {
		let res = api.threadCreate(contextId, users, managers, threadName)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedCreatingThread(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedCreatingThread(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Retrieves information about a Thread.
	///
	/// - Parameter threadId : which Thread is to be retrieved.
	///
	/// - Returns:Information about a Thread
	///
	/// - Throws: `PrivMXEndpointError.failedGettingThread` if an exception was thrown in C++ code, or another error occurred.
	public func getThread(
		_ threadId: std.string
	) throws -> privmx.endpoint.thread.ThreadInfo {
		
		let res = api.threadGet(threadId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGettingThread(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGettingThread(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Updates an existing Thread.
	///
	/// The provided values override preexisting values.
	///
	/// - Parameter contextId: which Thread is to be updated
	/// - Parameter users: who can access the Thread
	/// - Parameter managers: who can manage the thread
	/// - Parameter title: the title of the thread
	/// - Parameter version: current version of the Thread
	/// - Parameter force: force the update by disregarding the version check
	/// - Parameter generateNewKeyId: force regeneration of new keyId for Thread
	/// - Parameter accessToOldDataForNewUsers: placeholder parameter (does nothing for now)
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingThread` if an exception was thrown in C++ code, or another error occurred.
	public func updateThread(
		_ threadId : std.string,
		users : privmx.UserWithPubKeyVector,
		managers : privmx.UserWithPubKeyVector,
		title: std.string,
		version: Int64,
		force: Bool,
		generateNewKeyId: Bool,
		accessToOldDataForNewUsers: Bool
	) throws -> Void {
		let res = api.threadUpdate(threadId,
								   users,
								   managers,
								   title,
								   version,
								   force,
								   generateNewKeyId,
								   accessToOldDataForNewUsers)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedUpdatingThread(msg: String(res.error))
		}
	}
	
	/// Deletes a Thread.
	///
	/// - Parameter threadId: which Thread is to be deleted
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingThread` if an exception was thrown in C++ code, or another error occurred.
	public func deleteThread(
		_ threadId: std.string
	) throws -> Void {
		
		let res = api.threadDelete(threadId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDeletingThread(msg: String(res.error))
		}
	}
	
	/// Lists Threads the user has access to in provided Context.
	///
	/// - Parameter contextId: from which Context should the Threads be listed
	/// - Parameter query: parameters of the query
	///
	/// - Returns:`privmx.endpoint.thread.ThreadsList`instance.
	///
	/// - Throws: `PrivMXEndpointError.failedListingThreads` if an exception was thrown in C++ code, or another error occurred.
	public func listThreads(
		from contextId: std.string,
		query: privmx.endpoint.core.ListQuery
	) throws -> privmx.endpoint.thread.ThreadsList {
		let res = api.threadList(contextId,query)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedListingThreads(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedListingThreads(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Sends a message in a thread
	///
	/// - Parameter threadId: Message to be deleted
	/// - Parameter publicMeta: Meta_data that will not be encrypted on the Platform
	/// - Parameter privateMeta: Meta_data that will be encrypted on the Platform
	/// - Parameter data: Actual message
	///
	/// - Returns:Id of the created message, wrappend in a `ResultWithError` structure for error handling.
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingMessage` if an exception was thrown in C++ code, or another error occurred.
	public func sendMessage(
		threadId: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer
	) throws -> std.string{
		let res = api.messageSend(threadId,
								  publicMeta,
								  privateMeta,
								  data)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedCreatingMessage(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedCreatingMessage(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Deletes a Message.
	///
	/// - Parameter messageId: which Message is to be deleted
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingMessage` if an exception was thrown in C++ code, or another error occurred.
	public func deleteMessage(
		_ messageId: std.string
	) throws -> Void {
		let res = api.messageDelete(messageId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDeletingMessage(msg: String(res.error))
		}
	}
	
	/// Retrieves the Message with specified Id
	///
	/// - Parameter messageId: Message to be Retrieved
	///
	/// - Returns: A Message
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingMessage` if an exception was thrown in C++ code, or another error occurred.
	public func getMessage(
		_ messageId: std.string
	) throws -> privmx.endpoint.core.Message {
		
		let res = api.messageGet(messageId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGettingMessage(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGettingMessage(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Lists Messages from a particular Thread
	///
	/// - Parameter threadId:from which Thread should the Messages be listed
	/// - Parameter query: parameters of the query
	///
	/// - Returns: A list of messages in accordance to the query.
	///
	/// - Throws: `PrivMXEndpointError.failedListingMessages` if an exception was thrown in C++ code, or another error occurred.
	public func listMessages(
		from threadId: std.string,
		query: privmx.endpoint.core.ListQuery
	) throws -> privmx.endpoint.core.MessagesList {
		
		let res = api.messagesGet(threadId,query)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedListingMessages(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedListingMessages(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadCreatedEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadCreatedEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadUpdatedEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadUpdatedEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadDeletedEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadDeletedEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadStatsEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadStatsEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadStatsEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadStatsEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadNewMessageEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadNewMessageEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadNewMessageEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadNewMessageEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if an EventHolder contains a `privmx.endpoint.thread.ThreadDeletedMessageEvent`
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: True if the Holder contains a `privmx.endpoint.thread.ThreadDeletedMessageEvent`, False otherwise
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isThreadDeletedMessageEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeThreadApiWrapper.isThreadDeletedMessageEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Extracts a `privmx.endpoint.thread.ThreadCreatedEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadCreatedEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadCreatedEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.thread.ThreadUpdatedEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadUpdatedEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadUpdatedEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.thread.ThreadDeletedEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadDeletedEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadDeletedEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.thread.ThreadStatsEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadStatsEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadStatsEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadStatsEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadStatsEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.thread.ThreadNewMessageEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadNewMessageEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadNewMessageEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadNewMessageEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadNewMessageEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Extracts a `privmx.endpoint.thread.ThreadDeletedMessageEvent` from the provided Holder
	///
	/// - Parameter EventHolder: Object containing an Event
	///
	/// - Returns: The `privmx.endpoint.thread.ThreadDeletedMessageEvent` contained in the EventHolder
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractThreadDeletedMessageEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.thread.ThreadDeletedMessageEvent {
		let res = privmx.NativeThreadApiWrapper.extractThreadDeletedMessageEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
}
