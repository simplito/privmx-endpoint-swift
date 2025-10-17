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

#include "NativeStreamApiLowWrapper.hpp"

namespace privmx {
using namespace endpoint;

ResultWithError<NativeStreamApiLowWrapper> NativeStreamApiLowWrapper::create(const NativeConnectionWrapper &connection, NativeEventApiWrapper &eventApi){
	ResultWithError<NativeStreamApiLowWrapper> res;
	try{
		res.result = NativeStreamApiLowWrapper(connection, eventApi);
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

NativeStreamApiLowWrapper::NativeStreamApiLowWrapper(const NativeConnectionWrapper &connection, NativeEventApiWrapper &eventApi){
	api = std::make_shared<stream::StreamApiLow>(stream::StreamApiLow::create(connection,eventApi));
}

ResultWithError<std::string> NativeStreamApiLowWrapper::createStreamRoom(const std::string& contextId,
											  const UserWithPubKeyVector& users,
											  const UserWithPubKeyVector& managers,
											  const endpoint::core::Buffer& publicMeta,
											  const endpoint::core::Buffer& privateMeta,
											  const OptionalContainerPolicy& policies
																		 ){
	ResultWithError<std::string> res;
	try{
		res.result = getApi()->createStreamRoom(contextId,
												users,
												managers,
												publicMeta,
												privateMeta,
												policies
												);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::updateStreamRoom(const std::string& streamRoomId,
												 const UserWithPubKeyVector& users,
												 const UserWithPubKeyVector& managers,
												 const endpoint::core::Buffer& publicMeta,
												 const endpoint::core::Buffer& privateMeta,
												 const int64_t version,
												 const bool force,
												 const bool forceGenerateNewKey,
												 const OptionalContainerPolicy& policies
																			){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->updateStreamRoom(streamRoomId,
												 users,
												 managers,
												publicMeta,
												privateMeta,
												version,
												force,
												forceGenerateNewKey,
												policies
												);
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
	return res;}

ResultWithError<StreamRoomList> NativeStreamApiLowWrapper::listStreamRooms(const std::string& contextId,
																		   const endpoint::core::PagingQuery& query){
	ResultWithError<StreamRoomList> res;
	try{
		res.result = getApi()->listStreamRooms(contextId,
											   query);
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
	return res;}

ResultWithError<endpoint::stream::StreamRoom> NativeStreamApiLowWrapper::getStreamRoom(const std::string& streamRoomId){
	ResultWithError<stream::StreamRoom> res;
	try{
		res.result = getApi()->getStreamRoom(streamRoomId);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::deleteStreamRoom(const std::string& streamRoomId){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->deleteStreamRoom(streamRoomId);
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
	return res;}
// Stream
ResultWithError<int64_t> NativeStreamApiLowWrapper::createStream(const std::string& streamRoomId, int64_t localStreamId, WebRTCInterfaceReference webRtc){
	ResultWithError<int64_t> res;
	try{
		res.result = getApi()->createStream(streamRoomId,
											localStreamId,
											webRtc);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::publishStream(int64_t localStreamId){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->publishStream(localStreamId);
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
	return res;}

ResultWithError<int64_t> NativeStreamApiLowWrapper::joinStream(const std::string& streamRoomId,
															   const std::vector<int64_t>& streamsId,
															   const endpoint::stream::Settings& settings,
															   int64_t localStreamId,
															   WebRTCInterfaceReference webRtc){
	ResultWithError<int64_t> res;
	try{
		res.result = getApi()->joinStream(streamRoomId,
										  streamsId,
										  settings,
										  localStreamId,
										  webRtc);
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
	return res;}

ResultWithError<StreamVector> NativeStreamApiLowWrapper::listStreams(const std::string& streamRoomId){
	ResultWithError<StreamVector> res;
	try{
		res.result = getApi()->listStreams(streamRoomId);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::unpublishStream(int64_t localStreamId){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->unpublishStream(localStreamId);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::leaveStream(int64_t localStreamId){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->leaveStream(localStreamId);
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
	return res;}

ResultWithError<SubscriptionIdVector> NativeStreamApiLowWrapper::subscribeFor(const SubscriptionQueryVector& subscriptionQueries){
	ResultWithError<SubscriptionIdVector> res;
	try{
		res.result = getApi()->subscribeFor(subscriptionQueries);
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
	return res;}
ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::unsubscribeFrom(const SubscriptionQueryVector& subscriptionIds){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->unsubscribeFrom(const SubscriptionQueryVector& subscriptionIds);
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
	return res;}

ResultWithError<SubscriptionQuery> NativeStreamApiLowWrapper::buildSubscriptionQuery(endpoint::stream::EventType eventType,
																					 endpoint::stream::EventSelectorType selectorType,
																					 const std::string& selectorId){
	ResultWithError<SubscriptionQuery> res;
	try{
		res.result = getApi()->buildSubscriptionQuery(eventType,
													  selectorType,
													  selectorId);
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
	return res;}

ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::keyManagement(bool disable){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->keyManagement(disable);
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
	return res;}
ResultWithError<std::nullopt_t> NativeStreamApiLowWrapper::reconfigureStream(int64_t localStreamId,
																			 const std::string& optionsJSON){
	ResultWithError<std::nullopt_t> res;
	try{
		res.result = getApi()->reconfigureStream(localStreamId,
												 optionsJSON);
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

ResultWithError<bool> EventHandler::isStreamRoomCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamRoomCreatedEvent> EventHandler::extractStreamRoomCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomCreatedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamRoomUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamRoomUpdatedEvent> EventHandler::extractStreamRoomUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomUpdatedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamRoomDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamRoomDeletedEvent> EventHandler::extractStreamRoomDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomDeletedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamPublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamPublishedEvent> EventHandler::extractStreamPublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamPublishedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamJoinedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamJoinedEvent> EventHandler::extractStreamJoinedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamJoinedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamUnpublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamUnpublishedEvent> EventHandler::extractStreamUnpublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamUnpublishedEvent> res;
	return res;
}
ResultWithError<bool> EventHandler::isStreamLeftEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	return res;
}
ResultWithError<stream::StreamLeftEvent> EventHandler::extractStreamLeftEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<stream::StreamLeftEvent> res;
	return res;
}

}
