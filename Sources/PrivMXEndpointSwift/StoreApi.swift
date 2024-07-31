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

/// Swift wrapper for `privmx.NativeStoreApiWrapper`.
public class StoreApi{
	/// An instance of the wrapped C++ class.
	internal var api: privmx.NativeStoreApiWrapper
	
	/// Creates a new StoreApi instance
	/// - Parameter coreApi: a CoreApi instance
	public init(
		coreApi: inout CoreApi
	){
		self.api = privmx.NativeStoreApiWrapper.create(&coreApi.api)
	}
	
	/// Lists Stores the user has access to in provided Context.
	///
	/// - Parameter contextId: from which Context should the Stores be listed
	/// - Parameter query: parameters of the query
	///
	/// - Returns:`privmx.endpoint.store.StoresList`instance.
	///
	/// - Throws: `PrivMXEndpointError.failedListingStores` if an exception was thrown in C++ code, or another error occurred.
	public func listStores(
		from contextId: std.string,
		query: privmx.endpoint.core.ListQuery
	) throws -> privmx.endpoint.store.StoresList {
		let res = api.storeList(contextId, query)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedListingStores(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedListingStores(msg: "Unexpectedly received nil result")
		}
		return result
		
	}
	
	/// Retrieves information about a Store.
	///
	/// - Parameter storeId : information about which Store is to be retrieved.
	///
	/// - Returns: Information about a Store
	///
	/// - Throws: `PrivMXEndpointError.failedGettingStore` if an exception was thrown in C++ code, or another error occurred.
	public func getStore(
		_ storeId: std.string
	) throws -> privmx.endpoint.store.StoreInfo{
		
		let res = api.storeGet(storeId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGettingStore(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGettingStore(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Creates a new Store in the specified Context.
	///
	/// Note that managers do not gain acess to the Store without being added as users.
	///
	/// - Parameter contextId: in which Context should the Store be created
	/// - Parameter users: who can access the Store
	/// - Parameter managers: who can manage the Store
	/// - Parameter name: the name of the Store
	///
	/// - Returns:Id of the newly created Store
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingStore` if an exception was thrown in C++ code, or another error occurred.
	public func createStore(
		in contextId: std.string,
		with users: privmx.UserWithPubKeyVector,
		managedBy managers: privmx.UserWithPubKeyVector,
		named name: std.string
	) throws -> std.string{
		let res = api.storeCreate(contextId, users, managers, name)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedCreatingStore(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedCreatingStore(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Updates an existing Store.
	///
	/// The provided values override preexisting values.
	///
	/// - Parameter contextId: which Store is to be updated
	/// - Parameter users: who can access the Store
	/// - Parameter managers: who can manage the Store
	/// - Parameter name: the title of the Store
	/// - Parameter version: current version of the Store
	/// - Parameter force: force the update by disregarding the version check
	/// - Parameter generateNewKeyId: force regeneration of new keyId for Store
	/// - Parameter accessToOldDataForNewUsers: placeholder parameter (does nothing for now)
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingStore` if an exception was thrown in C++ code, or another error occurred.
	public func updateStore(
		_ storeId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		name: std.string,
		version: Int64,
		force: Bool,
		generateNewKeyId: Bool,
		accessToOldDataForNewUsers: Bool
	) throws -> Void {
		let res = api.storeUpdate(storeId,
								  users,
								  managers,
								  name,
								  version,
								  force,
								  generateNewKeyId,
								  accessToOldDataForNewUsers)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedUpdatingStore(msg: String(res.error))
		}
	}
	
	/// Deletes a Store.
	///
	/// - Parameter storeId: which Store is to be deleted
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingStore` if an exception was thrown in C++ code, or another error occurred.
	public func deleteStore(
		_ storeId: std.string
	) throws -> Void {
		
		let res = api.storeDelete(storeId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDeletingStore(msg: String(res.error))
		}
	}
	
	/// Retrieves information about a File.
	///
	/// - Parameter fileId : information about which File is to be retrieved.
	///
	/// - Returns: Information about a File
	///
	/// - Throws: `PrivMXEndpointError.failedGettingFile` if an exception was thrown in C++ code, or another error occurred.
	public func getFile(
		_ fileId: std.string
	) throws -> privmx.endpoint.core.FileInfo{
		
		let res = api.fileGet(fileId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGettingFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGettingFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Lists  information about  Files in a Store
	///
	/// This does not download the files themselves, for that see `fileOpen()` and `fileRead()`
	///
	/// - Parameter storeId: from which Store should the Files be listed
	/// - Parameter query: parameters of the query
	///
	/// - Returns:`privmx.endpoint.core.FilesList`instance.
	///
	/// - Throws: `PrivMXEndpointError.failedListingFiles` if an exception was thrown in C++ code, or another error occurred.
	public func listFiles(
		from storeId: std.string,
		query: privmx.endpoint.core.ListQuery
	) throws -> privmx.endpoint.core.FilesList{
		let res = api.fileList(storeId, query)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedListingFiles(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedListingFiles(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Creates a new file handle for writing in a Store
	///
	/// This creates a temporary file, use `fileWrite()` to upload data and `fileClose()` to finish the process.
	///
	/// - Parameter storeId:in which Store should the File be created
	/// - Parameter size:the size of the file
	/// - Parameter mimetype:type of the file
	/// - Parameter name:the name of the file
	///
	/// - Returns: `privmx.PMXFileHandle` for writing,
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingFile` if an exception was thrown in C++ code, or another error occurred.
	public func createFile(
		in storeId: std.string,
		size: Int64,
		mimetype: std.string,
		name: std.string
	) throws -> privmx.PMXFileHandle{
		let res = api.fileCreate(storeId,size,mimetype,name)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedCreatingFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedCreatingFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Moves read cursor in an open File.
	///
	/// - Parameter handle: the handle to an opened file
	/// - Parameter pos: new position of the cursor
	///
	/// - Throws: `PrivMXEndpointError.failedSeekingInFile` if an exception was thrown in C++ code, or another error occurred.
	public func seekInFile(
		handle: privmx.PMXFileHandle,
		pos: Int64
	) throws -> Void {
		let res = api.fileSeek(handle, pos)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedSeekingInFile(msg: String(res.error))
		}
	}
	
	/// Creates a new file handle for overwiting a file.
	///
	/// - Parameter fileId: Which File should be updated
	/// - Parameter size:the size of the file
	/// - Parameter mimetype:type of the file
	/// - Parameter name:the name of the file
	///
	/// - Returns: `privmx.PMXFileHandle` for writing,
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingFile` if an exception was thrown in C++ code, or another error occurred.
	public func updateFile(
		_ fileId: std.string,
		size: Int64,
		mimetype: std.string,
		name: std.string
	) throws -> privmx.PMXFileHandle {
		let res = api.fileUpdate(fileId, size, mimetype, name)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedUpdatingFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedUpdatingFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Closes an open File
	///
	/// - Parameter handle: the handle to an open file
	///
	/// - Returns: The Id of the File
	///
	/// - Throws: `PrivMXEndpointError.failedClosingFile` if an exception was thrown in C++ code, or another error occurred.
	public func closeFile(
		handle: privmx.PMXFileHandle
	) throws -> std.string {
		let res = api.fileClose(handle)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedClosingFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedClosingFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Creates a new file handle for reading a File.
	///
	/// - Parameter fileId: which File should be opened
	///
	/// - Returns: `privmx.PMXFileHandle` for reading
	///
	/// - Throws: `PrivMXEndpointError.failedOpeningFile` if an exception was thrown in C++ code, or another error occurred.
	public func openFile(
		_ fileId: std.string
	) throws -> privmx.PMXFileHandle {
		let res = api.fileOpen(fileId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedOpeningFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedOpeningFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Reads from an opened file.
	///
	/// - Parameter handle: the handle to an opened File
	/// - Parameter length: amount of bytes to be read
	///
	/// - Returns: `privmx.PMXFileHandle` for reading
	///
	/// - Throws: `PrivMXEndpointError.failedReadingFromFile` if an exception was thrown in C++ code, or another error occurred.
	public func readFile(
		handle: privmx.PMXFileHandle,
		length: Int64
	) throws -> privmx.endpoint.core.Buffer{
		let res = api.fileRead(handle,length)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedReadingFromFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedReadingFromFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Writes a chunk of data to an opened file on the Platform.
	///
	/// - Parameter handle: the handle to an opened file
	/// - Parameter dataChunk:  the data to be uploaded
	///
	/// - Throws: `PrivMXEndpointError.failedWritingToFile` if an exception was thrown in C++ code, or another error occurred.
	public func writeFile(
		handle: privmx.PMXFileHandle,
		dataChunk: privmx.endpoint.core.Buffer
	) throws -> Void{
		
		let res = api.storeFileWrite(handle,dataChunk)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedWritingToFile(msg: String(res.error))
		}
	}
	
	/// Deletes the specified File.
	///
	/// - Parameter fileId: which File should be deleted
	///
	/// - Returns: True if the file was delted succesfuly, false othrewise
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingFile` if an exception was thrown in C++ code, or another error occurred.
	public func deleteFile(
		_ fileId: std.string
	) throws -> Bool{
		
		let res = api.fileDelete(fileId)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDeletingFile(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedDeletingFile(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreCreatedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreCreatedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreUpdatedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreUpdatedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreDeletedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreDeletedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreStatsChangedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreStatsChangedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreStatsChangedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreStatsChangedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreFileCreatedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreFileCreatedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreFileCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreFileCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreFileUpdatedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreFileUpdatedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreFileUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreFileUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.store.StoreFileDeletedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of StoreFileDeletedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isStoreFileDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeStoreApiWrapper.isStoreFileDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreCreatedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreCreatedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreCreatedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreUpdatedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreUpdatedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreUpdatedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreDeletedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreDeletedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreDeletedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreStatsChangedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreStatsChangedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreStatsChangedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreStatsChangedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreStatsChangedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreFileCreatedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreFileCreatedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreFileCreatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileCreatedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreFileCreatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreFileUpdatedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreFileUpdatedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreFileUpdatedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileUpdatedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreFileUpdatedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.store.StoreFileDeletedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.store.StoreFileDeletedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractStoreFileDeletedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.store.StoreFileDeletedEvent {
		let res = privmx.NativeStoreApiWrapper.extractStoreFileDeletedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
}
