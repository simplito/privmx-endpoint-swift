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

/// 'StoreApi' is a class representing Endpoint's API for Stores and their files.
public class StoreApi{
	
	/// An instance of the wrapped C++ class.
    internal var api: privmx.NativeStoreApiWrapper
	
	/// Creates an instance of 'StoreApi'Gets a list of Stores in given Context.
	///
	/// - Parameter connection: instance of 'ConnectionID of the Context to get the Stores from
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingStoreApi` if the initialization fails.
	///
	/// - Returns: StoreApi struct with list query parameters
	public static func create(
		connection: inout Connection
	) throws -> StoreApi {
		let res = privmx.NativeStoreApiWrapper.create(&connection.api)
		guard res.error.value == nil else{
			throw PrivMXEndpointError.failedInstantiatingStoreApi(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedInstantiatingStoreApi(err)
		}
		return StoreApi(api: result)
	}
	
	
	private init(
		api: privmx.NativeStoreApiWrapper
	){
		self.api = api
	}
	
	/// struct containing list of Stores
    ///
    /// - Parameter contextId: Gets a list of Stores in given Context.
    /// - Parameter pagingQuery: ID of the Context to get the Stores from
    ///
    /// - Throws: `PrivMXEndpointError.failedListingStores` if listing Stores fails.
    ///
    /// - Returns: struct with list query parameters
    public func listStores(
		contextId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.StoreList {
		let res = api.listStores(contextId, pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingStores(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingStores(err)
		}
		return result
	}
	
	@available(*, deprecated, renamed: "listStores(contextId:pagingQuery:)")
	public func listStores(
		contextId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.StoreList {
		try listStores(contextId: contextId, pagingQuery: query)
	}
	
	/// Gets a single Store by given Store ID.
    ///
    /// - Parameter storeId: ID of the Store to get
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingStore` if fetching the Store details fails.
    ///
    /// - Returns: struct containing information about the Store
    public func getStore(
		storeId: std.string
	) throws -> privmx.endpoint.store.Store{
		
		let res = api.getStore(storeId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingStore(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingStore(err)
		}
		return result
	}
	
	/// Creates a new Store in given Context.
    ///
    /// - Parameter contextId: ID of the Context to create the Store in
    /// - Parameter users: vector of UserWithPubKey structs which indicates who will have access to the created Store
    /// - Parameter managers: vector of UserWithPubKey structs which indicates who will have access (and management rights) to the
	/// created store
    /// - Parameter publicMeta: public (unencrypted) metadata
    /// - Parameter privateMeta: private (encrypted) metadata
	/// - Parameter policies: Store's policies
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingStore` if Store creation fails.
    ///
    /// - Returns: created Store ID
    public func createStore(
		contextId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		policies: privmx.endpoint.core.ContainerPolicy? = nil
	) throws -> std.string{
		
		var optPolicies = privmx.OptionalContainerPolicy()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = api.createStore(contextId,
								  users, 
								  managers,
								  publicMeta,
								  privateMeta,
								  optPolicies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingStore(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingStore(err)
		}
		return result
	}
	
	/// Updates an existing Store.
	///
    /// - Parameter storeId: ID of the Store to update
    /// - Parameter version: vector of UserWithPubKey structs which indicates who will have access to the created Store
    /// - Parameter users: vector of UserWithPubKey structs which indicates who will have access (and management rights) to the
    /// - Parameter managers: public (unencrypted) metadata
    /// - Parameter publicMeta: private (encrypted) metadata
    /// - Parameter privateMeta: current version of the updated Store
    /// - Parameter force: force update (without checking version)
    /// - Parameter forceGenerateNewKey: force to regenerate a key for the Store
	/// - Parameter policies: Store's policies
    ///
    /// - Throws: `PrivMXEndpointError.failedUpdatingStore` if updating the Store fails.
    public func updateStore(
		storeId: std.string,
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
		
		let res = api.updateStore(storeId,
								  users,
								  managers,
								  publicMeta,
								  privateMeta,
								  version,
								  force,
								  forceGenerateNewKey,
								  optPolicies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingStore(res.error.value!)
		}
	}
	
	/// Deletes a Store by given Store ID.
    ///
    /// - Parameter storeId: ID of the Store to delete
    ///
    /// - Throws: `PrivMXEndpointError.failedDeletingStore` if deleting the Store fails.
    public func deleteStore(
		storeId: std.string
	) throws -> Void {
		
		let res = api.deleteStore(storeId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingStore(res.error.value!)
		}
	}
	
	/// Gets a single file by the given file ID.
    ///
    /// - Parameter fileId: ID of the file to get
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingFile` if fetching the file details fails.
    ///
    /// - Returns: struct containing information about the file
    public func getFile(
		fileId: std.string
	) throws -> privmx.endpoint.store.File{
		
		let res = api.getFile(fileId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGettingFile(err)
		}
		return result
	}
	
	/// Gets a list of files in given Store.
    ///
    /// - Parameter storeId: ID of the Store to get files from
    /// - Parameter pagingQuery: struct with list query parameters
    ///
    /// - Throws: `PrivMXEndpointError.failedListingFiles` if listing the files fails.
    ///
    /// - Returns: struct containing list of files
    public func listFiles(
		storeId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.FileList{
		let res = api.listFiles(storeId, pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingFiles(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingFiles(err)
		}
		return result
	}
	
	@available(*, deprecated, renamed:"listFiles(storeId:pagingQuery:)")
	public func listFiles(
		storeId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.FileList{
		try listFiles(storeId: storeId, pagingQuery: query)
	}
	
	/// Creates a new file in a Store.
    ///
    /// - Parameter storeId: ID of the Store to create the file in
    /// - Parameter publicMeta: public file metadata
    /// - Parameter privateMeta: private file metadata
    /// - Parameter size: size of the file
    /// - Parameter randomWriteSupport: enable random write support for file
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingFile` if creating the file handle fails.
    ///
    /// - Returns: handle to write data
    public func createFile(
		storeId: std.string,
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer,
		size: Int64,
		randomWriteSupport: Bool = false
	) throws -> privmx.StoreFileHandle{
		let res = api.createFile(storeId,publicMeta,privateMeta,size,randomWriteSupport)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedCreatingFile(err)
		}
		return result
	}
	
	/// Moves read cursor.
    ///
    /// - Parameter handle: handle to write file data
    /// - Parameter position: new cursor position
    ///
    /// - Throws: `PrivMXEndpointError.failedSeekingInFile` if moving the cursor fails.
    public func seekInFile(
		handle: privmx.StoreFileHandle,
		position: Int64
	) throws -> Void {
		let res = api.seekInFile(handle, position)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSeekingInFile(res.error.value!)
		}
	}
	
	/// Update an existing file in a Store.
    ///
    /// - Parameter fileId: ID of the file to update
    /// - Parameter publicMeta: public file metadata
    /// - Parameter privateMeta: private file metadata
    /// - Parameter size: size of the file
    ///
    /// - Throws: `PrivMXEndpointError.failedUpdatingFile` if updating the file fails.
    ///
    /// - Returns: handle to write file data
   public func updateFile(
		fileId: std.string,
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer,
		size: Int64
	) throws -> privmx.StoreFileHandle {
		let res = api.updateFile(fileId, publicMeta, privateMeta, size)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingFile(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedUpdatingFile(err)
		}
		return result
	}
	
	/// Update metadata of an existing file in a Store.
	///
	/// - Parameter fileId: ID of the file to update
	/// - Parameter publicMeta: public file metadata
	/// - Parameter privateMeta: private file metadata
	///
	/// - Throws: When an error occurs during updating metadata.
	public func updateFileMeta(
		fileId: std.string,
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer
	) throws -> Void {
		let res = api.updateFileMeta(fileId, publicMeta, privateMeta)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingFile(res.error.value!)
		}
	}
	
	/// Closes the file handle.
    ///
    /// - Parameter handle: handle to read/write file data
    ///
    /// - Throws: `PrivMXEndpointError.failedClosingFile` if closing the file handle fails.
    ///
    /// - Returns: ID of closed file
   public func closeFile(
		handle: privmx.StoreFileHandle
	) throws -> std.string {
		let res = api.closeFile(handle)
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
	
	/// Opens a file to read.
    ///
    /// - Parameter fileId: ID of the file to read
    ///
    /// - Throws: `PrivMXEndpointError.failedOpeningFile` if opening the file fails.
    ///
    /// - Returns: handle to read file data
   public func openFile(
		fileId: std.string
	) throws -> privmx.StoreFileHandle {
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
	
	
	/// Reads file data.
	/// Single read call moves the files's cursor position by declared length or set it at the end of the file.
    ///
    /// - Parameter handle: handle to write file data
    /// - Parameter length: size of data to read
    ///
    /// - Throws: `PrivMXEndpointError.failedReadingFromFile` if reading from the file fails.
    ///
    /// - Returns: buffer with file data chunk
    public func readFromFile(
		handle: privmx.StoreFileHandle,
		length: Int64
	) throws -> privmx.endpoint.core.Buffer{
		let res = api.readFromFile(handle,length)
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
	
	/// Writes a file data.
    ///
    /// - Parameter handle: handle to write file data
    /// - Parameter dataChunk: file data chunk
    /// - Parameter truncate: truncate the file from: current pos + dataChunk size
    ///
    /// - Throws: `PrivMXEndpointError.failedWritingToFile` if writing to the file fails.
    public func writeToFile(
		handle: privmx.StoreFileHandle,
		dataChunk: privmx.endpoint.core.Buffer,
		truncate: Bool = false
	) throws -> Void{
		
		let res = api.writeToFile(handle,dataChunk,truncate)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWritingToFile(res.error.value!)
		}
	}
	
	/// Deletes a file by given ID.
    ///
    /// - Parameter fileId: ID of the file to delete
    ///
    /// - Throws: `PrivMXEndpointError.failedDeletingFile` if deleting the file fails.
    public func deleteFile(
		fileId: std.string
	) throws -> Void {
		let res = api.deleteFile(fileId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingFile(res.error.value!)
		}
	}
	
	/// Synchronize file handle data with newset data on serwer.
	///
	/// - Parameter handle: Store File handle to sync
	///
	/// - Throws: if the operation fails.
	public func syncFile(
		handle: privmx.StoreFileHandle
	) throws -> Void {
		let res = api.syncFile(handle)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSyncingFile(res.error.value!)
		}
	}
	
	/// Subscribe for the Store events on the given subscription query.
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
	
	/// Generate subscription Query for the Store events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter selectorType: scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQuery(
	eventType: privmx.endpoint.store.EventType,
	selectorType: privmx.endpoint.store.EventSelectorType,
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
