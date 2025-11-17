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
	
	static ResultWithError<NativeStoreApiWrapper> create(NativeConnectionWrapper& connection);
	
	ResultWithError<StoreList> listStores(const std::string& contextId,
														   const endpoint::core::PagingQuery& pagingQuery);
	
	ResultWithError<endpoint::store::Store> getStore(const std::string& storeId);
	
	ResultWithError<std::string> createStore(const std::string& contextId,
											 const UserWithPubKeyVector& users,
											 const UserWithPubKeyVector& managers,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const OptionalContainerPolicy& policies = std::nullopt);
	
	ResultWithError<std::nullptr_t> deleteStore(const std::string& storeId);
	
	ResultWithError<std::nullptr_t> updateStore(const std::string& storeId,
												const UserWithPubKeyVector& users,
												const UserWithPubKeyVector& managers,
												const endpoint::core::Buffer& publicMeta,
												const endpoint::core::Buffer& privateMeta,
												const int64_t version,
												const bool force,
												const bool forceGenerateNewKey,
												const OptionalContainerPolicy& = std::nullopt);
	
	ResultWithError<endpoint::store::File> getFile(const std::string& fileId);
	
	ResultWithError<FileList> listFiles(const std::string& storeId,
										const endpoint::core::PagingQuery& pagingQuery);
	
	ResultWithError<StoreFileHandle> createFile(const std::string &storeId,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  int64_t size,
												bool randomWriteSupport = false);
	
	ResultWithError<StoreFileHandle> updateFile(const std::string& fileId,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  int64_t size);
	
	ResultWithError<std::nullptr_t> updateFileMeta(const std::string& fileId,
												   const endpoint::core::Buffer& publicMeta,
												   const endpoint::core::Buffer& privateMeta);

	ResultWithError<StoreFileHandle> openFile(const std::string& fileId);
	

	ResultWithError<std::nullptr_t> writeToFile(const StoreFileHandle handle,
												const endpoint::core::Buffer& dataChunk,
												bool truncate=false);

	ResultWithError<endpoint::core::Buffer> readFromFile(const StoreFileHandle handle,
														 int64_t length);
	
	ResultWithError<std::nullptr_t> seekInFile(const StoreFileHandle handle,
											   int64_t position);
	
	ResultWithError<std::string> closeFile(const StoreFileHandle handle);
	
	ResultWithError<std::nullptr_t> deleteFile(const std::string& fileId);
	
	ResultWithError<std::nullptr_t> syncFile(const StoreFileHandle handle);
	
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);

	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionIdVector& subscriptionIds);
	
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::store::EventType eventType,
															  endpoint::store::EventSelectorType selectorType,
															  const std::string& selectorId);

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
