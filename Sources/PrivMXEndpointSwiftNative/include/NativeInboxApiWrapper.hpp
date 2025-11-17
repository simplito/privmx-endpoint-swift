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

#ifndef NativeInboxApiWrapper_hpp
#define NativeInboxApiWrapper_hpp

#include "PrivMXUtils.hpp"
#include "NativeStoreApiWrapper.hpp"
#include "NativeThreadApiWrapper.hpp"

namespace privmx{

class NativeInboxApiWrapper{
public:
	static ResultWithError<NativeInboxApiWrapper> create(NativeConnectionWrapper& connection,
														 NativeThreadApiWrapper& threadApi,
														 NativeStoreApiWrapper& storeApi);
	
	
	ResultWithError<std::string> createInbox(const std::string& contextId,
											 const UserWithPubKeyVector& users,
											 const UserWithPubKeyVector& managers,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const OptionalInboxFilesConfig& filesConfig,
											 const OptionalContainerPolicyWithoutItem& policies);

	
	ResultWithError<nullptr_t> updateInbox(const std::string& inboxId,
										   const UserWithPubKeyVector& users,
										   const UserWithPubKeyVector& managers,
										   const endpoint::core::Buffer& publicMeta,
										   const endpoint::core::Buffer& privateMeta,
										   const OptionalInboxFilesConfig& filesConfig,
										   const int64_t version,
										   const bool force,
										   const bool forceGenerateNewKey,
										   const OptionalContainerPolicyWithoutItem& policies = std::nullopt);
	
	
	ResultWithError<endpoint::inbox::Inbox> getInbox(const std::string& inboxId);
	
	
	ResultWithError<InboxList> listInboxes(const std::string& contextId,
										   const endpoint::core::PagingQuery& pagingQuery);
	
	
	ResultWithError<endpoint::inbox::InboxPublicView> getInboxPublicView(const std::string& inboxId);
	
	
	ResultWithError<nullptr_t> deleteInbox(const std::string& inboxId);

	
	ResultWithError<EntryHandle> prepareEntry(const std::string& inboxId,
											  const endpoint::core::Buffer& data,
											  const InboxFileHandleVector& inboxFileHandles = InboxFileHandleVector(),
											  const OptionalString& userPrivKey = std::nullopt);
	
	
	ResultWithError<nullptr_t> sendEntry(const EntryHandle entryHandle);
	
	
	ResultWithError<endpoint::inbox::InboxEntry> readEntry(const std::string& inboxEntryId);
	
	
	ResultWithError<InboxEntryList> listEntries(const std::string& inboxId,
												const endpoint::core::PagingQuery& pagingQuery);

	
	ResultWithError<nullptr_t> deleteEntry(const std::string& inboxEntryId);

	
	ResultWithError<InboxFileHandle> createFileHandle(const endpoint::core::Buffer& publicMeta,
													  const endpoint::core::Buffer& privateMeta,
													  const int64_t& fileSize);

	
	ResultWithError<nullptr_t> writeToFile(const EntryHandle entryHandle,
										   const InboxFileHandle inboxFileHandle,
										   const endpoint::core::Buffer& dataChunk);


	
	ResultWithError<InboxFileHandle> openFile(const std::string& fileId);

	
	ResultWithError<endpoint::core::Buffer> readFromFile(const InboxFileHandle fileHandle, const int64_t length);

	
	ResultWithError<nullptr_t> seekInFile(const InboxFileHandle fileHandle,
										  const int64_t position);

	
	ResultWithError<std::string> closeFile(const InboxFileHandle fileHandle);
	
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);

	
	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionIdVector& subscriptionIds);
	
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::inbox::EventType eventType,
															  endpoint::inbox::EventSelectorType selectorType,
															  const std::string& selectorId);

	
private:
	std::shared_ptr<endpoint::inbox::InboxApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	NativeInboxApiWrapper() = default;
	NativeInboxApiWrapper(std::shared_ptr<endpoint::inbox::InboxApi> _api);
	
	std::shared_ptr<endpoint::inbox::InboxApi> api;
};

class InboxEventHandler {
public:
	static ResultWithError<bool> isInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxCreatedEvent> extractInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxUpdatedEvent> extractInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxDeletedEvent> extractInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxEntryCreatedEvent> extractInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxEntryDeletedEvent> extractInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);
};

}

#endif /* NativeInboxApiWrapper_hpp */
