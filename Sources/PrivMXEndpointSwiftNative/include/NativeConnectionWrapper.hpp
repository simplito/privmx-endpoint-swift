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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_Connection_hpp
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_Connection_hpp

#include "PrivMXUtils.hpp"
#include <memory>

namespace privmx{

/**
 * C++ wrapper of `privmx::endpoint::core::Connection`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeConnectionWrapper {
	friend class NativeThreadApiWrapper;
	friend class NativeStoreApiWrapper;
	friend class NativeInboxApiWrapper;
	friend class NativeEventApiWrapper;
	friend class NativeKvdbApiWrapper;
public:
	
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> connect(const std::string& userPrivKey,
																			 const std::string& solutionId,
																			 const std::string& bridgeUrl,
																			 const endpoint::core::PKIVerificationOptions& verificationOptions = endpoint::core::PKIVerificationOptions());
	
	[[deprecated]]
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> platformConnect(const std::string& userPrivKey,
																					 const std::string& solutionId,
																					 const std::string& platformUrl);
	
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> connectPublic(const std::string& solutionId,
																				   const std::string& bridgeUrl,
																				   const endpoint::core::PKIVerificationOptions& verificationOptions = endpoint::core::PKIVerificationOptions());
	
	[[deprecated]]
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> platformConnectPublic(const std::string& solutionId,
																						   const std::string& platformUrl);
	
	static ResultWithError<std::nullptr_t> setCertsPath(const std::string& path);
	
	ResultWithError<int64_t> getConnectionId();
	
	ResultWithError<std::nullptr_t> disconnect();
	
	
	ResultWithError<ContextList> listContexts(const endpoint::core::PagingQuery& query);
	
	ResultWithError<UserInfoList> listContextUsers(const std::string& contextId,
													 const endpoint::core::PagingQuery& query);
	
	ResultWithError<std::nullptr_t> setUserVerifier(const UserVerifier& verifier);
	
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);

	
	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionIdVector& subscriptionIds);
	
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::core::EventType eventType,
															  endpoint::core::EventSelectorType selectorType,
															  const std::string& selectorId);
private:
	
	std::shared_ptr<endpoint::core::Connection> getApi();
	
	NativeConnectionWrapper() = default;
	
	NativeConnectionWrapper(std::shared_ptr<endpoint::core::Connection> connection);
	std::shared_ptr<endpoint::core::Connection> api;
};

class CoreEventHandlerWrapper{
public:
	
	static ResultWithError<bool> isLibBreakEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::LibBreakEvent> extractLibBreakEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::LibPlatformDisconnectedEvent> extractLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::LibConnectedEvent> extractLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isLibDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::LibDisconnectedEvent> extractLibDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<bool> isCollectionChangedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::CollectionChangedEvent> extractCollectionChangedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isContextUserAddedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::ContextUserAddedEvent> extractContextUserAddedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isContextUserRemovedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::ContextUserRemovedEvent> extractContextUserRemovedEvent(const endpoint::core::EventHolder& eventHolder);

	static ResultWithError<bool> isContextUsersStatusChangedEvent(const endpoint::core::EventHolder& eventHolder);
	
	static ResultWithError<endpoint::core::ContextUsersStatusChangedEvent> extractContextUsersStatusChangedEvent(const endpoint::core::EventHolder& eventHolder);
};

}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_Connection_hpp */
