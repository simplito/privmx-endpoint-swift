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
	/**
	 * Constructor
	 *
	 * @param connection: NativeConnectionWrapper& — a reference to an instance of `privmx::NativeConnectionWrapper`
	 */
	static ResultWithError<NativeThreadApiWrapper> create(NativeConnectionWrapper& connection);
	
	/**
	 * Creates a new Thread on the Platform.
	 *
	 * Note that managers do not gain acess to the thread without being added as users.
	 *
	 * @param contextId : `const std::string&` — in which Context should the thread be created
	 * @param users : `const UserWithPubKeyVector&` — who can access the Thread
	 * @param managers : `const UserWithPubKeyVector&` — who can manage the thread
	 * @param title : `const std::string&` — the title of the thread
	 * @param policies additional container access policies
	 * @return Id of the newly created Thread wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<std::string> createThread(const std::string& contextId,
											  const UserWithPubKeyVector& users,
											  const UserWithPubKeyVector& managers,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  const OptionalContainerPolicy& policies = std::nullopt);
	
	/**
	 * Retrieves information about a thread.
	 *
	 * @param threadId : `const std::string&` — which Thread is to be retrieved
	 *
	 * @return `privmx::endpoint::thread::Thread`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::thread::Thread> getThread(const std::string& threadId);
	
	/**
	 * Updates an existing Thread.
	 *
	 * The provided values override preexisting values.
	 *
	 * @param threadId : `const std::string&` — which Thread is to be updated
	 * @param users : `const UserWithPubKeyVector&` — who can access the Thread
	 * @param managers : `const UserWithPubKeyVector&` — who can manage the thread
	 * @param title : `const std::string&` — the title of the thread
	 * @param version : `const int64_t` — current version of the Thread
	 * @param force : `const bool` — force the update by disregarding the cersion check
	 * @param generateNewKeyId : `const bool` — force regeneration of new keyId for Thread
	 * @param accessToOldDataForNewUsers : `const bool` — placeholder parameter (does nothing for now)
	 * @param policies additional container access policies
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> updateThread(const std::string& threadId,
												 const std::vector<endpoint::core::UserWithPubKey>& users,
												 const std::vector<endpoint::core::UserWithPubKey>& managers,
												 const endpoint::core::Buffer& publicMeta,
												 const endpoint::core::Buffer& privateMeta,
												 const int64_t version,
												 const bool force,
												 const bool forceGenerateNewKey,
												 const OptionalContainerPolicy& policies = std::nullopt);
	
	/**
	 * Deletes a Thread.
	 *
	 * @param threadId : `const std::string&` — which Thread is to be deleted
	 *
	 * @return A `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> deleteThread(const std::string& threadId);
	
	/**
	 * Lists Threads the user has access to in provided Context.
	 *
	 * @param contextId : `const std::string&` — from which Context should the Threads be listed
	 * @param query : `privmx::endpoint::core::PagingQuery` — parameters of the query
	 *
	 * @return `privmx::ThreadList`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<ThreadList> listThreads(const std::string& contextId,
										  const endpoint::core::PagingQuery& query);
	
	/**
	 * Sends a message in a thread
	 *
	 * @param threadId : `const std::string&` — Message to be deleted
	 * @param publicMeta : `const privmx::endpoint::core::Buffer&` —Meta_data that will not be encrypted on the Platform
	 * @param privateMeta : `const privmx::endpoint::core::Buffer&` — Meta_data that will be encrypted on the Platform
	 * @param data : `const privmx::endpoint::core::Buffer&` — Actual message
	 *
	 *
	 * @return Id of the created message, wrappend in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::string> sendMessage(const std::string& threadId,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const endpoint::core::Buffer& data);
	/**
	 * Deletes the specified Message.
	 *
	 * @param messageId : `const std::string&` — Message to be deleted
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> deleteMessage(const std::string& messageId);
	
	/**
	 * Retrieves the message with specified Id.
	 *
	 * @param messageId : `const std::string&` — Message to be retrieved
	 * @param messageId : `const std::string&` — Message to be retrieved
	 *
	 * @return `privmx::endpoint::thread::Message`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::thread::Message> getMessage(const std::string& messageId);
	
	/**
	 * Lists Messages from a particular Thread
	 *
	 * @param threadId : `const std::string&` — from which Thread should the Messages be listed
	 * @param query : `privmx::endpoint::core::PagingQuery` — parameters of the query
	 *
	 * @return `privmx::MessageList`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<MessageList> listMessages(const std::string& threadId,
											  const endpoint::core::PagingQuery& query);
	
	/**
	 * Sends message in a Thread.
	 *
	 * @param messageId ID of the message to update
	 * @param publicMeta public message meta_data
	 * @param privateMeta private message meta_data
	 * @param data content of the message
	 */
	ResultWithError<nullptr_t> updateMessage(const std::string& messageId,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const endpoint::core::Buffer& data);

	ResultWithError<nullptr_t> subscribeForThreadEvents();
	ResultWithError<nullptr_t> unsubscribeFromThreadEvents();
	ResultWithError<nullptr_t> subscribeForMessageEvents(const std::string& threadId);
	ResultWithError<nullptr_t> unsubscribeFromMessageEvents(const std::string& threadId);
	
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
/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadCreatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadCreatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadCreatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::thread::ThreadCreatedEvent> extractThreadCreatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadUpdatedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadUpdatedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadUpdatedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::thread::ThreadUpdatedEvent> extractThreadUpdatedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadDeletedEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadDeletedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadDeletedEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadDeletedEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::thread::ThreadDeletedEvent> extractThreadDeletedEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadNewMessageEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadNewMessageEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadNewMessageEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadNewMessageEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::thread::ThreadNewMessageEvent> extractThreadNewMessageEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadDeletedMessageEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadDeletedMessageEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadDeletedMessageEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadDeletedMessageEvent` wrapped in a `ResultWithError` structure for error handling.
 */
static ResultWithError<endpoint::thread::ThreadMessageDeletedEvent> extractThreadDeletedMessageEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Checks if an EventHolder contains an `privmx::endpoint::thread::ThreadStatsEvent`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<bool> isThreadStatsEvent(const endpoint::core::EventHolder& eventHolder);

/**
 * Extracts an `privmx::endpoint::thread::ThreadStatsEvent` from the `privmx::endpoint::core::EventHolder`
 *
 * @param eventHolder  : `const endpoint::core::EventHolder&`
 *
 * @return Extracted `privmx::endpoint::thread::ThreadStatsEvent` wrapped in a `ResultWithError` structure for error handling.
 *
 */
static ResultWithError<endpoint::thread::ThreadStatsChangedEvent> extractThreadStatsEvent(const endpoint::core::EventHolder& eventHolder);

};

}
#endif /* ThreadsApi_hpp */
