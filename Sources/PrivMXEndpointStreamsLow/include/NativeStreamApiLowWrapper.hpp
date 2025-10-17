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

namespace privmx{
namespace endpoint{
namespace stream{
class StreamApiLow;
class TurnCredentials;
class StreamRoom;
class Stream;
class Settings;
class WebRTCInterface;
class EventType;
class EventSelectorType;
}}

using IntWithStringVector = std::vector<std::pair<int64_t, std::string>>;
using TurnCredentialsVector = std::vector<endpoint::stream::TurnCredentials>;
using StreamRoomList = endpoint::core::PagingList<endpoint::stream::StreamRoom>;
using StreamVector = std::vector<endpoint::stream::Stream>;

using LocalStreamId = int64_t;

using StreamIdVector = std::vector<int64_t>;

using WebRTCInterfaceReference = std::shared_ptr<endpoint::stream::WebRTCInterface>;

class NativeStreamApiLowWrapper{
public:
	static ResultWithError<NativeStreamApiLowWrapper> create(const NativeConnectionWrapper& connection,
															 NativeEventApiWrapper& eventApi);
	
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
	ResultWithError<int64_t> createStream(const std::string& streamRoomId, int64_t localStreamId, WebRTCInterfaceReference webRtc);
	
	ResultWithError<std::nullptr_t> publishStream(int64_t localStreamId);
	
	ResultWithError<int64_t> joinStream(const std::string& streamRoomId, const std::vector<int64_t>& streamsId, const endpoint::stream::Settings& settings, int64_t localStreamId, WebRTCInterfaceReference webRtc);
	
	ResultWithError<StreamVector> listStreams(const std::string& streamRoomId);
	
	ResultWithError<std::nullptr_t> unpublishStream(int64_t localStreamId);
	
	ResultWithError<std::nullptr_t> leaveStream(int64_t localStreamId);
	
	ResultWithError<SubscriptionIdVector> subscribeFor(const SubscriptionQueryVector& subscriptionQueries);
	ResultWithError<std::nullptr_t> unsubscribeFrom(const SubscriptionQueryVector& subscriptionIds);
	
	ResultWithError<SubscriptionQuery> buildSubscriptionQuery(endpoint::stream::EventType eventType, endpoint::stream::EventSelectorType selectorType, const std::string& selectorId);
	

	
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
							  NativeEventApiWrapper& eventApi);
	
	std::shared_ptr<endpoint::stream::StreamApiLow> api;
	
};

class StreamApiLowEventHandler{
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
};

static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomCreatedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomUpdatedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamRoomDeletedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamPublishedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamJoinedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamUnpublishedEvent& event){
	return _get_subids_from(event);
}
static privmx::SubscriptionIdVector _get_subIds_from(const privmx::endpoint::stream::StreamLeftEvent& event){
	return _get_subids_from(event);
}

}//privmx

#endif // !_NativePrivMXEndpoitStreamsWrapper_
