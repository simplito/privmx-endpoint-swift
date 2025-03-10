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

#include "NativeEventApiWrapper.hpp"

namespace privmx {
using namespace endpoint;

NativeEventApiWrapper::NativeEventApiWrapper(NativeConnectionWrapper& connection){
	api = std::make_shared<event::EventApi>(event::EventApi::create(*(connection.getApi())));
}

ResultWithError<NativeEventApiWrapper> NativeEventApiWrapper::create(NativeConnectionWrapper &connection) {
	auto res = ResultWithError<NativeEventApiWrapper>();
	try {
		res.result = NativeEventApiWrapper(connection);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
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

ResultWithError<std::nullptr_t> NativeEventApiWrapper::emitEvent(const std::string &contextId,
																 const std::string &channelName,
																 const endpoint::core::Buffer &eventData,
																 const UserWithPubKeyVector &users) {
	auto res = ResultWithError<>();
	try {
		getapi()->emitEvent(contextId,
							channelName,
							eventData,
							users);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
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

ResultWithError<std::nullptr_t> NativeEventApiWrapper::subscribeForCustomEvents(const std::string &contextId,
																				const std::string &channelName) {
	auto res = ResultWithError<>();
	try{
		getapi()->subscribeForCustomEvents(contextId,
										   channelName);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
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

ResultWithError<std::nullptr_t> NativeEventApiWrapper::unsubscribeFromCustomEvents(const std::string &contextId,
																				   const std::string &channelName){
	auto res = ResultWithError<>();
	try {
		getapi()->unsubscribeFromCustomEvents(contextId,
											  channelName);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
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
