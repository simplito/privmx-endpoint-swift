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
	/**
	 * Connects to the PrivMX Bridge server.
	 *
	 * @param userPrivKey user's private key
	 * @param solutionId ID of the Solution
	 * @param platformUrl Platform's Endpoint URL
	 *
	 * @return Shared pointer to a Connection object, wrapped in the `ResultWithError` for error handling.
	 *
	 */
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> connect(const std::string& userPrivKey,
																			 const std::string& solutionId,
																			 const std::string& bridgeUrl);
	/**
	 * Connects to the PrivMX Bridge server.
	 *
	 * @param userPrivKey user's private key
	 * @param solutionId ID of the Solution
	 * @param platformUrl Platform's Endpoint URL
	 *
	 * @return Shared pointer to a Connection object, wrapped in the `ResultWithError` for error handling.
	 *
	 */
	[[deprecated]]
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> platformConnect(const std::string& userPrivKey,
																					 const std::string& solutionId,
																					 const std::string& platformUrl);
	
	/**
	 * Connects to the PrivMX Bridge Server as a guest user.
	 *
	 * @param solutionId ID of the Solution
	 * @param platformUrl Platform's Endpoint URL
	 *
	 * @return Shared pointer to a Connection object, wrapped in `ResultWithError` for error handling.
	 *
	 */
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> connectPublic(const std::string& solutionId,
																				   const std::string& bridgeUrl);
	/**
	 * Connects to the PrivMX Bridge Server as a guest user.
	 *
	 * @param solutionId ID of the Solution
	 * @param platformUrl Platform's Endpoint URL
	 *
	 * @return Shared pointer to a Connection object, wrapped in `ResultWithError` for error handling.
	 *
	 */
	[[deprecated]]
	static ResultWithError<std::shared_ptr<NativeConnectionWrapper>> platformConnectPublic(const std::string& solutionId,
																						   const std::string& platformUrl);
	
	/**
	 * Sets the path to.pem  file with certificates.
	 *
	 * @param path  : `const std::string&` — path of the certificate on the local filesystem
	 *
	 * @return `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<std::nullptr_t> setCertsPath(const std::string& path);
	
	/**
	 * Gets the ID of the current connection.
	 *
	 * @return ID of the connection, wrapped in `ResultWithError` object for error handling.
	 */
	ResultWithError<int64_t> getConnectionId();
	
	/**
	 * Disconnects from the PrivMX Bridge server.
	 *
	 * @return `ResultWithError` object for error handling.
	 */
	ResultWithError<std::nullptr_t> disconnect();
	
	/**
	 * Gets a list of Contexts available for the user.
	 *
	 * @param pagingQuery struct with list query parameters
	 *
	 * @return struct containing a list of Contexts wrapped in a `ResultWithError` object for error handling.
	 */
	ResultWithError<ContextList> listContexts(const endpoint::core::PagingQuery& query);
	
	ResultWithError<UserInfoVector> getContextUsers(const std::string& contextId);
private:
	
	std::shared_ptr<endpoint::core::Connection> getApi();
	
	NativeConnectionWrapper() = default;
	
	NativeConnectionWrapper(std::shared_ptr<endpoint::core::Connection> connection);
	std::shared_ptr<endpoint::core::Connection> api;
};

class CoreEventHandlerWrapper{
public:
	/**
	 * Checks whether event held in the 'EventHolder' is an 'LibBreakEvent'
	 *
	 * @return true for 'LibBreakEvent', else otherwise, wrapped in a `ResultWithError` object for error handling.
	 */
	static ResultWithError<bool> isLibBreakEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Extracts an `privmx::endpoint::core::LibBreakEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibBreakEvent` wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibBreakEvent> extractLibBreakEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibPlatformDisconnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<bool> isLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Extracts an `privmx::endpoint::core::LibPlatformDisconnectedEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibPlatformDisconnectedEvent` wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibPlatformDisconnectedEvent> extractLibPlatformDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibConnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<bool> isLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Extracts an `privmx::endpoint::core::LibConnectedEvent` from the `privmx::endpoint::core::EventHolder`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Extracted `privmx::endpoint::core::LibConnectedEvent` wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibConnectedEvent> extractLibConnectedEvent(const endpoint::core::EventHolder& eventHolder);
	
	/**
	 * Checks if an EventHolder contains an `privmx::endpoint::core::LibDisconnectedEvent`
	 *
	 * @param eventHolder  : `const endpoint::core::EventHolder&`
	 *
	 * @return Boolean value wrapped in a `ResultWithError` object for error handling.
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
	 * @return Extracted `privmx::endpoint::core::LibDisconnectedEvent` wrapped in a `ResultWithError` object for error handling.
	 *
	 */
	static ResultWithError<endpoint::core::LibDisconnectedEvent> extractLibDisconnectedEvent(const endpoint::core::EventHolder& eventHolder);
};

}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_Connection_hpp */
