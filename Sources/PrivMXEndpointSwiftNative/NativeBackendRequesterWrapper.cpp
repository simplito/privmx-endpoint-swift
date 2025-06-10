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

#include "NativeBackendRequesterWrapper.hpp"

namespace privmx {
using namespace endpoint;

ResultWithError<std::string> NativeBackendRequesterWrapper::backendRequest(
	const std::string &serverUrl,
	const std::string &memberToken,
	const std::string &method,
	const std::string &paramsAsJson
){
	auto res = ResultWithError<std::string>();
	try {
		res.result = core::BackendRequester::backendRequest(serverUrl,
															memberToken,
															method,
															paramsAsJson);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<std::string> NativeBackendRequesterWrapper::backendRequest(
	const std::string &serverUrl,
	const std::string &method,
	const std::string &paramsAsJson
){
	auto res = ResultWithError<std::string>();
	try {
		res.result = core::BackendRequester::backendRequest(serverUrl,
															method,
															paramsAsJson);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<std::string> NativeBackendRequesterWrapper::backendRequest(
	const std::string &serverUrl,
	const std::string& apiKeyId,
	const std::string& apiKeySecret,
	const int64_t mode,
	const std::string& method,
	const std::string& paramsAsJson
){
	auto res = ResultWithError<std::string>();
	try {
		res.result = core::BackendRequester::backendRequest(serverUrl,
															apiKeyId,
															apiKeySecret,
															mode,
															method,
															paramsAsJson);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

}
