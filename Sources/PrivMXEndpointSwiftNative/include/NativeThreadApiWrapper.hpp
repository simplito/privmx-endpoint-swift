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

#ifndef ThreadsApi_hpp
#define ThreadsApi_hpp

#include "PrivMXUtils.hpp"
#include "NativeCoreApiWrapper.hpp"


namespace privmx {

/**
 * C++ wrapper of `privmx::endpoint::core::CoreApi`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeThreadApiWrapper{
public:
	/**
	 * Constructor
	 *
	 * @param coreApi: NativeCoreApiWrapper& — a reference to an instance of `privmx::NativeCoreApiWrapper`
	 */
	static NativeThreadApiWrapper create(NativeCoreApiWrapper& coreApi);
	
	/**
	 * Creates a new Thread on the Platform.
	 *
	 * Note that managers do not gain acess to the thread without being added as users.
	 *
	 * @param contextId : `const std::string&` — in which Context should the thread be created
	 * @param users : `const UserWithPubKeyVector&` — who can access the Thread
	 * @param managers : `const UserWithPubKeyVector&` — who can manage the thread
	 * @param title : `const std::string&` — the title of the thread
	 *
	 * @return Id of the newly created Thread wrapped in a`ResultWithError` structure for error handling.
	 */
	ResultWithError<std::string> threadCreate(const std::string& contextId,
									   const UserWithPubKeyVector& users,
									   const UserWithPubKeyVector& managers,
									   const std::string& title);
	
	/**
	 * Retrieves information about a thread.
	 *
	 * @param threadId : `const std::string&` — which Thread is to be retrieved
	 *
	 * @return `privmx::endpoint::thread::ThreadInfo`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::thread::ThreadInfo> threadGet(const std::string& threadId);
	
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
	 *
	 *
	 * @return `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> threadUpdate(const std::string& threadId,
												 const std::vector<endpoint::core::UserWithPubKey>& users,
												 const std::vector<endpoint::core::UserWithPubKey>& managers,
												 const std::string& title,
												 const int64_t version,
												 const bool force,
												 const bool generateNewKeyId,
												 const bool accessToOldDataForNewUsers);
	
	/**
	 * Deletes a Thread.
	 *
	 * @param threadId : `const std::string&` — which Thread is to be deleted
	 *
	 * @return A `ResultWithError` structure for error handling.
	 */
	ResultWithError<std::nullptr_t> threadDelete(const std::string& threadId);
	
	/**
	 * Lists Threads the user has access to in provided Context.
	 *
	 * @param contextId : `const std::string&` — from which Context should the Threads be listed
	 * @param query : `privmx::endpoint::core::ListQuery` — parameters of the query
	 *
	 * @return `privmx::endpoint::thread::ThreadsList`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::thread::ThreadsList> threadList(const std::string& contextId,
										  const endpoint::core::ListQuery& query);
	
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
	ResultWithError<std::string> messageSend(const std::string& threadId,
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
	ResultWithError<std::nullptr_t> messageDelete(const std::string& messageId);
	
	/**
	 * Retrieves the message with specified Id.
	 *
	 * @param messageId : `const std::string&` — Message to be retrieved
	 * @param messageId : `const std::string&` — Message to be retrieved
	 *
	 * @return `privmx::endpoint::core::Message`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::core::Message> messageGet(const std::string& messageId);
	
	/**
	 * Lists Messages from a particular Thread
	 *
	 * @param threadId : `const std::string&` — from which Thread should the Messages be listed
	 * @param query : `privmx::endpoint::core::ListQuery` — parameters of the query
	 *
	 * @return `privmx::endpoint::core::MessagesList`instance wrapped in a `ResultWithError` structure for error handling.
	 */
	ResultWithError<endpoint::core::MessagesList> messagesGet(const std::string& threadId,
															  const endpoint::core::ListQuery& query);
	
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
	static ResultWithError<endpoint::thread::ThreadDeletedMessageEvent> extractThreadDeletedMessageEvent(const endpoint::core::EventHolder& eventHolder);
	
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
	static ResultWithError<endpoint::thread::ThreadStatsEvent> extractThreadStatsEvent(const endpoint::core::EventHolder& eventHolder);

	
private:
	std::shared_ptr<endpoint::thread::ThreadApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
	NativeThreadApiWrapper() = default;
	NativeThreadApiWrapper(NativeCoreApiWrapper& coreApi);
	
	std::shared_ptr<endpoint::thread::ThreadApi> api;
	
};

}
#endif /* ThreadsApi_hpp */
