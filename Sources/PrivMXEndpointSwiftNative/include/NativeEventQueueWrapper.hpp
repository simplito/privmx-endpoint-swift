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
	
	/**
	 * Returns an instance of  `EventQueue`. Note that all instances share the same queue.
	 *
	 *@return `privmx::endpoint::core::EventQueue` wrapped in a `ResultWithError` structure for error handling.
	 */
	static ResultWithError<NativeEventQueueWrapper> getInstance();
	
	/**
	 * Emits a special event that allows for ending of a running `waitEvent()`
	 *
	 *@return `ResultWithError` structure for error handling.
	 */
	ResultWithError<nullptr_t> emitBreakEvent();
	
	/**
	 * Waits for an event from Platform Bridge.
	 *
	 * If there are no events available, this method wil wait until a new one arrives.
	 *
	 * @return `privmx::endpoint::core::EventHolder` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::EventHolder> waitEvent();
	
	/**
	 * Returns an event from Platform Bringe, if one is available
	 *
	 * This method returns immediately, regardles if there were any events.
	 *
	 * @return Optional `privmx::endpoint::core::EventHolder` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
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
