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
											  const std::string& channelName,
											  const endpoint::core::Buffer& eventData,
											  const UserWithPubKeyVector& users);
	ResultWithError<nullptr_t> subscribeForCustomEvents(const std::string& contextId,
														const std::string& channelName);
	ResultWithError<nullptr_t> unsubscribeFromCustomEvents(const std::string& contextId,
														   const std::string& channelName);
	
	
private:
	std::shared_ptr<endpoint::event::EventApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	
	std::shared_ptr<endpoint::event::EventApi> api;
	NativeEventApiWrapper() = default;
	
	NativeEventApiWrapper(NativeConnectionWrapper& connection);
};
}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventApiWrapper_hpp */
