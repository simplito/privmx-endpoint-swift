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

#ifndef _NativePrivMXEndpoitStreamsWrapper_
#define _NativePrivMXEndpoitStreamsWrapper_

#include "PrivMXUtils.hpp"
#include "NativeConnectionWrapper.hpp"
#include "NativeEventApiWrapper.hpp"
#include "privmx/endpoint/stream/StreamApiLow.hpp"
#include "privmx/endpoint/stream/Types.hpp"
#include "privmx/endpoint/stream/Constants.hpp"
#include "privmx/endpoint/stream/Events.hpp"
#include "privmx/endpoint/stream/StreamException.hpp"
#include "WebRtcInterfaceInstance.hpp"

namespace privmx {

using StreamInfoVector = std::vector<endpoint::stream::StreamInfo>;
using StreamSubscriptiopnsVector = std::vector<endpoint::stream::StreamSubscription>;

using StreamRoomList = endpoint::core::PagingList<endpoint::stream::StreamRoom>;
using TurnCredentialsVector = std::vector<endpoint::stream::TurnCredentials>;


using LocalStreamId = int64_t;

using StreamIdVector = std::vector<int64_t>;

using WebRTCInterfaceReference = std::shared_ptr<endpoint::stream::WebRTCInterface>;

class NativeStreamApiLowWrapper{
public:
	static ResultWithError<NativeStreamApiLowWrapper> create(const NativeConnectionWrapper& connection,
															 NativeEventApiWrapper& eventApi,
															 endpoint::stream::StreamEncryptionMode streamEncryptionMode = endpoint::stream::StreamEncryptionMode::SINGLE_KEY);
	
	ResultWithError<TurnCredentialsVector> getTurnCredentials();

	
	ResultWithError<std::string> createStreamRoom(const std::string& contextId,
												  const UserWithPubKeyVector& users,
												  const UserWithPubKeyVector& managers,
												  const endpoint::core::Buffer& publicMeta,
												  const endpoint::core::Buffer& privateMeta,
												  const OptionalContainerPolicy& policies
												  );
	
	ResultWithError<std::nullptr_t> updateStreamRoom(const std::string& streamRoomId,
													 const UserWithPubKeyVector& users,
													 const UserWithPubKeyVector& managers,
													 const endpoint::core::Buffer& publicMeta,
													 const endpoint::core::Buffer& privateMeta,
													 const int64_t version,
													 const bool force,
													 const bool forceGenerateNewKey,
													 const OptionalContainerPolicy& policies
													 );
	
	ResultWithError<StreamRoomList> listStreamRooms(const std::string& contextId, const endpoint::core::PagingQuery& query);
	
	ResultWithError<endpoint::stream::StreamRoom> getStreamRoom(const std::string& streamRoomId);
	
	ResultWithError<std::nullptr_t> deleteStreamRoom(const std::string& streamRoomId);
	
	// Stream
	ResultWithError<StreamInfoVector> listStreams(const std::string& streamRoomId);
	ResultWithError<std::nullptr_t> joinStreamRoom(const std::string& streamRoomId, WebRTCInterfaceReference webRtc); // required before createStream and openStream
	ResultWithError<std::nullptr_t> enableStreamRoomRecording(const std::string& streamRoomId);
	ResultWithError<std::nullptr_t> leaveStreamRoom(const std::string& streamRoomId);
	
	ResultWithError<endpoint::stream::StreamHandle> createStream(const std::string& streamRoomId);
	ResultWithError<endpoint::stream::StreamPublishResult> publishStream(const endpoint::stream::StreamHandle& streamHandle);
	ResultWithError<endpoint::stream::StreamPublishResult> updateStream(const endpoint::stream::StreamHandle& streamHandle);
	ResultWithError<std::nullptr_t> unpublishStream(const endpoint::stream::StreamHandle& streamHandle);
	
	ResultWithError<nullptr_t> subscribeToRemoteStreams(const std::string& streamRoomId,
													  const StreamSubscriptiopnsVector& subscriptions);
	ResultWithError<nullptr_t> modifyRemoteStreamsSubscriptions(const std::string& streamRoomId,
																const StreamSubscriptiopnsVector& subscriptionsToAdd,
																const StreamSubscriptiopnsVector& subscriptionsToRemove);
	ResultWithError<nullptr_t> unsubscribeFromRemoteStreams(const std::string& streamRoomId,
														  const StreamSubscriptiopnsVector& subscriptionsToRemove);
	
	ResultWithError<std::nullptr_t> trickle(const int64_t sesionId,
											const std::string& candidateAsJson);
	ResultWithError<std::nullptr_t> acceptOfferOnReconfigure(const int64_t sessionId,
															 const endpoint::stream::SdpWithTypeModel& sdp);
	ResultWithError<std::nullptr_t> setNewOfferOnReconfigure(const int64_t sessionId,
															 const endpoint::stream::SdpWithTypeModel& sdp);
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);
	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionQueryVector& subscriptionIds);
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::stream::EventType eventType, endpoint::stream::EventSelectorType selectorType, const std::string& selectorId);
	
	ResultWithError<std::nullptr_t> keyManagement(const std::string& streamRoomId,
												  bool disable);

	
private:
	std::shared_ptr<endpoint::stream::StreamApiLow> getApi(){
		if(api){
			return api;
		} else {
			throw privmx::NullApiException();
		}
	}
	NativeStreamApiLowWrapper() = default;
	
	NativeStreamApiLowWrapper(const NativeConnectionWrapper& connection,
							  NativeEventApiWrapper& eventApi,
							  endpoint::stream::StreamEncryptionMode streamEncryptionMode = endpoint::stream::StreamEncryptionMode::SINGLE_KEY);
	
	std::shared_ptr<endpoint::stream::StreamApiLow> api;
	
};

class StreamApiLowEventHandler{
public:
	static ResultWithError<bool> isStreamRoomCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamRoomCreatedEvent> extractStreamRoomCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamRoomUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamRoomUpdatedEvent> extractStreamRoomUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamRoomDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamRoomDeletedEvent> extractStreamRoomDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamPublishedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamPublishedEvent> extractStreamPublishedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamJoinedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamJoinedEvent> extractStreamJoinedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamUnpublishedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamUnpublishedEvent> extractStreamUnpublishedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamLeftEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamLeftEvent> extractStreamLeftEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isRemoteStreamsChangedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::RemoteStreamsChangedEvent> extractRemoteStreamsChangedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamsUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamsUpdatedEvent> extractStreamsUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isStreamUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::stream::StreamUpdatedEvent> extractStreamUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	
};
namespace endpoint::wrapper{
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomCreatedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomUpdatedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomDeletedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamPublishedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamJoinedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamUnpublishedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamLeftEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::RemoteStreamsChangedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamsUpdatedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamUpdatedEvent& event){
	return endpoint::wrapper::_get_subIds_from_event(event);
	
}
}

class WRTCIIHolder{
public:
	WebRTCInterfaceReference instance;
	
	WRTCIIHolder(CreateOfferAndSetLocalDescriptionCallback coasldcb,
								CreateAnswerAndSetDescriptionCallback caasdcb,
								SetAnswerAndSetRemoteDescriptionCallback saasrdcb,
								UpdateSessionIdCallback usicb,
								UpdateKeysCallback ukcb,
								CloseCallback ccb,
								void* context
								){
		instance = std::make_shared<WebRtcInterfaceInstance>(
				WebRtcInterfaceInstance(
										coasldcb,context,
										caasdcb,context,
										saasrdcb,context,
										usicb,context,
										ukcb, context,
										ccb, context));
		}
private:
	void* context;
};

}//privmx

#endif // !_NativePrivMXEndpoitStreamsWrapper_
