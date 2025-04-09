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

#include "PrivMXUtils.hpp"
#include "NativeConnectionWrapper.hpp"

namespace privmx {

class NativeKvdbApiWrapper {
public:
	/**
	 * Creates an instance of 'KvdbApi'.
	 *
	 * @param connection instance of 'Connection'
	 *
	 * @return KvdbApi object
	 */
	static ResultWithError<NativeKvdbApiWrapper> create(NativeConnectionWrapper& connection);
	
	ResultWithError<std::string> createKvdb(const std::string& contextId,
											const UserWithPubKeyVector& users,
											const UserWithPubKeyVector& managers,
											const endpoint::core::Buffer& publicMeta,
											const endpoint::core::Buffer& privateMeta,
											const OptionalContainerPolicy& policies);
	ResultWithError<std::nullptr_t> updateKvdb(const std::string& kvdbId,
											   const UserWithPubKeyVector& users,
											   const UserWithPubKeyVector& managers,
											   const endpoint::core::Buffer& publicMeta,
											   const endpoint::core::Buffer& privateMeta,
											   const int64_t version,
											   const bool force,
											   const bool forceGenerateNewKey,
											   const OptionalContainerPolicy& policies);
	ResultWithError<std::nullptr_t> deleteKvdb(const std::string& kvdbId);
	ResultWithError<endpoint::kvdb::Kvdb> getKvdb(const std::string& kvdbId);
	ResultWithError<KvdbList> listKvdbs(const std::string& contextId,
										const endpoint::core::PagingQuery pagingQuery);
	
	ResultWithError<endpoint::kvdb::Item> getItem(const std::string& kvdbId,
												  const std::string& key);
	ResultWithError<StringList> listItemKeys(const std::string& kvdbId,
											 const endpoint::kvdb::KeysPagingQuery& pagingQuery);
	ResultWithError<ItemList> listItems(const std::string& kvdbId,
										const endpoint::kvdb::ItemsPagingQuery& pagingQuery);
	ResultWithError<std::nullptr_t> setItem(const std::string& kvdbId,
											const std::string& key,
											const endpoint::core::Buffer& publicMeta,
											const endpoint::core::Buffer& privateMeta,
											const endpoint::core::Buffer& data,
											const int64_t version);
	ResultWithError<std::nullptr_t> deleteItem(const std::string& kvdbId,
											   const std::string& key);
	ResultWithError<std::nullptr_t> deleteItems(const std::string& kvdbId,
												const StringVector& keys);
	
	ResultWithError<std::nullptr_t> subscribeForKvdbEvents();
	ResultWithError<std::nullptr_t> unsubscribeFromKvdbEvents();
	ResultWithError<std::nullptr_t> subscribeForItemEvents(std::string kvdbId);
	ResultWithError<std::nullptr_t> unsubscribeFromItemEvents(std::string kvdbId);
	
private:
	NativeKvdbApiWrapper(NativeConnectionWrapper& connection);
	NativeKvdbApiWrapper() = default;
	
	std::shared_ptr<endpoint::kvdb::KvdbApi> api;
	
	std::shared_ptr<endpoint::kvdb::KvdbApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
};

class KvdbEventHandler{
public:
	ResultWithError<bool> isKvdbCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbCreatedEvent> extractKvdbCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	
	ResultWithError<bool> isKvdbUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbUpdatedEvent> extractKvdbUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

	ResultWithError<bool> isKvdbDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbDeletedEvent> extractKvdbDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	
	ResultWithError<bool> isKvdbStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbStatsChangedEvent> extractKvdbStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);

	ResultWithError<bool> isKvdbNewItemEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbNewItemEvent> extractKvdbNewItemEvent(const endpoint::core::EventHolder& eventHolder);

	ResultWithError<bool> isKvdbItemUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbItemUpdatedEvent> extractKvdbItemUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

	ResultWithError<bool> isKvdbItemDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	ResultWithError<endpoint::kvdb::KvdbItemDeletedEvent> extractKvdbItemDeletedEvent(const endpoint::core::EventHolder& eventHolder);

};
}
