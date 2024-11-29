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
	internal var api: privmx.NativeInboxApiWrapper
	
	
	/// Creates a new instance of `InboxApi` using a connection, `threadApi`, and `StoreApi`.
    ///
    /// - Parameters:
    ///   - connection: The connection object to interact with PrivMX.
    ///   - threadApi: The Thread API instance.
    ///   - storeApi: The Store API instance.
    ///
    /// - Throws: `PrivMXEndpointError.failedInstantiatingInboxApi` if an error occurs during initialization.
    ///
    /// - Returns: A new `InboxApi` instance.
    public static func create(
		connection:inout Connection,
		threadApi: inout ThreadApi,
		storeApi: inout StoreApi
	) throws -> InboxApi{
		let res = privmx.NativeInboxApiWrapper.create(&connection.api,
													  &threadApi.api,
													  &storeApi.api)
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
		self.api = api
	}
	
	/// Creates a new Inbox in the specified context.
    ///
    /// - Parameters:
    ///   - contextId: The ID of the context where the Inbox should be created.
    ///   - users: A vector of users who will have access to the Inbox.
    ///   - managers: A vector of users who will manage the Inbox.
    ///   - publicMeta: Public metadata that is not encrypted.
    ///   - privateMeta: Private metadata that is encrypted.
    ///   - filesConfig: An optional configuration for file storage.
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingInbox` if Inbox creation fails.
    ///
    /// - Returns: The ID of the newly created Inbox as a `std.string`.
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
		
		let res = api.createInbox(contextId,
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
	
	/// Updates an existing Inbox with new metadata and configuration.
    ///
    /// - Parameters:
    ///   - inboxId: The ID of the Inbox to be updated.
    ///   - users: A vector of users who will have access to the Inbox.
    ///   - managers: A vector of users who will manage the Inbox.
    ///   - publicMeta: Updated public metadata for the Inbox.
    ///   - privateMeta: Updated private metadata for the Inbox.
    ///   - filesConfig: An optional configuration for file storage.
    ///   - version: The current version of the Inbox for version control.
    ///   - force: Whether to force the update, ignoring version control.
    ///   - forceGenerateNewKey: Whether to force regeneration of a new key for the Inbox.
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
		
		let res = api.updateInbox(inboxId,
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
	
	/// Retrieves detailed information about a specific Inbox.
    ///
    /// - Parameter inboxId: The ID of the Inbox to retrieve.
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingInbox` if fetching Inbox details fails.
    ///
    /// - Returns: An `Inbox` instance containing Inbox details.
    public func getInbox(
		inboxId: std.string
	) throws -> privmx.endpoint.inbox.Inbox{
		
		let res = api.getInbox(inboxId)
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
	
	/// Lists all Inboxes within a specified context.
    ///
    /// - Parameters:
    ///   - contextId: The ID of the context from which to list Inboxes.
    ///   - pagingQuery: A query object to filter and paginate the results.
    ///
    /// - Throws: `PrivMXEndpointError.failedListingInboxes` if listing Inboxes fails.
    ///
    /// - Returns: An `InboxList` containing the list of Inboxes.
   public func listInboxes(
		contextId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.InboxList {
		
		let res = api.listInboxes(contextId,
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
	
	/// Retrieves the public view of a specific Inbox.
    ///
    /// - Parameter inboxId: The ID of the Inbox to retrieve the public view for.
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingInboxPublicView` if fetching the public view fails.
    ///
    /// - Returns: An `InboxPublicView` containing the public view of the Inbox.
    public func getInboxPublicView(
		inboxId: std.string
	) throws -> privmx.endpoint.inbox.InboxPublicView {
		
		let res = api.getInboxPublicView(inboxId)
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
	
	/// Deletes a specified Inbox.
	///
	/// - Parameter inboxId: The ID of the Inbox to delete.
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingInbox` if deleting the Inbox fails.
   public func deleteInbox(
		inboxId: std.string
	) throws -> Void {
		
		let res = api.deleteInbox(inboxId)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingInbox(res.error.value!)
		}
	}
	
	/// Prepares a new entry to be sent to the Inbox.
	///
	/// If the entry contains files, they must first be prepared using `createFileHandle()` and attached to the entry.
	///
	/// - Parameters:
	///   - inboxId: The ID of the Inbox to which the entry will be sent.
	///   - data: The data to be included in the entry.
	///   - inboxFileHandles: An optional vector of file handles to be attached to the entry. By default, no files are attached.
	///   - userPrivKey: An optional private key of the user preparing the entry, if required.
	///
	/// - Throws: `PrivMXEndpointError.failedPreparingEntry` if preparing the entry fails.
	///
	/// - Returns: An `InboxHandle` representing the prepared entry, which should then be sent.
public func prepareEntry(
		inboxId: std.string,
		data: privmx.endpoint.core.Buffer,
		inboxFileHandles: privmx.InboxFileHandleVector = [],
		userPrivKey: std.string? = nil
	) throws -> privmx.InboxHandle {
		
		var opk = privmx.OptionalString()
		if let userPrivKey{
			opk = privmx.makeOptional(userPrivKey)
		}
		
		let res = api.prepareEntry(inboxId,
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
	
	/// Sends a previously prepared entry to the Inbox.
	///
	/// This method finalizes the process by sending the entry to the specified Inbox.
	///
	/// - Parameter inboxHandle: The handle of the prepared entry to be sent.
	///
	/// - Throws: `PrivMXEndpointError.failedSendingEntry` if sending the entry fails.
	public func sendEntry(
		inboxHandle: privmx.InboxHandle
	) throws -> Void {
		
		let res = api.sendEntry(inboxHandle)
		
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSendingEntry(res.error.value!)
		}
	}
	
	/// Retrieves an entry from a specific Inbox.
    ///
    /// - Parameter inboxEntryId: The ID of the entry to be retrieved.
    ///
    /// - Throws: `PrivMXEndpointError.failedReadingEntry` if retrieving the entry fails.
    ///
    /// - Returns: An `InboxEntry` instance representing the entry.
    public func readEntry(
		inboxEntryId: std.string
	) throws -> privmx.endpoint.inbox.InboxEntry {
		let res = api.readEntry(inboxEntryId)
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
	
	/// Lists entries within a specific Inbox.
    ///
    /// - Parameters:
    ///   - inboxId: The ID of the Inbox from which to list entries.
    ///   - pagingQuery: A query object to filter and paginate the results.
    ///
    /// - Throws: `PrivMXEndpointError.failedListingEntries` if listing the entries fails.
    ///
    /// - Returns: An `InboxEntryList` containing the list of entries.
    public func listEntries(
	inboxId: std.string,
	pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.InboxEntryList {
		let res = api.listEntries(inboxId,
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
		let res = api.deleteEntry(inboxEntryId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingEntry(res.error.value!)
		}
	}
	
	/// Creates a new file handle for writing data to the Inbox.
    ///
    /// - Parameters:
    ///   - publicMeta: Public metadata for the file.
    ///   - privateMeta: Private metadata for the file.
    ///   - fileSize: The size of the file in bytes.
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingFileHandle` if creating the file handle fails.
    ///
    /// - Returns: An `InboxFileHandle` for writing data to the file.
   public func createFileHandle(
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer,
		fileSize: Int64
	) throws -> privmx.InboxFileHandle {
		let res = api.createFileHandle(publicMeta,
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
	
	/// Writes a chunk of data to a file in the Inbox.
	///
	/// - Parameters:
	///   - inboxHandle: The handle of the Inbox containing the file.
	///   - inboxFileHandle: The file handle to write data to.
	///   - dataChunk: The chunk of data to write.
	///
	/// - Throws: `PrivMXEndpointError.failedWritingToFile` if writing the data chunk fails.
	public func writeToFile(
		inboxHandle: privmx.InboxHandle,
		inboxFileHandle: privmx.InboxFileHandle,
		dataChunk: privmx.endpoint.core.Buffer
	) throws -> Void {
		let res = api.writeToFile(inboxHandle,
								  inboxFileHandle,
								  dataChunk)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWritingToFile(res.error.value!)
		}
	}
	
	/// Opens a file for reading from the Inbox.
	///
	/// - Parameter fileId: The ID of the file to open.
	///
	/// - Throws: `PrivMXEndpointError.failedOpeningFile` if opening the file fails.
	///
	/// - Returns: An `InboxFileHandle` for reading from the file.
	public func openFile(
		fileId: std.string
	) throws -> privmx.InboxFileHandle {
		let res = api.openFile(fileId)
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
	
	/// Reads data from an open file in the inbox.
    ///
    /// - Parameters:
    ///   - fileHandle: The file handle to read from.
    ///   - length: The number of bytes to read.
    ///
    /// - Throws: `PrivMXEndpointError.failedReadingFromFile` if reading from the file fails.
    ///
    /// - Returns: A buffer containing the read data.
   public func readFromFile(
		fileHandle: privmx.InboxFileHandle,
		length: Int64
	) throws -> privmx.endpoint.core.Buffer {
		let res = api.readFromFile(fileHandle,
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
	
	/// Moves the read cursor in an open file.
    ///
    /// - Parameters:
    ///   - fileHandle: The file handle to move the cursor in.
    ///   - position: The new position of the cursor in bytes.
    ///
    /// - Throws: `PrivMXEndpointError.failedSeekingInFile` if moving the cursor fails.
    public func seekInFile(
		fileHandle: privmx.InboxFileHandle,
		position: Int64
	) throws -> Void {
		let res = api.seekInFile(fileHandle,
								 position)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSeekingInFile(res.error.value!)
		}
	}
	
	/// Closes an open file in the Inbox.
    ///
    /// - Parameter fileHandle: The file handle to close.
    ///
    /// - Throws: `PrivMXEndpointError.failedClosingFile` if closing the file fails.
    ///
    /// - Returns: The ID of the closed file as a `std.string`.
    public func closeFile(
		fileHandle: privmx.InboxFileHandle
	) throws -> std.string {
		let res = api.closeFile(fileHandle)
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
	
	/// Subscribes to Inbox-related events.
    ///
    /// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to Inbox events fails.
    public func subscribeForInboxEvents(
	) throws -> Void {
		let res = api.subscribeForInboxEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	 /// Unsubscribes from Inbox-related events.
    ///
	/// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from Inbox events fails.
   public func unsubscribeFromInboxEvents(
	) throws -> Void {
		let res = api.unsubscribeFromInboxEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Subscribes to entry-related events within a specific Inbox.
    ///
    /// - Parameter inboxId: The ID of the Inbox to subscribe to entry events for.
    ///
    /// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to entry events fails.
    public func subscribeForEntryEvents(
		inboxId: std.string
	) throws -> Void {
		let res = api.subscribeForEntryEvents(inboxId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	/// Unsubscribes from entry-related events within a specific Inbox.
    ///
    /// - Parameter inboxId: The ID of the Inbox to unsubscribe from entry events for.
    ///
    /// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from entry events fails.
    public func unsubscribeFromEntryEvents(
		inboxId: std.string
	) throws -> Void {
		let res = api.unsubscribeFromEntryEvents(inboxId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
}
