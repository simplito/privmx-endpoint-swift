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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeBackendRequesterWrapper_hpp
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeBackendRequesterWrapper_hpp

#include <stdio.h>
#include "PrivMXUtils.hpp"
namespace privmx{
class NativeBackendRequesterWrapper {
public:
	/**
	 * Sends a request to PrivMX Bridge API using access token for authorization.
	 *
	 * @param serverUrl PrivMX Bridge server URL
	 * @param accessToken token for authorization (see PrivMX Bridge API for more details)
	 * @param method API method to call
	 * @param params API method's parameters in JSON format
	 *
	 * @return JSON string representing raw server response
	 */
	static ResultWithError<std::string> backendRequest(
		const std::string& serverUrl,
		const std::string& memberToken,
		const std::string& method,
		const std::string& paramsAsJson
	);
	/**
	 * Sends request to PrivMX Bridge API.
	 *
	 * @param serverUrl PrivMX Bridge server URL
	 * @param method API method to call
	 * @param params API method's parameters in JSON format
	 *
	 * @return JSON string representing raw server response
	 */
	static ResultWithError<std::string> backendRequest(
		const std::string& serverUrl,
		const std::string& method,
		const std::string& paramsAsJson
	);
	
	/**
	 * Sends a request to PrivMX Bridge API using pair of API KEY ID and API KEY SECRET for authorization.
	 *
	 * @param serverUrl PrivMX Bridge server URL
	 * @param apiKeyId API KEY ID (see PrivMX Bridge API for more details)
	 * @param apiKeySecret API KEY SECRET (see PrivMX Bridge API for more details)
	 * @param mode allows you to set whether the request should be signed (mode = 1) or plain (mode = 0)
	 * @param method API method to call
	 * @param params API method's parameters in JSON format
	 *
	 * @return JSON string representing raw server response
	 */
	static ResultWithError<std::string> backendRequest(
		const std::string& serverUrl,
		const std::string& apiKeyId,
		const std::string& apiKeySecret,
		const int64_t mode,
		const std::string& method,
		const std::string& paramsAsJson
	);                            
};
}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_NativeBackendRequesterWrapper_hpp */
