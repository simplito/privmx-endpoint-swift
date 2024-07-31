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

#ifndef CoreApi_hpp
#define CoreApi_hpp

#include "PrivMXUtils.hpp"
#include <memory>

namespace privmx{

/**
 * C++ wrapper of `privmx::endpoint::core::CoreApi`.
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeCoreApiWrapper {
	friend class NativeThreadApiWrapper;
	friend class NativeStoreApiWrapper;
public:
	/**
	 * Creates a new instance of NativeCoreApiWrapper by calling static endpoint::core::CoreApi::platformConnect.
	 *
	 * @param userPrivKey : `const std::string&` — Private Key of the user, in WIF format.
	 * @param solutionId : `const std::string&` — ID of the Solution
	 * @param platformUrl : `const std::string&` — URL of the Platform's endpoint
	 *
	 * @return Shared pointer to a new instance of `NativeCoreApiWrapper`, wrapped in the `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<std::shared_ptr<NativeCoreApiWrapper>> platformConnect(const std::string& userPrivKey,
																	 const std::string& solutionId,
																	 const std::string& platformUrl);	
	
	/**
	 * Sets the path to.pem  file with certificates.
	 *
	 * @param path  : `const std::string&` — path of the certificate on the local filesystem
	 *
	 * @return `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<std::nullptr_t> setCertsPath(const std::string& path);
		
	/**
	 * Severs the connection to platform.
	 *
	 * This makes the object on which it is called, as well as all other objects depending on it, useless.
	 *
	 * @return `ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::nullptr_t> disconnect();
	
	/**
	 * Lists Contexts to which the logged-in user has access.
	 *
	 * @param query  : `const endpoint::core::ListQuery&` — parameters of the query
	 *
	 * @return `privmx::endpoint::core::ContextsList` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::ContextsList> contextList(const endpoint::core::ListQuery& query);
	
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
	
	/**
	 * Notifies the library to start receiving Events from specified Channel.
	 *
	 * Valid channels consist of:
	 *
	 *  - "thread2",
	 *
	 *  - "store",
	 *
	 *  - "thread2/<threadId>/messages",
	 *
	 *  - "store/<storeId>/files"
	 *
	 * @param channel  : `const std::string&` the channel from which should the events arrive.
	 *
	 * @return `ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::nullptr_t> subscribeToChannel(const std::string& channel);
	
	/**
	 * Notifies the library to stop receiving Events from specified Channel.
	 *
	 * Valid channels consist of:
	 *
	 *  - "thread2",
	 *
	 *  - "store",
	 *
	 *  - "thread2/<threadId>/messages",
	 *
	 *  - "store/<storeId>/files"
	 *
	 * @param channel  : `const std::string&` — Which events should stop arriving
	 *
	 * @return `ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::nullptr_t> unsubscribeFromChannel(const std::string& channel);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibPlatformDisconnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<bool> isLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Extracts an `privmx::endpoint::core::LibPlatformDisconnectedEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibPlatformDisconnectedEvent` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibPlatformDisconnectedEvent> extractLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibConnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<bool> isLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);

	/**
	 * Extracts an `privmx::endpoint::core::LibConnectedEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibConnectedEvent` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibConnectedEvent> extractLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibDisconnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` structure for error handling.
	 *
	 * \sa
	 * [link to cpp doc]
	 */
	static ResultWithError<bool> isLibDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Extracts an `privmx::endpoint::core::LibDisconnectedEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibDisconnectedEvent` wrapped in a `ResultWithError` structure for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibDisconnectedEvent> extractLibDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	
private:
	
	std::shared_ptr<endpoint::core::CoreApi> getApi();
	
	NativeCoreApiWrapper() = default;
	
	NativeCoreApiWrapper(const std::string& userPrivKey,
							const std::string& solutionId,
							const std::string& platformUrl);
	
	std::shared_ptr<endpoint::core::CoreApi> api;
};
}
#endif /* CoreApi_hpp */
