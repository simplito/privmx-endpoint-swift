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

/// Swift wrapper for `privmx.NativeInboxApiWrapper`, providing methods to manage Inboxes and entries within PrivMX platform.
public class InboxApi{
	
	/// An instance of the wrapped C++ class.
	public var cxxApi: privmx.NativeInboxApiWrapper
	
	
	/// Creates an instance of 'InboxApi'.
	///
	/// - Parameter  connection: instance of 'Connection'
	/// - Parameter  threadApi: instance of 'ThreadApi'
	/// - Parameter  storeApi: instance of 'StoreApi'
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingInboxApi` if an error occurs during initialization.
	///
	/// - Returns: InboxApi object
	public static func create(
		connection:inout Connection,
		threadApi: inout ThreadApi,
		storeApi: inout StoreApi
	) throws -> InboxApi{
		let res = privmx.NativeInboxApiWrapper.create(&connection.cxxApi,
													  &threadApi.cxxApi,
													  &storeApi.cxxApi)
		guard res.error.value == nil else{
			throw PrivMXEndpointError.failedInstantiatingInboxApi(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedInstantiatingInboxApi(err)
		}
		
		return InboxApi(api: result)
	}
	
	private init(
		api: privmx.NativeInboxApiWrapper
	){
		self.cxxApi = api
	}
	
	/// Creates a new Inbox.
	///
	///  - Parameter contextId: ID of the Context of the new Inbox
	///  - Parameter users: vector of UserWithPubKey structs which indicates who will have access to the created Inbox
	///  - Parameter managers: vector of UserWithPubKey structs which indicates who will have access (and management rights) to
	///  - Parameter publicMeta: public (unencrypted) metadata
	///  - Parameter privateMeta: private (encrypted) metadata
	///  - Parameter filesConfig: struct to override default file configuration
	///  - Parameter policies: Inbox policies
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingInbox` if Inbox creation fails.
	///
	/// - Returns: ID of the created Inbox
	public func createInbox(
		contextId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		filesConfig: privmx.endpoint.inbox.FilesConfig?,
		policies: privmx.endpoint.core.ContainerPolicyWithoutItem? = nil
	) throws -> std.string {
		
		var optFilesConfig = privmx.OptionalInboxFilesConfig()
		
		if let filesConfig{
			optFilesConfig = privmx.makeOptional(filesConfig)
		}
		
		var optPolicies = privmx.OptionalContainerPolicyWithoutItem()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = cxxApi.createInbox(contextId,
								  users,
								  managers,
								  publicMeta,
								  privateMeta,
								  optFilesConfig,
								  optPolicies)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingInbox(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingInbox(err)
		}
		return result
	}
	
	/// Updates an existing Inbox.
	///
	/// - Parameter inboxId: ID of the Inbox to update
	/// - Parameter users: vector of UserWithPubKey structs which indicates who will have access to the created Inbox
	/// - Parameter managers: vector of UserWithPubKey structs which indicates who will have access (and management rights) to
	/// the created Inbox
	/// - Parameter publicMeta: public (unencrypted) metadata
	/// - Parameter privateMeta: private (encrypted) metadata
	/// - Parameter filesConfig: struct to override default files configuration
	/// - Parameter version: current version of the updated Inbox
	/// - Parameter force: force update (without checking version)
	/// - Parameter forceGenerateNewKey: force to regenerate a key for the Inbox
	/// - Parameter policies: Inbox policies
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingInbox` if the update process fails.
	public func updateInbox(
		inboxId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		filesConfig: privmx.endpoint.inbox.FilesConfig?,
		version: Int64,
		force: Bool,
		forceGenerateNewKey: Bool,
		policies: privmx.endpoint.core.ContainerPolicyWithoutItem? = nil
	) throws -> Void {
		
		var optFilesConfig = privmx.OptionalInboxFilesConfig()
		
		if let filesConfig{
			optFilesConfig = privmx.makeOptional(filesConfig)
		}
		
		var optPolicies = privmx.OptionalContainerPolicyWithoutItem()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = cxxApi.updateInbox(inboxId,
								  users,
								  managers,
								  publicMeta,
								  privateMeta,
								  optFilesConfig,
								  version,
								  force,
								  forceGenerateNewKey,
								  optPolicies)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingInbox(res.error.value!)
		}
	}
	
	/// Gets a single Inbox by given Inbox ID.
	///
	/// - Parameter inboxId: ID of the Inbox to get
	///
	/// - Throws: `PrivMXEndpointError.failedGettingInbox` if fetching Inbox details fails.
	///
	/// - Returns: struct containing information about the Inbox
	public func getInbox(
		inboxId: std.string
	) throws -> privmx.endpoint.inbox.Inbox{
		
		let res = cxxApi.getInbox(inboxId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingInbox(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingInbox(err)
		}
		return result
	}
	
	/// Gets s list of Inboxes in given Context.
	///
	/// - Parameter contextId: ID of the Context to get Inboxes from
	/// - Parameter pagingQuery: struct with list query parameters
	///
	/// - Throws: `PrivMXEndpointError.failedListingInboxes` if listing Inboxes fails.
	///
	/// - Returns: struct containing list of Inboxes
	public func listInboxes(
		contextId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.InboxList {
		
		let res = cxxApi.listInboxes(contextId,
								  pagingQuery)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingInboxes(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingInboxes(err)
		}
		return result
	}
	
	/// Gets public data of given Inbox.
	/// You do not have to be logged in to call this function.
	///
	/// - Parameter inboxId: ID of the Inbox to get
	///
	/// - Throws: `PrivMXEndpointError.failedGettingInboxPublicView` if fetching the public view fails.
	///
	/// - Returns: struct containing public accessible information about the Inbox
	public func getInboxPublicView(
		inboxId: std.string
	) throws -> privmx.endpoint.inbox.InboxPublicView {
		
		let res = cxxApi.getInboxPublicView(inboxId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingInboxPublicView(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingInboxPublicView(err)
		}
		return result
	}
	
	/// Deletes an Inbox by given Inbox ID.
	///
	/// - Parameter inboxId: ID of the Inbox to delete
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingInbox` if deleting the Inbox fails.
	public func deleteInbox(
		inboxId: std.string
	) throws -> Void {
		
		let res = cxxApi.deleteInbox(inboxId)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingInbox(res.error.value!)
		}
	}
	
	/// Prepares a request to send data to an Inbox.
	/// You do not have to be logged in to call this function.
	///
	/// - Parameter inboxId: ID of the Inbox to which the request applies
	/// - Parameter data: entry data to send
	/// - Parameter inboxFileHandles: optional list of file handles that will be sent with the request
	/// - Parameter userPrivKey: sender can optionally provide a private key, which will be used: 1) to sign the sent data, 2) to derivation of the public key,
	/// which will then be transferred along with the sent data and can be used in the future for further secure communication with the sender
	///
	/// - Throws: `PrivMXEndpointError.failedPreparingEntry` if preparing the entry fails.
	///
	/// - Returns: handle
	public func prepareEntry(
		inboxId: std.string,
		data: privmx.endpoint.core.Buffer,
		inboxFileHandles: privmx.InboxFileHandleVector = [],
		userPrivKey: std.string? = nil
	) throws -> privmx.EntryHandle {
		
		var opk = privmx.OptionalString()
		if let userPrivKey{
			opk = privmx.makeOptional(userPrivKey)
		}
		
		let res = cxxApi.prepareEntry(inboxId,
								   data,
								   inboxFileHandles,
								   opk)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedPreparingEntry(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedPreparingEntry(err)
		}
		return result
	}
	
	/// Sends data to an Inbox.
	/// You do not have to be logged in to call this function.
	///
	/// - Parameter entryHandle: ID of the Inbox to which the request applies
	///
	/// - Throws: `PrivMXEndpointError.failedSendingEntry` if sending the entry fails.
	public func sendEntry(
		entryHandle: privmx.EntryHandle
	) throws -> Void {
		
		let res = cxxApi.sendEntry(entryHandle)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSendingEntry(res.error.value!)
		}
	}
	
	@available(*, deprecated, renamed: "sendEntry(entryHandle:)")
	public func sendEntry(
		inboxHandle: privmx.InboxHandle
	) throws -> Void {
		
		let res = cxxApi.sendEntry(inboxHandle)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSendingEntry(res.error.value!)
		}
	}
	
	/// Gets an entry from an Inbox.
	///
	/// - Parameter inboxEntryId: ID of an entry to read from the Inbox
	///
	/// - Throws: `PrivMXEndpointError.failedReadingEntry` if retrieving the entry fails.
	///
	/// - Returns: struct containing data of the selected entry stored in the Inbox
	public func readEntry(
		inboxEntryId: std.string
	) throws -> privmx.endpoint.inbox.InboxEntry {
		let res = cxxApi.readEntry(inboxEntryId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedReadingEntry(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedReadingEntry(err)
		}
		return result
	}
	
	/// Gets list of entries in given Inbox.
	///
	/// - Parameter inboxId: ID of the Inbox
	/// - Parameter pagingQuery: struct with list query parameters
	///
	/// - Throws: `PrivMXEndpointError.failedListingEntries` if listing the entries fails.
	///
	/// - Returns: struct containing list of entries
	public func listEntries(
		inboxId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.InboxEntryList {
		let res = cxxApi.listEntries(inboxId,
								  pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingEntries(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingEntries(err)
		}
		return result
	}
	
	/// Deletes a specified entry from an Inbox.
	///
	/// - Parameter inboxEntryId: The ID of the entry to delete.
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingEntry` if deleting the entry fails.
	public func deleteEntry(
		inboxEntryId: std.string
	) throws -> Void {
		let res = cxxApi.deleteEntry(inboxEntryId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingEntry(res.error.value!)
		}
	}
	
	/// Creates a file handle to send a file to an Inbox.
	/// You do not have to be logged in to call this function.
	///
	///  - Parameter publicMeta: file's public metadata
	///  - Parameter privateMeta: file's private metadata
	///  - Parameter fileSize: size of the file to send
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingFileHandle` if creating the file handle fails.
	///
	/// - Returns: file handle
	public func createFileHandle(
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer,
		fileSize: Int64
	) throws -> privmx.InboxFileHandle {
		let res = cxxApi.createFileHandle(publicMeta,
									   privateMeta,
									   fileSize)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingFileHandle(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingFileHandle(err)
		}
		return result
	}
	
	/// Sends file's data chunk to an Inbox.
	/// (note: To send the entire file - divide it into pieces of the desired size and call the function for each fragment.)
	/// You do not have to be logged in to call this function.
	///
	/// - Parameter entryHandle: Handle to the prepared Inbox entry
	/// - Parameter inboxFileHandle: handle to the file where the uploaded chunk belongs
	/// - Parameter Buffer: dataChunk - file chunk to send
	///
	/// - Throws: `PrivMXEndpointError.failedWritingToFile` if writing the data chunk fails.
	public func writeToFile(
		entryHandle: privmx.EntryHandle,
		inboxFileHandle: privmx.InboxFileHandle,
		dataChunk: privmx.endpoint.core.Buffer
	) throws -> Void {
		let res = cxxApi.writeToFile(entryHandle,
								  inboxFileHandle,
								  dataChunk)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWritingToFile(res.error.value!)
		}
	}

	
	@available(*, deprecated, renamed: "writeToFile(entryHandle:inboxFileHandle:dataChunk:)")
	public func writeToFile(
		inboxHandle: privmx.EntryHandle,
		inboxFileHandle: privmx.InboxFileHandle,
		dataChunk: privmx.endpoint.core.Buffer
	) throws -> Void {
		let res = cxxApi.writeToFile(inboxHandle,
								  inboxFileHandle,
								  dataChunk)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWritingToFile(res.error.value!)
		}
	}
	
	/// Opens a file to read.
	///
	/// - Parameter fileId: ID of the file to read
	///
	/// - Throws: `PrivMXEndpointError.failedOpeningFile` if opening the file fails.
	///
	/// - Returns: handle to read file data
	public func openFile(
		fileId: std.string
	) throws -> privmx.InboxFileHandle {
		let res = cxxApi.openFile(fileId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedOpeningFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedOpeningFile(err)
		}
		return result
	}
	
	/// Reads file data.
	/// Single read call moves the files's cursor position by declared length or set it at the end of the file.
	///
	/// - Parameter fileHandle: handle to the file
	/// - Parameter length: size of data to read
	///
	/// - Throws: `PrivMXEndpointError.failedReadingFromFile` if reading from the file fails.
	///
	/// - Returns: buffer with file data chunk
	public func readFromFile(
		fileHandle: privmx.InboxFileHandle,
		length: Int64
	) throws -> privmx.endpoint.core.Buffer {
		let res = cxxApi.readFromFile(fileHandle,
								   length)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedReadingFromFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedReadingFromFile(err)
		}
		return result
	}
	
	/// Moves file's read cursor.
	///
	/// - Parameter fileHandle: handle to the file
	/// - Parameter position: sets new cursor position
	///
	/// - Throws: `PrivMXEndpointError.failedSeekingInFile` if moving the cursor fails.
	public func seekInFile(
		fileHandle: privmx.InboxFileHandle,
		position: Int64
	) throws -> Void {
		let res = cxxApi.seekInFile(fileHandle,
								 position)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSeekingInFile(res.error.value!)
		}
	}
	
	/// Closes a file by given handle.
	///
	/// - Parameter fileHandle: handle to the file
	///
	/// - Throws: `PrivMXEndpointError.failedClosingFile` if closing the file fails.
	///
	/// - Returns: ID of closed file
	public func closeFile(
		fileHandle: privmx.InboxFileHandle
	) throws -> std.string {
		let res = cxxApi.closeFile(fileHandle)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedClosingFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedClosingFile(err)
		}
		return result
	}
	
	/// Subscribe for the Inbox events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries
	public func subscribeFor(
		subscriptionQueries: privmx.SubscriptionQueryVector
	) throws -> privmx.SubscriptionIdVector {
		let res = cxxApi.subscribeFor(subscriptionQueries)
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
		let res = cxxApi.unsubscribeFrom(subscriptionIds)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Generate subscription Query for the Inbox events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter selectorType: scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQuery(
	eventType: privmx.endpoint.inbox.EventType,
	selectorType: privmx.endpoint.inbox.EventSelectorType,
	selectorId: std.string
	) throws -> privmx.SubscriptionQuery {
		let res = cxxApi.buildSubscriptionQuery(eventType, selectorType, selectorId)
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
