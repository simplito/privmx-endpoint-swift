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

#include "NativeThreadApiWrapper.hpp"

namespace privmx {
using namespace endpoint;

NativeThreadApiWrapper::NativeThreadApiWrapper(NativeConnectionWrapper& connection){
	api = std::make_shared<thread::ThreadApi>(thread::ThreadApi::create(*connection.getApi()));
}

ResultWithError<NativeThreadApiWrapper> NativeThreadApiWrapper::create(NativeConnectionWrapper &connection){
	auto res = ResultWithError<NativeThreadApiWrapper>();
	try{
		res.result = NativeThreadApiWrapper(connection);
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

ResultWithError<std::string> NativeThreadApiWrapper::createThread(const std::string& contextId,
																  const UserWithPubKeyVector& users,
																  const UserWithPubKeyVector& managers,
																  const core::Buffer& publicMeta,
																  const core::Buffer& privateMeta,
																  const OptionalContainerPolicy& policies){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->createThread(contextId,
											users,
											managers,
											publicMeta,
											privateMeta,
											policies);
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


ResultWithError<thread::Thread> NativeThreadApiWrapper::getThread(const std::string& threadId){
	ResultWithError<thread::Thread> res;
	try {
		res.result = getapi()->getThread(threadId);
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

ResultWithError<ThreadList> NativeThreadApiWrapper::listThreads(const std::string& contextId,
															   const core::PagingQuery& query){
	ResultWithError<ThreadList> res;
	try {
		
		
		res.result = getapi()->listThreads(contextId,query);
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

ResultWithError<MessageList> NativeThreadApiWrapper::listMessages(const std::string& threadId,
																  const core::PagingQuery& query){
	ResultWithError<MessageList> res;
	try {
		res.result = getapi()->listMessages(threadId,query);
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

ResultWithError<std::string> NativeThreadApiWrapper::sendMessage(const std::string& threadId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta,
																 const core::Buffer& data){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->sendMessage(threadId, publicMeta, privateMeta, data);
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

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::deleteThread(const std::string &threadId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->deleteThread(threadId);
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

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::deleteMessage(const std::string &messageId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->deleteMessage(messageId);
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

ResultWithError<thread::Message> NativeThreadApiWrapper::getMessage(const std::string &messageId){
	ResultWithError<thread::Message> res;
	try{
		res.result = getapi()->getMessage(messageId);
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

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::updateThread(const std::string &threadId,
																	 const std::vector<core::UserWithPubKey> &users,
																	 const std::vector<core::UserWithPubKey> &managers,
																	 const core::Buffer& publicMeta,
																	 const core::Buffer& privateMeta,
																	 const int64_t version,
																	 const bool force,
																	 const bool generateNewKeyId,
																	 const OptionalContainerPolicy& policies){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->updateThread(threadId,
							   users,
							   managers,
							   publicMeta,
							   privateMeta,
							   version,
							   force,
							   generateNewKeyId,
							   policies);
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

ResultWithError<nullptr_t> NativeThreadApiWrapper::updateMessage(const std::string& messageId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta,
																 const core::Buffer& data){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->updateMessage(messageId,
							   publicMeta,
							   privateMeta,
							   data);
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

ResultWithError<nullptr_t> NativeThreadApiWrapper::subscribeForThreadEvents(){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->subscribeForThreadEvents();
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

ResultWithError<nullptr_t> NativeThreadApiWrapper::unsubscribeFromThreadEvents(){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->unsubscribeFromThreadEvents();
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

ResultWithError<nullptr_t> NativeThreadApiWrapper::subscribeForMessageEvents(const std::string& threadId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->subscribeForMessageEvents(threadId);
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

ResultWithError<nullptr_t> NativeThreadApiWrapper::unsubscribeFromMessageEvents(const std::string& threadId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->unsubscribeFromMessageEvents(threadId);
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

ResultWithError<bool> ThreadEventHandler::isThreadCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadCreatedEvent(eventHolder);
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

ResultWithError<thread::ThreadCreatedEvent> ThreadEventHandler::extractThreadCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadCreatedEvent> res;
	try{
		res.result = thread::Events::extractThreadCreatedEvent(eventHolder);
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

ResultWithError<bool> ThreadEventHandler::isThreadUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadUpdatedEvent(eventHolder);
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

ResultWithError<thread::ThreadUpdatedEvent> ThreadEventHandler::extractThreadUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadUpdatedEvent> res;
	try{
		res.result = thread::Events::extractThreadUpdatedEvent(eventHolder);
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

ResultWithError<bool> ThreadEventHandler::isThreadDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadDeletedEvent(eventHolder);
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

ResultWithError<thread::ThreadDeletedEvent> ThreadEventHandler::extractThreadDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadDeletedEvent> res;
	try{
		res.result = thread::Events::extractThreadDeletedEvent(eventHolder);
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

ResultWithError<bool> ThreadEventHandler::isThreadNewMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadNewMessageEvent(eventHolder);
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

ResultWithError<thread::ThreadNewMessageEvent> ThreadEventHandler::extractThreadNewMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadNewMessageEvent> res;
	try{
		res.result = thread::Events::extractThreadNewMessageEvent(eventHolder);
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

ResultWithError<bool> ThreadEventHandler::isThreadDeletedMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadDeletedMessageEvent(eventHolder);
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

ResultWithError<thread::ThreadMessageDeletedEvent> ThreadEventHandler::extractThreadDeletedMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadMessageDeletedEvent> res;
	try{
		res.result = thread::Events::extractThreadMessageDeletedEvent(eventHolder);
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

ResultWithError<bool> ThreadEventHandler::isThreadStatsEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::Events::isThreadStatsEvent(eventHolder);
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

ResultWithError<thread::ThreadStatsChangedEvent> ThreadEventHandler::extractThreadStatsEvent(const core::EventHolder& eventHolder){
	ResultWithError<thread::ThreadStatsChangedEvent> res;
	try{
		res.result = thread::Events::extractThreadStatsEvent(eventHolder);
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
