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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventApiWrapper_hpp
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventApiWrapper_hpp

#include "PrivMXUtils.hpp"
#include "NativeConnectionWrapper.hpp"

namespace privmx{
class NativeEventApiWrapper {
public:
	static ResultWithError<NativeEventApiWrapper> create(NativeConnectionWrapper& connection);
	
	ResultWithError<std::nullptr_t> emitEvent(const std::string& contextId,
											  const UserWithPubKeyVector& users,
											  const std::string& channelName,
											  const endpoint::core::Buffer& eventData);
	
	/**
	 * Subscribe for the Thread events on the given subscription query.
	 *
	 * @param subscriptionQueries list of queries
	 * @return list of subscriptionIds in maching order to subscriptionQueries
	 */
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);

	/**
	 * Unsubscribe from events for the given subscriptionId.
	 * @param subscriptionIds list of subscriptionId
	 */
	void unsubscribeFrom(const SubscriptionIdVector& subscriptionIds);
	/**
	 * Generate subscription Query for the Thread events.
	 * @param eventType type of event which you listen for
	 * @param selectorType scope on which you listen for events
	 * @param selectorId ID of the selector
	 */
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(const std::string& channelName,
															  endpoint::event::EventSelectorType selectorType,
															  const std::string& selectorId);

	
private:
	std::shared_ptr<endpoint::event::EventApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
	std::shared_ptr<endpoint::event::EventApi> api;
	NativeEventApiWrapper() = default;
	
	NativeEventApiWrapper(NativeConnectionWrapper& connection);
};

class CustomEventHandler{
public:
	static ResultWithError<bool> isContextCustomEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::event::ContextCustomEvent> extractContextCustomEvent(const endpoint::core::EventHolder& eventHolder);
};
}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventApiWrapper_hpp */
