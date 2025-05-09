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

#include "NativeConnectionWrapper.hpp"

namespace privmx {

using namespace endpoint;

std::shared_ptr<core::Connection> NativeConnectionWrapper::getApi(){
	if (!api) throw NullApiException();
	return api;
	core::BackendRequester();
}

NativeConnectionWrapper::NativeConnectionWrapper(std::shared_ptr<core::Connection> connection){
	api = connection;
}

ResultWithError<std::shared_ptr<NativeConnectionWrapper>> NativeConnectionWrapper::platformConnect(const std::string &userPrivKey,
																								   const std::string &solutionId,
																								   const std::string &platformUrl){
	return connect(userPrivKey, solutionId, platformUrl);
}

ResultWithError<std::shared_ptr<NativeConnectionWrapper>> NativeConnectionWrapper::connect(const std::string &userPrivKey,
																						   const std::string &solutionId,
																						   const std::string &platformUrl,
																						   const core::PKIVerificationOptions& verificationOptions){
	ResultWithError<std::shared_ptr<NativeConnectionWrapper>> res;
	std::shared_ptr<NativeConnectionWrapper> x;
	try{
		auto conn = NativeConnectionWrapper(std::make_shared<core::Connection>(core::Connection::connect(userPrivKey,
																										 solutionId,
																										 platformUrl,
																										 verificationOptions)));
		res.result = std::make_shared<NativeConnectionWrapper>(conn);
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

ResultWithError<std::shared_ptr<NativeConnectionWrapper>> NativeConnectionWrapper::platformConnectPublic(const std::string &solutionId,
																										 const std::string &platformUrl){
	return connectPublic(solutionId, platformUrl);
}
ResultWithError<std::shared_ptr<NativeConnectionWrapper>> NativeConnectionWrapper::connectPublic(const std::string &solutionId,
																								 const std::string &platformUrl,
																								 const endpoint::core::PKIVerificationOptions& verificationOptions){
	ResultWithError<std::shared_ptr<NativeConnectionWrapper>> res;
	std::shared_ptr<NativeConnectionWrapper> x;
	try{
		auto conn = NativeConnectionWrapper(std::make_shared<core::Connection>(core::Connection::connectPublic(solutionId,
																											   platformUrl,
																											   verificationOptions)));
		res.result = std::make_shared<NativeConnectionWrapper>(conn);
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

ResultWithError<std::nullptr_t> NativeConnectionWrapper::setCertsPath(const std::string &path){
	ResultWithError res;
	try {
		core::Config::setCertsPath(path);
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

ResultWithError<std::nullptr_t> NativeConnectionWrapper::disconnect(){
	ResultWithError<std::nullptr_t> res;
	try {
		getApi()->disconnect();
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


ResultWithError<ContextList> NativeConnectionWrapper::listContexts(const core::PagingQuery& query){
	ResultWithError<ContextList> res;
	try {
		res.result = getApi()->listContexts(query);
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

ResultWithError<UserInfoVector> NativeConnectionWrapper::getContextUsers(const std::string &contextId){
	ResultWithError<UserInfoVector> res;
	try{
		res.result = getApi()->getContextUsers(contextId);
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

ResultWithError<int64_t> NativeConnectionWrapper::getConnectionId(){
	ResultWithError<int64_t> res;
	try {
		res.result = getApi()->getConnectionId();
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

ResultWithError<std::nullptr_t> NativeConnectionWrapper::setUserVerifier(UserVerifier verifier) {
	ResultWithError res;
	try{
		auto shuv = std::make_shared<UserVerifier>(verifier);
		getApi()->setUserVerifier(shuv);
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
}

ResultWithError<bool> CoreEventHandlerWrapper::isLibPlatformDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::Events::isLibPlatformDisconnectedEvent(eventHolder);
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

ResultWithError<core::LibPlatformDisconnectedEvent> CoreEventHandlerWrapper::extractLibPlatformDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<core::LibPlatformDisconnectedEvent> res;
	try{
		res.result = core::Events::extractLibPlatformDisconnectedEvent(eventHolder);
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

ResultWithError<bool> CoreEventHandlerWrapper::isLibBreakEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::Events::isLibBreakEvent(eventHolder);
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

ResultWithError<core::LibBreakEvent> CoreEventHandlerWrapper::extractLibBreakEvent(const core::EventHolder& eventHolder){
	ResultWithError<core::LibBreakEvent> res;
	try{
		res.result = core::Events::extractLibBreakEvent(eventHolder);
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

ResultWithError<bool> CoreEventHandlerWrapper::isLibConnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::Events::isLibConnectedEvent(eventHolder);
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

ResultWithError<core::LibConnectedEvent> CoreEventHandlerWrapper::extractLibConnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<core::LibConnectedEvent> res;
	try{
		res.result = core::Events::extractLibConnectedEvent(eventHolder);
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

ResultWithError<bool> CoreEventHandlerWrapper::isLibDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::Events::isLibDisconnectedEvent(eventHolder);
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

ResultWithError<core::LibDisconnectedEvent> CoreEventHandlerWrapper::extractLibDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<core::LibDisconnectedEvent> res;
	try{
		res.result = core::Events::extractLibDisconnectedEvent(eventHolder);
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
