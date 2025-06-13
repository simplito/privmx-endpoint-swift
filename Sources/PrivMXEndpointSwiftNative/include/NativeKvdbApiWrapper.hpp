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
	
	ResultWithError<endpoint::kvdb::KvdbEntry> getEntry(const std::string& kvdbId,
												  const std::string& key);
	ResultWithError<StringList> listEntriesKeys(const std::string& kvdbId,
											 const endpoint::kvdb::KvdbKeysPagingQuery& pagingQuery);
	ResultWithError<KvdbEntryList> listEntries(const std::string& kvdbId,
										const endpoint::kvdb::KvdbEntryPagingQuery& pagingQuery);
	ResultWithError<std::nullptr_t> setEntry(const std::string& kvdbId,
											const std::string& key,
											const endpoint::core::Buffer& publicMeta,
											const endpoint::core::Buffer& privateMeta,
											const endpoint::core::Buffer& data,
											const int64_t version);
	ResultWithError<std::nullptr_t> deleteEntry(const std::string& kvdbId,
											   const std::string& key);
	ResultWithError<std::nullptr_t> deleteEntries(const std::string& kvdbId,
												const StringVector& keys);
	
	ResultWithError<std::nullptr_t> subscribeForKvdbEvents();
	ResultWithError<std::nullptr_t> unsubscribeFromKvdbEvents();
	ResultWithError<std::nullptr_t> subscribeForEntryEvents(std::string kvdbId);
	ResultWithError<std::nullptr_t> unsubscribeFromEntryEvents(std::string kvdbId);
	
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
	static ResultWithError<bool> isKvdbCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbCreatedEvent> extractKvdbCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isKvdbUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbUpdatedEvent> extractKvdbUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isKvdbDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbDeletedEvent> extractKvdbDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isKvdbStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbStatsChangedEvent> extractKvdbStatsChangedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isKvdbNewEntryEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbNewEntryEvent> extractKvdbNewEntryEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isKvdbEntryUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbEntryUpdatedEvent> extractKvdbEntryUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isKvdbEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::kvdb::KvdbEntryDeletedEvent> extractKvdbEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);

};
}
