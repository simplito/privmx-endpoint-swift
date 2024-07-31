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

#include "NativeThreadApiWrapper.hpp"

namespace privmx {
using namespace endpoint;

NativeThreadApiWrapper::NativeThreadApiWrapper(NativeCoreApiWrapper& coreApi){
	api = std::make_shared<thread::ThreadApi>(thread::ThreadApi::create(*coreApi.getApi()));
}

NativeThreadApiWrapper NativeThreadApiWrapper::create(NativeCoreApiWrapper &coreApi){
	return NativeThreadApiWrapper(coreApi);
}

ResultWithError<std::string> NativeThreadApiWrapper::threadCreate(const std::string& contextId,
															const UserWithPubKeyVector& users,
															const UserWithPubKeyVector& managers,
															const std::string& title){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->threadCreate(contextId,
										   users,
										   managers,
										   title);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(threadCreate) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(threadCreate) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadCreate) Unknown error, failed to work";
	}
	return res;
}


ResultWithError<endpoint::thread::ThreadInfo> NativeThreadApiWrapper::threadGet(const std::string& threadId){
	ResultWithError<endpoint::thread::ThreadInfo> res;
	try {
		res.result = getapi()->threadGet(threadId);
		res.error =" ";
	}catch(core::Exception& err){
		res.error = std::string("(threadGet) ") + std::string(err.getFull()) ;
	}catch (const std::exception & err) {
		res.error = std::string("(threadGet) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadGet) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadsList> NativeThreadApiWrapper::threadList(const std::string& contextId,
															   const endpoint::core::ListQuery& query){
	ResultWithError<endpoint::thread::ThreadsList> res;
	try {
		
		
		res.result = getapi()->threadList(contextId,query);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(threadList) ") + std::string(err.getFull()) ;
	}catch (std::exception & err) {
		res.error = std::string("(threadList) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadList) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::MessagesList> NativeThreadApiWrapper::messagesGet(const std::string& threadId,
																			 const endpoint::core::ListQuery& query){
	ResultWithError<endpoint::core::MessagesList> res;
	try {
		res.result = getapi()->messagesGet(threadId,query);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(threadMessagesGet) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(threadMessagesGet) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadMessagesGet) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::string> NativeThreadApiWrapper::messageSend(const std::string& threadId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta,
																 const core::Buffer& data){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->messageSend(threadId, publicMeta, privateMeta, data);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(threadMessageSend) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(threadMessageSend) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadMessageSend) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::threadDelete(const std::string &threadId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->threadDelete(threadId);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(threadDelete) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(threadDelete) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(threadDelete) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::messageDelete(const std::string &messageId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->messageDelete(messageId);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(threadMessageDelete) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(threadMessageDelete) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(threadMessageDelete) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::Message> NativeThreadApiWrapper::messageGet(const std::string &messageId){
	ResultWithError<endpoint::core::Message> res;
	try{
		res.result = getapi()->messageGet(messageId);
		res.error = "";
	}catch( core::Exception& err){
		res.error = std::string("(threadMessageGet) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(threadMessagGet) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(threadMessageGet) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeThreadApiWrapper::threadUpdate(const std::string &threadId,
												  const std::vector<core::UserWithPubKey> &users,
												  const std::vector<core::UserWithPubKey> &managers,
												  const std::string &title,
												  const int64_t version,
												  const bool force,
												  const bool generateNewKeyId,
												  const bool accessToOldDataForNewUsers){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->threadUpdate(threadId,
							   users,
							   managers,
							   title,
							   version,
							   force,
							   generateNewKeyId,
							   accessToOldDataForNewUsers);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(threadUpdate) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(threadUpdate) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(threadUpdate) Unknown error, failed to work";
	}
	return res;
	
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadCreatedEvent> NativeThreadApiWrapper::extractThreadCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadCreatedEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadUpdatedEvent> NativeThreadApiWrapper::extractThreadUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadUpdatedEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadDeletedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadDeletedEvent> NativeThreadApiWrapper::extractThreadDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadDeletedEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadDeletedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadNewMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadNewMessageEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadNewMessageEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadNewMessageEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadNewMessageEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadNewMessageEvent> NativeThreadApiWrapper::extractThreadNewMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadNewMessageEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadNewMessageEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadNewMessageEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadNewMessageEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadNewMessageEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadDeletedMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadDeletedMessageEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadDeletedMessageEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadDeletedMessageEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadDeletedMessageEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadDeletedMessageEvent> NativeThreadApiWrapper::extractThreadDeletedMessageEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadDeletedMessageEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadDeletedMessageEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadDeletedMessageEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadDeletedMessageEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadDeletedMessageEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeThreadApiWrapper::isThreadStatsEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = thread::ThreadApi::isThreadStatsEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isThreadStatsEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isThreadStatsEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isThreadStatsEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::thread::ThreadStatsEvent> NativeThreadApiWrapper::extractThreadStatsEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::thread::ThreadStatsEvent> res;
	try{
		res.result = thread::ThreadApi::extractThreadStatsEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractThreadStatsEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractThreadStatsEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractThreadStatsEvent) Unknown error, failed to work";
	}
	return res;
}


}
