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

/// Swift wrapper for `privmx.NativeStoreApiWrapper`, providing functionality to manage Stores and files within PrivMX platform.
public class StoreApi{
	
	/// An instance of the wrapped C++ class.
    internal var api: privmx.NativeStoreApiWrapper
	
	/// Creates a new instance of `StoreApi` from a connection object.
    ///
    /// This method initializes the `StoreApi` instance, enabling Store-related operations over the specified connection.
    ///
    /// - Parameter connection: The connection object used for Store operations.
    ///
    /// - Throws: `PrivMXEndpointError.failedInstantiatingStoreApi` if the initialization fails.
    ///
    /// - Returns: A newly created `StoreApi` instance.
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
	
	/// Lists all Stores the user has access to within a specified Context.
    ///
    /// - Parameters:
    ///   - contextId: The Context from which the Stores should be listed.
    ///   - query: A `PagingQuery` object to filter and paginate the results.
    ///
    /// - Throws: `PrivMXEndpointError.failedListingStores` if listing Stores fails.
    ///
    /// - Returns: A `privmx.StoreList` instance containing the list of Stores.
    public func listStores(
		contextId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.StoreList {
		let res = api.listStores(contextId, query)
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
	
	/// Retrieves detailed information about a specified Store.
    ///
    /// - Parameter storeId: The unique identifier of the Store to retrieve.
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingStore` if fetching the Store details fails.
    ///
    /// - Returns: A `privmx.endpoint.store.Store` instance containing Store details.
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
	
	/// Creates a new Store within a specified Context.
    ///
    /// This method creates a new Store with specified users and managers. Note that managers must be added as users to gain access to the Store.
	///
	/// If `policies` argument is set to `nil`, the default policies will be applied.
    ///
    /// - Parameters:
    ///   - contextId: The Context in which the Store should be created.
    ///   - users: A vector of users who will have access to the Store.
    ///   - managers: A vector of managers responsible for the Store.
    ///   - publicMeta: Public metadata for the Store, which will not be encrypted.
    ///   - privateMeta: Private metadata for the Store, which will be encrypted.
	///   - policies: A set of policies for the Container.
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingStore` if Store creation fails.
    ///
    /// - Returns: The ID of the newly created Store as a `std.string`.
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
    /// The provided values will override the existing ones. You can also force regeneration of the Store's key if needed.
	///
	/// If `policies` argument is set to `nil`, the default policies will be applied.
    ///
    /// - Parameters:
    ///   - storeId: The unique identifier of the Store to be updated.
    ///   - version: The current version of the Store for consistency checking.
    ///   - users: A vector of users who will have access to the Store.
    ///   - managers: A vector of managers responsible for the Store.
    ///   - publicMeta: New public metadata for the Store, which will not be encrypted.
    ///   - privateMeta: New private metadata for the Store, which will be encrypted.
    ///   - force: Whether to force the update, bypassing version control.
    ///   - forceGenerateNewKey: Whether to generate a new key for the Store.
	///   - policies: New set of policies for the Container.
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
	
	 /// Deletes a specified Store.
    ///
    /// - Parameter storeId: The unique identifier of the Store to delete.
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
	
	/// Retrieves detailed information about a specified file.
    ///
    /// - Parameter fileId: The unique identifier of the file to retrieve.
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingFile` if fetching the file details fails.
    ///
    /// - Returns: A `privmx.endpoint.store.File` instance representing the file details.
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
	
	/// Lists all files in a specified Store.
    ///
    /// This method retrieves metadata about files in the Store. To download files, use the `openFile()` and `readFile()` methods.
    ///
    /// - Parameters:
    ///   - storeId: The Store from which to list files.
    ///   - query: A `PagingQuery` object to filter and paginate the results.
    ///
    /// - Throws: `PrivMXEndpointError.failedListingFiles` if listing the files fails.
    ///
    /// - Returns: A `privmx.FileList` instance containing the list of files.
    public func listFiles(
		storeId: std.string,
		query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.FileList{
		let res = api.listFiles(storeId, query)
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
	
	/// Creates a new file handle for writing in a Store.
    ///
    /// Use `writeToFile()` to upload data to this handle and `closeFile()` to finalize the process.
    ///
    /// - Parameters:
    ///   - storeId: The Store in which the file should be created.
    ///   - publicMeta: Public metadata for the file.
    ///   - privateMeta: Private metadata for the file.
    ///   - size: The size of the file in bytes.
    ///
    /// - Throws: `PrivMXEndpointError.failedCreatingFile` if creating the file handle fails.
    ///
    /// - Returns: A `privmx.StoreFileHandle` for writing to the file.
    public func createFile(
		storeId: std.string,
		publicMeta:privmx.endpoint.core.Buffer,
		privateMeta:privmx.endpoint.core.Buffer,
		size: Int64
	) throws -> privmx.StoreFileHandle{
		let res = api.createFile(storeId,publicMeta,privateMeta,size)
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
	
	/// Moves the read cursor within an open file.
    ///
    /// - Parameters:
    ///   - handle: The handle to the open file.
    ///   - position: The new position of the read cursor in bytes.
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
	
	/// Updates an existing file within a Store.
    ///
    /// This method creates a new handle for updating the file's content and metadata. Use `writeToFile()` to upload data and `closeFile()` to finalize the update.
    ///
    /// - Parameters:
    ///   - fileId: The unique identifier of the file to be updated.
    ///   - publicMeta: New public metadata for the file.
    ///   - privateMeta: New private metadata for the file.
    ///   - size: The size of the updated file in bytes.
    ///
    /// - Throws: `PrivMXEndpointError.failedUpdatingFile` if updating the file fails.
    ///
    /// - Returns: A `privmx.StoreFileHandle` for writing to the updated file.
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
	
	/// Closes an open file handle.
    ///
    /// This method finalizes a file operation, such as writing or updating.
    ///
    /// - Parameter handle: The handle to the open file.
    ///
    /// - Throws: `PrivMXEndpointError.failedClosingFile` if closing the file handle fails.
    ///
    /// - Returns: The ID of the closed file as a `std.string`.
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
	
	/// Opens a file for reading from the Store.
    ///
    /// - Parameter fileId: The unique identifier of the file to be opened.
    ///
    /// - Throws: `PrivMXEndpointError.failedOpeningFile` if opening the file fails.
    ///
    /// - Returns: A `privmx.StoreFileHandle` for reading the file.
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
	
	
	/// Reads data from an open file.
    ///
    /// - Parameters:
    ///   - handle: The handle to the open file.
    ///   - length: The number of bytes to read.
    ///
    /// - Throws: `PrivMXEndpointError.failedReadingFromFile` if reading from the file fails.
    ///
    /// - Returns: A buffer containing the read data.
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
	
	/// Writes a chunk of data to an open file on the platform.
    ///
    /// - Parameters:
    ///   - handle: The handle to the open file.
    ///   - dataChunk: The chunk of data to be written to the file.
    ///
    /// - Throws: `PrivMXEndpointError.failedWritingToFile` if writing to the file fails.
    public func writeToFile(
		handle: privmx.StoreFileHandle,
		dataChunk: privmx.endpoint.core.Buffer
	) throws -> Void{
		
		let res = api.writeToFile(handle,dataChunk)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedWritingToFile(res.error.value!)
		}
	}
	
	/// Deletes a specified file from the Store.
    ///
    /// - Parameter fileId: The unique identifier of the file to delete.
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
	
	/// Subscribes to Store-related events.
    ///
    /// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to Store events fails.
    public func subscribeForStoreEvents(
	) throws -> Void {
		let res = api.subscribeForStoreEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	/// Unsubscribes from Store-related events.
    ///
    /// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from Store events fails.
    public func unsubscribeFromStoreEvents(
	) throws -> Void {
		let res = api.unsubscribeFromStoreEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Subscribes to file-related events within a specified Store.
    ///
    /// - Parameter storeId: The unique identifier of the Store to subscribe to file events for.
    ///
    /// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to file events fails.
   public func subscribeForFileEvents(
		storeId: std.string
	) throws -> Void {
		let res = api.subscribeForFileEvents(storeId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	/// Unsubscribes from file-related events within a specified Store.
    ///
    /// - Parameter storeId: The unique identifier of the Store to unsubscribe from file events for.
    ///
    /// - Throws: `PrivMXEndpointError.failedUnsubscribingFromEvents` if unsubscribing from file events fails.
    public func unsubscribeFromFileEvents(
		storeId: std.string
	) throws -> Void {
		let res = api.unsubscribeFromFileEvents(storeId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
}
