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

ResultWithError<NativeStreamApiLowWrapper> NativeStreamApiLowWrapper::create(const NativeConnectionWrapper &connection,
																			 NativeEventApiWrapper &eventApi,
																			 stream::StreamEncryptionMode streamEncryptionMode){
	ResultWithError<NativeStreamApiLowWrapper> res;
	try{
		res.result = NativeStreamApiLowWrapper(connection, eventApi, streamEncryptionMode);
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

NativeStreamApiLowWrapper::NativeStreamApiLowWrapper(const NativeConnectionWrapper &connection,
													 NativeEventApiWrapper &eventApi,
													 stream::StreamEncryptionMode streamEncryptionMode){
	api = std::make_shared<stream::StreamApiLow>(stream::StreamApiLow::create(*(connection.api),
																			  *eventApi.api,
																			  streamEncryptionMode)
												 );
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::updateStreamRoom(const std::string& streamRoomId,
																			const UserWithPubKeyVector& users,
																			const UserWithPubKeyVector& managers,
																			const endpoint::core::Buffer& publicMeta,
																			const endpoint::core::Buffer& privateMeta,
																			const int64_t version,
																			const bool force,
																			const bool forceGenerateNewKey,
																			const OptionalContainerPolicy& policies
																			){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->updateStreamRoom(streamRoomId,
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::deleteStreamRoom(const std::string& streamRoomId){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->deleteStreamRoom(streamRoomId);
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
ResultWithError<StreamInfoVector> NativeStreamApiLowWrapper::listStreams(const std::string& streamRoomId){
	ResultWithError<StreamInfoVector> res;
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::joinStreamRoom(const std::string &streamRoomId,
																		  WebRTCInterfaceReference webRtc){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->joinStreamRoom(streamRoomId, webRtc);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::enableStreamRoomRecording(const std::string &streamRoomId){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->enableStreamRoomRecording(streamRoomId);
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

ResultWithError<RecordingEncKeyVector> NativeStreamApiLowWrapper::getStreamRoomRecordingKeys(const std::string &streamRoomId){
	ResultWithError<RecordingEncKeyVector> res;
	try{
		res.result = getApi()->getStreamRoomRecordingKeys(streamRoomId);
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
ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::leaveStreamRoom(const std::string &streamRoomId){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->leaveStreamRoom(streamRoomId);
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


ResultWithError<stream::StreamHandle> NativeStreamApiLowWrapper::createStream(const std::string& streamRoomId){
	ResultWithError<stream::StreamHandle> res;
	try{
		res.result = getApi()->createStream(streamRoomId);
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

ResultWithError<stream::StreamPublishResult> NativeStreamApiLowWrapper::publishStream(const stream::StreamHandle& streamHandle){
	ResultWithError<stream::StreamPublishResult> res;
	try{
		res.result = getApi()->publishStream(streamHandle);
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

ResultWithError<stream::StreamPublishResult> NativeStreamApiLowWrapper::updateStream(const stream::StreamHandle& streamHandle){
	ResultWithError<stream::StreamPublishResult> res;
	try{
		res.result = getApi()->updateStream(streamHandle);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::unpublishStream(const stream::StreamHandle& streamHandle){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->unpublishStream(streamHandle);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::subscribeToRemoteStreams(const std::string& streamRoomId,
																					const StreamSubscriptiopnsVector& subscriptions){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->subscribeToRemoteStreams(streamRoomId,
										   subscriptions);
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
	}catch (privmx::ObjcErrorException & err) {
		res.error ={
			.name = "OBJC err",
			.message = err.what()
		};
	}catch (privmx::SwiftErrorException & err) {
		res.error = err.internalError;
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;}
ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::modifyRemoteStreamsSubscriptions(const std::string& streamRoomId,
																							const StreamSubscriptiopnsVector& subscriptionsToAdd,
																							const StreamSubscriptiopnsVector& subscriptionsToRemove){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->modifyRemoteStreamsSubscriptions(streamRoomId,
												   subscriptionsToAdd,
												   subscriptionsToRemove);
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
ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::unsubscribeFromRemoteStreams(const std::string& streamRoomId,
																						const StreamSubscriptiopnsVector& subscriptionsToRemove){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->unsubscribeFromRemoteStreams(streamRoomId,
											   subscriptionsToRemove);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::trickle(const int64_t sesionId,
																   const std::string &candidateAsJson){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->trickle(sesionId,
						  candidateAsJson);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::acceptOfferOnReconfigure(const int64_t sessionId,
																					const endpoint::stream::SdpWithTypeModel &sdp){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->acceptOfferOnReconfigure(sessionId, sdp);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::setNewOfferOnReconfigure(const int64_t sessionId,
																					const endpoint::stream::SdpWithTypeModel &sdp){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->setNewOfferOnReconfigure(sessionId, sdp);
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
ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::unsubscribeFrom(const SubscriptionQueryVector& subscriptionIds){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->unsubscribeFrom(subscriptionIds);
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

ResultWithError<std::nullptr_t> NativeStreamApiLowWrapper::keyManagement(const std::string& streamRoomId, bool disable){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->keyManagement(streamRoomId,disable);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamRoomCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamRoomCreatedEvent(eventHolder);
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
ResultWithError<stream::StreamRoomCreatedEvent> StreamApiLowEventHandler::extractStreamRoomCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomCreatedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamRoomCreatedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamRoomUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamRoomUpdatedEvent(eventHolder);
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
ResultWithError<stream::StreamRoomUpdatedEvent> StreamApiLowEventHandler::extractStreamRoomUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomUpdatedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamRoomUpdatedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamRoomDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamRoomDeletedEvent(eventHolder);
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
ResultWithError<stream::StreamRoomDeletedEvent> StreamApiLowEventHandler::extractStreamRoomDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamRoomDeletedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamRoomDeletedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamPublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamPublishedEvent(eventHolder);
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
ResultWithError<stream::StreamPublishedEvent> StreamApiLowEventHandler::extractStreamPublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamPublishedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamPublishedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamJoinedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamJoinedEvent(eventHolder);
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
ResultWithError<stream::StreamJoinedEvent> StreamApiLowEventHandler::extractStreamJoinedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamJoinedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamJoinedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamUnpublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamUnpublishedEvent(eventHolder);
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
ResultWithError<stream::StreamUnpublishedEvent> StreamApiLowEventHandler::extractStreamUnpublishedEvent(const core::EventHolder& eventHolder){
	ResultWithError<stream::StreamUnpublishedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamUnpublishedEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamLeftEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamLeftEvent(eventHolder);
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
ResultWithError<stream::StreamLeftEvent> StreamApiLowEventHandler::extractStreamLeftEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<stream::StreamLeftEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamLeftEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamNewStreamsEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamNewStreamsEvent(eventHolder);
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
ResultWithError<stream::StreamNewStreamsEvent> StreamApiLowEventHandler::extractStreamNewStreamsEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<stream::StreamNewStreamsEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamNewStreamsEvent(eventHolder);
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

ResultWithError<bool> StreamApiLowEventHandler::isStreamsUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamsUpdatedEvent(eventHolder);
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
ResultWithError<stream::StreamsUpdatedEvent> StreamApiLowEventHandler::extractStreamsUpdatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<stream::StreamsUpdatedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamsUpdatedEvent(eventHolder);
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


ResultWithError<bool> StreamApiLowEventHandler::isStreamUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = privmx::endpoint::stream::Events::isStreamUpdatedEvent(eventHolder);
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
ResultWithError<stream::StreamUpdatedEvent> StreamApiLowEventHandler::extractStreamUpdatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<stream::StreamUpdatedEvent> res;
	try{
		res.result = privmx::endpoint::stream::Events::extractStreamUpdatedEvent(eventHolder);
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
