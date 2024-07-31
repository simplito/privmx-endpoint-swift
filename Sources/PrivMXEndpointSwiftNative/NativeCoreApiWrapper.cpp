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

#include "NativeCoreApiWrapper.hpp"

namespace privmx {

using namespace endpoint;

std::shared_ptr<endpoint::core::CoreApi> NativeCoreApiWrapper::getApi(){
	if (!api) throw NullApiException();
	return api;
}

NativeCoreApiWrapper::NativeCoreApiWrapper(const std::string& userPrivKey,
										   const std::string& solutionId,
										   const std::string& platformUrl){
	api = std::make_shared<core::CoreApi>(core::CoreApi::platformConnect(userPrivKey, solutionId,platformUrl));
}

ResultWithError<std::shared_ptr<NativeCoreApiWrapper>> NativeCoreApiWrapper::platformConnect(const std::string &userPrivKey,
																				const std::string &solutionId,
																				const std::string &platformUrl){
	ResultWithError<std::shared_ptr<NativeCoreApiWrapper>> res;
	std::shared_ptr<NativeCoreApiWrapper> x;
	try{
		res.result = std::make_shared<NativeCoreApiWrapper>(NativeCoreApiWrapper(userPrivKey,
																				solutionId,
																				platformUrl));
		res.error = "";
	}
	catch(core::Exception& err){
		res.error = std::string("(platformConnect) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(platformConnect) ") + std::string(err.what());
	}catch (...) {
		res.error = "(platformConnect) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeCoreApiWrapper::setCertsPath(const std::string &path){
	ResultWithError res;
	try {
		endpoint::core::Config::setCertsPath(path);
		res.error = "";
	}catch(endpoint::core::Exception& err){
		res.error = std::string("(setCertsPath) ") + std::string(err.getFull()) ;
	}catch (std::exception & err) {
		res.error = std::string("(setCertsPath) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(setCertsPath) Unknown error, failed to work";
	}
	
	return res;
}

ResultWithError<std::nullptr_t> NativeCoreApiWrapper::disconnect(){
	ResultWithError<std::nullptr_t> res;
	try {
		getApi()->disconnect();
		res.error ="";
	}catch(core::Exception& err){
		res.error =std::string("(platformDisconnect) ") + std::string(err.getFull()) ;
	}catch (std::exception & err) {
		res.error = std::string("(platformDisconnect) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(platformDisconnect) Unknown error, failed to work";
	}
	return res;
}


ResultWithError<endpoint::core::ContextsList> NativeCoreApiWrapper::contextList(const core::ListQuery& query){
	ResultWithError<endpoint::core::ContextsList> res;
	try {
		res.result = getApi()->contextList(query);
		res.error = "";
	}catch(core::Exception& err){
		res.error=std::string("(contextList) ") + std::string(std::string(err.getFull()) ) ;
	}catch (std::exception & err) {
		res.error=std::string("(contextList) ")+std::string(err.what()) ;
	}catch (...) {
		res.error = "(contextList) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeCoreApiWrapper::subscribeToChannel(const std::string &channel){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->subscribeToChannel(channel);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(subscribe) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(subscribe) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(subscribe) Unknown error, failed to work";
	}
	return res;
}


ResultWithError<std::nullptr_t> NativeCoreApiWrapper::unsubscribeFromChannel(const std::string &channel){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->unsubscribeFromChannel(channel);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(unsubscribe) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(unsubscribe) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(unsubscribe) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::EventHolder> NativeCoreApiWrapper::waitEvent(){
	ResultWithError<endpoint::core::EventHolder> res;
	try{
		res.result = getApi()->waitEvent();
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(waitEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(waitEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(waitEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::optional<endpoint::core::EventHolder>> NativeCoreApiWrapper::getEvent(){
	ResultWithError<std::optional<endpoint::core::EventHolder>> res;
	try{
		res.result = getApi()->getEvent();
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(getEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(getEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(getEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeCoreApiWrapper::isLibPlatformDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::CoreApi::isLibPlatformDisconnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isLibPlatformDisconnectedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isLibPlatformDisconnectedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isLibPlatformDisconnectedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::LibPlatformDisconnectedEvent> NativeCoreApiWrapper::extractLibPlatformDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::core::LibPlatformDisconnectedEvent> res;
	try{
		res.result = core::CoreApi::extractLibPlatformDisconnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractLibPlatformDisconnectedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractLibPlatformDisconnectedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractLibPlatformDisconnectedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeCoreApiWrapper::isLibConnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::CoreApi::isLibConnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isLibConnectedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isLibConnectedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isLibConnectedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::LibConnectedEvent> NativeCoreApiWrapper::extractLibConnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::core::LibConnectedEvent> res;
	try{
		res.result = core::CoreApi::extractLibConnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractLibConnected) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractLibConnected) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractLibConnected) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeCoreApiWrapper::isLibDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = core::CoreApi::isLibDisconnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isLibDisconnectedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isLibDisconnectedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isLibDisconnectedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::LibDisconnectedEvent> NativeCoreApiWrapper::extractLibDisconnectedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::core::LibDisconnectedEvent> res;
	try{
		res.result = core::CoreApi::extractLibDisconnectedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractLibDisconnectedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractLibDisconnectedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractLibDisconnectedEvent) Unknown error, failed to work";
	}
	return res;
}

}
