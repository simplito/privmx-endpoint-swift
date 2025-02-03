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

#ifndef StoresApi_hpp
#define StoresApi_hpp

#include "PrivMXUtils.hpp"
#include "NativeConnectionWrapper.hpp"

namespace privmx {

/**
 * C++ wrapper of `privmx::endpoint::store::StoreApi`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeStoreApiWrapper{
	friend class NativeInboxApiWrapper;
public:
	/**
	 * Creates a new instance of the class.
	 *
	 * @param connection: NativeConnectionWrapper& — a reference to an instance of `privmx::NativeConnectionWrapper`
	 */
	static ResultWithError<NativeStoreApiWrapper> create(NativeConnectionWrapper& connection);
	
	/**
	 * Lists Stores the user has access to in the provided Context.
	 *
	 * @param contextId : `const std::string&` — from which Context should the Threads be listed
	 * @param pagingQuery : `privmx::endpoint::core::PagingQuery` — parameters of the query
	 *
	 * @return `privmx::StoreList` aka `privmx::endpoint::core::PagingList<privmx::endpoint::store::Store>` instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<StoreList> listStores(const std::string& contextId,
														   const endpoint::core::PagingQuery& pagingQuery);
	
	/**
	 * Retrieves information about a Store.
	 *
	 * @param storeId : `const std::string&` — which Store is to be retrieved
	 *
	 * @return `privmx::endpoint::store::Store`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::store::Store> getStore(const std::string& storeId);
	
	/**
	 * Creates a new Store in the specified Context
	 *
	 * Note that managers do not gain acess to the Store without being added as users.
	 *
	 * @param contextId : `const std::string&` — in which Context should the Store be created
	 * @param users : `const UserWithPubKeyVector&` — who can access the Store
	 * @param managers : `const UserWithPubKeyVector&` — who can manage the Store
	 * @param publicMeta public (unencrypted) metadata
	 * @param privateMeta private (encrypted) metadata
	 * @param policies additional container access policies
	 *
	 * @return Id of the newly created Store wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<std::string> createStore(const std::string& contextId,
											 const UserWithPubKeyVector& users,
											 const UserWithPubKeyVector& managers,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const OptionalContainerPolicy& policies = std::nullopt);
	
	/**
	 * Deletes a Store.
	 *
	 * @param storeId : `const std::string&` — which Store is to be deleted
	 *
	 * @return A `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> deleteStore(const std::string& storeId);
	
	/**
	 * Updates an existing Store.
	 *
	 * The provided values override preexisting values.
	 *
	 * @param storeId : `const std::string&` — which Store is to be updated
	 * @param users : `const UserWithPubKeyVector&` — who can access the Store
	 * @param managers : `const UserWithPubKeyVector&` — who can manage the Store
	 * @param publicMeta public (unencrypted) metadata
	 * @param privateMeta private (encrypted) metadata
	 * @param version : `const int64_t` — current version of the Store
	 * @param force : `const bool` — force the update by disregarding the cersion check
	 * @param forceGenerateNewKey force to regenerate a key for the Store
	 * @param policies additional container access policies
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> updateStore(const std::string& storeId,
												const UserWithPubKeyVector& users,
												const UserWithPubKeyVector& managers,
												const endpoint::core::Buffer& publicMeta,
												const endpoint::core::Buffer& privateMeta,
												const int64_t version,
												const bool force,
												const bool forceGenerateNewKey,
												const OptionalContainerPolicy& = std::nullopt);
	
	/**
	 * Retrieves information about a File
	 *
	 * This does not download the file itself, for that see `openFile()` and `readFromFile()`
	 *
	 * @param threadId : `const std::string&` — which Thread is to be updated
	 *
	 * @return Information about the specified file wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::store::File> getFile(const std::string& fileId);
	
	/**
	 * Lists  information about  Files in a Store
	 *
	 * This does not download the files themselves, for that see `openFile()` and `readFromFile()`
	 *
	 * @param storeId : `const std::string&` — from which Store should the Files be listed
	 *
	 * @return `privmx::FileList` wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<FileList> listFiles(const std::string& storeId,
										const endpoint::core::PagingQuery& pagingQuery);
	
	/**
	 * Creates a new file handle for writing in a Store
	 *
	 * This creates a temporary file, use `writeToFile()` to upload data and `closeFile()` to finalise the process.
	 *
	 * @param storeId : `const std::string&` — in which Store should the File be created
	 * @param size : `const int64_t` — the size of the file
	 * @param mimetype : `const std::string&` — type of the file
	 * @param name : `const std::string&` — the name of the file
	 *
	 * @return `privmx::PMXFileHandle` for writing, wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<StoreFileHandle> createFile(const std::string &storeId,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  int64_t size);
	
	/**
	 * Creates a new file handle for overwiting a file.
	 *
	 * @param fileId : `const std::string&` — which File should be updated
	 * @param size : `const int64_t` — the size of the file
	 * @param mimetype : `const std::string&` — type of the file
	 * @param name : `const std::string&` — the name of the file
	 *
	 * @return `privmx::PMXFileHandle` for writing, wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<StoreFileHandle> updateFile(const std::string& fileId,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  int64_t size);
	
	/**
	 * Update metadata of an existing file in a Store.
	 *
	 * @param fileId ID of the file to update
	 * @param publicMeta public file metadata
	 * @param privateMeta private file metadata
	 */
	ResultWithError<std::nullptr_t> updateFileMeta(const std::string& fileId,
												   const endpoint::core::Buffer& publicMeta,
												   const endpoint::core::Buffer& privateMeta);
	/**
	 * Creates a new file handle for reading a File.
	 *
	 * @param fileId : `const std::string&` — which File should be opened
	 *
	 * @return `privmx::PMXFileHandle` for reading, wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<StoreFileHandle> openFile(const std::string& fileId);
	
	/**
	 * Writes a chunk of data to an opened file on the Platform.
	 *
	 * @param handle : `const PMXFileHandle` aka `const int64_t` — the handle to an opened file
	 * @param dataChunk : `const privmx::endpoint::core::Buffer&` — the data to be uploaded
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> writeToFile(const StoreFileHandle handle,
												const endpoint::core::Buffer& dataChunk);
	
	/**
	 * Reads from an opened file.
	 *
	 * @param handle : `const PMXFileHandle` aka `const int64_t` — the handle to an opened file
	 * @param length : `const int64_t` — amount of bytes to be read
	 *
	 * @return The downloaded data read from a file, wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::core::Buffer> readFromFile(const StoreFileHandle handle,
														 int64_t length);
	
	/**
	 * Moves read cursor in an open File.
	 *
	 * @param handle : `const PMXFileHandle` aka `const int64_t` — the handle to an opened file
	 * @param pos : `const int64_t` — new position of the cursor
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> seekInFile(const StoreFileHandle handle,
											   int64_t position);
	
	/**
	 * Closes an open File
	 *
	 * @param handle : `const PMXFileHandle` aka `const int64_t` — the handle to an open file
	 *
	 * @return The Id of the File, wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<std::string> closeFile(const StoreFileHandle handle);
	
	
	/**
	 * Deletes the specified File.
	 *
	 *
	 * @param fileId : `const std::string&` — File to be deleted
	 *
	 *
	 * @return Status of the operation, wrapped in a  `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> deleteFile(const std::string& fileId);
	
	ResultWithError<std::nullptr_t> subscribeForStoreEvents();
	ResultWithError<std::nullptr_t> unsubscribeFromStoreEvents();
	ResultWithError<std::nullptr_t> subscribeForFileEvents(const std::string& storeId);
	ResultWithError<std::nullptr_t> unsubscribeFromFileEvents(const std::string& storeId);
	
private:
	std::shared_ptr<endpoint::store::StoreApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
	NativeStoreApiWrapper() = default;
	NativeStoreApiWrapper(NativeConnectionWrapper& connection);
	
	std::shared_ptr<endpoint::store::StoreApi> api;
	
};

class StoreEventHandler{
public:
/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreCreatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreCreatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreCreatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreCreatedEvent> extractStoreCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreUpdatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreUpdatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreUpdatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreUpdatedEvent> extractStoreUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreDeletedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreDeletedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreDeletedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreDeletedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreDeletedEvent> extractStoreDeletedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreStatsChangedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreStatsChangedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreStatsChangedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreStatsChangedEvent> extractStoreStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreFileCreatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreFileCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreFileCreatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreFileCreatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreFileCreatedEvent> extractStoreFileCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreFileUpdatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreFileUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreFileUpdatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreFileUpdatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreFileUpdatedEvent> extractStoreFileUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::store::StoreFileDeletedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isStoreFileDeletedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::store::StoreFileDeletedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::store::StoreFileDeletedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::store::StoreFileDeletedEvent> extractStoreFileDeletedEvent(const endpoint::core::EventHolder& eventHolder);

};

}
#endif /* StoresApi_hpp */
