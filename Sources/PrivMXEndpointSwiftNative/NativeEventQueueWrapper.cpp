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

#include "NativeEventQueueWrapper.hpp"
namespace privmx{
using namespace endpoint;

NativeEventQueueWrapper::NativeEventQueueWrapper(){
	api = std::make_shared<core::EventQueue>(core::EventQueue::getInstance());
}

ResultWithError<NativeEventQueueWrapper> NativeEventQueueWrapper::getInstance(){
	ResultWithError<NativeEventQueueWrapper> res;
	try{
		res.result = NativeEventQueueWrapper();
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

ResultWithError<core::EventHolder> NativeEventQueueWrapper::waitEvent(){
	ResultWithError<core::EventHolder> res;
	try{
		res.result = getApi()->waitEvent();
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

ResultWithError<std::optional<core::EventHolder>> NativeEventQueueWrapper::getEvent(){
	ResultWithError<std::optional<core::EventHolder>> res;
	try{
		res.result = getApi()->getEvent();
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

ResultWithError<nullptr_t> NativeEventQueueWrapper::emitBreakEvent(){
	ResultWithError<nullptr_t> res;
	try{
		getApi()->emitBreakEvent();
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
