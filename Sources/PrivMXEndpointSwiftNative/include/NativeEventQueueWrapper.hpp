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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventQueueWrapper_hpp
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventQueueWrapper_hpp

#include "PrivMXUtils.hpp"

namespace privmx {

/**
 * C++ wrapper of `privmx::endpoint::core::EventQueue`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeEventQueueWrapper{
public:
	
	
	static ResultWithError<NativeEventQueueWrapper> getInstance();
	
	ResultWithError<nullptr_t> emitBreakEvent();
	
	ResultWithError<endpoint::core::EventHolder> waitEvent();
	
	ResultWithError<std::optional<endpoint::core::EventHolder>> getEvent();
private:
	std::shared_ptr<endpoint::core::EventQueue> api;
	NativeEventQueueWrapper();
	std::shared_ptr<endpoint::core::EventQueue> getApi(){
		if (!api){
			throw NullApiException();
		}
		return api;
	}
	
};

}

#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeEventQueueWrapper_hpp */
