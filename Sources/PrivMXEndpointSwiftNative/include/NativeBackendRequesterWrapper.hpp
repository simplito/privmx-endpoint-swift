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
	
	static ResultWithError<std::string> backendRequest(
		const std::string& serverUrl,
		const std::string& memberToken,
		const std::string& method,
		const std::string& paramsAsJson
	);
	
	static ResultWithError<std::string> backendRequest(
		const std::string& serverUrl,
		const std::string& method,
		const std::string& paramsAsJson
	);
	
	
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
