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

#ifndef ThreadsApi_hpp
#define ThreadsApi_hpp

#include "PrivMXUtils.hpp"
#include "NativeConnectionWrapper.hpp"


namespace privmx {

/**
 * C++ wrapper of `privmx::endpoint::core::Connection`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeThreadApiWrapper{
	friend class NativeInboxApiWrapper;
public:
	
	static ResultWithError<NativeThreadApiWrapper> create(NativeConnectionWrapper& connection);
	
	ResultWithError<std::string> createThread(const std::string& contextId,
											  const UserWithPubKeyVector& users,
											  const UserWithPubKeyVector& managers,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  const OptionalContainerPolicy& policies = std::nullopt);
	
	ResultWithError<endpoint::thread::Thread> getThread(const std::string& threadId);
	
	ResultWithError<std::nullptr_t> updateThread(const std::string& threadId,
												 const std::vector<endpoint::core::UserWithPubKey>& users,
												 const std::vector<endpoint::core::UserWithPubKey>& managers,
												 const endpoint::core::Buffer& publicMeta,
												 const endpoint::core::Buffer& privateMeta,
												 const int64_t version,
												 const bool force,
												 const bool forceGenerateNewKey,
												 const OptionalContainerPolicy& policies = std::nullopt);
	
	ResultWithError<std::nullptr_t> deleteThread(const std::string& threadId);
	
	ResultWithError<ThreadList> listThreads(const std::string& contextId,
										  const endpoint::core::PagingQuery& pagingQuery);
	
	ResultWithError<std::string> sendMessage(const std::string& threadId,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const endpoint::core::Buffer& data);
	ResultWithError<std::nullptr_t> deleteMessage(const std::string& messageId);
	
	ResultWithError<endpoint::thread::Message> getMessage(const std::string& messageId);
	
	ResultWithError<MessageList> listMessages(const std::string& threadId,
											  const endpoint::core::PagingQuery& pagingQuery);
	ResultWithError<nullptr_t> updateMessage(const std::string& messageId,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const endpoint::core::Buffer& data);
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);

	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionIdVector& subscriptionIds);
	
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::thread::EventType eventType,
															  endpoint::thread::EventSelectorType selectorType,
															  const std::string& selectorId);
private:
	std::shared_ptr<endpoint::thread::ThreadApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
	NativeThreadApiWrapper() = default;
	NativeThreadApiWrapper(NativeConnectionWrapper& connection);
	
	std::shared_ptr<endpoint::thread::ThreadApi> api;
	
};

class ThreadEventHandler{
public:
static ResultWithError<bool> isThreadCreatedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadCreatedEvent> extractThreadCreatedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadUpdatedEvent> extractThreadUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadDeletedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadDeletedEvent> extractThreadDeletedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadNewMessageEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadNewMessageEvent> extractThreadNewMessageEvent(const endpoint::core::EventHolder& eventHolder);

[[deprecated("Has been renamed, use isThreadDeletedMessageEvent")]]
static ResultWithError<bool> isThreadDeletedMessageEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadMessageDeletedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadMessageUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

[[deprecated("Has been renamed, use extractThreadMessageDeletedEvent")]]
static ResultWithError<endpoint::thread::ThreadMessageDeletedEvent> extractThreadDeletedMessageEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadMessageDeletedEvent> extractThreadMessageDeletedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadMessageUpdatedEvent> extractThreadMessageUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<bool> isThreadStatsEvent(const endpoint::core::EventHolder& eventHolder);

static ResultWithError<endpoint::thread::ThreadStatsChangedEvent> extractThreadStatsEvent(const endpoint::core::EventHolder& eventHolder);

};

}
#endif /* ThreadsApi_hpp */
