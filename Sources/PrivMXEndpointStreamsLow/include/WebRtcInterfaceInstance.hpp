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


#ifndef _WebRtcInterfaceInstance_
#define _WebRtcInterfaceInstance_

#include "PrivMXUtils.hpp"
#include "Types.hpp"
#include "WebRTCInterface.hpp"

namespace privmx{

using KeyVector = std::vector<privmx::endpoint::stream::Key>;

typedef std::string(*CreateOfferAndSetLocalDescriptionCallback)(const std::string&);
typedef std::string(*CreateAnswerAndSetDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef void(*SetAnswerAndSetRemoteDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef void(*UpdateSessionIdCallback)(const std::string&,const int64_t, const std::string&);
typedef void(*CloseCallback)(const std::string&);
typedef void(*UpdateKeysCallback)(const std::string&,const KeyVector&);

class WebRtcInterfaceInstance: public privmx::endpoint::stream::WebRTCInterface{
public:
	virtual std::string createOfferAndSetLocalDescription(const std::string& streamRoomId) override {
		return _coasldcb(streamRoomId);
	}
	virtual std::string createAnswerAndSetDescriptions(const std::string& streamRoomId,
											   const std::string& sdp,
											   const std::string& type)override{
		return _caasdcb(streamRoomId, sdp, type);
	}
	virtual void setAnswerAndSetRemoteDescription(const std::string& streamRoomId,
										  const std::string& sdp,
										  const std::string& type)override{
		_saasrdcb(streamRoomId, sdp, type);
	}
	 virtual void updateSessionId(const std::string& streamRoomId,
						 const int64_t sessionId,
						 const std::string& connectionType) override{
		_usicb(streamRoomId, sessionId, connectionType);
	}
	virtual void close(const std::string& streamRoomId)override{
		_ccb(streamRoomId);
	}
	 virtual void updateKeys(const std::string& streamRoomId,
					const std::vector<privmx::endpoint::stream::Key>& keys)override{
		_ukcb(streamRoomId, keys);
	}
	 WebRtcInterfaceInstance(CreateOfferAndSetLocalDescriptionCallback coasldcb,
							 CreateAnswerAndSetDescriptionCallback caasdcb,
							 SetAnswerAndSetRemoteDescriptionCallback saasrdcb,
							 UpdateSessionIdCallback usicb,
							 UpdateKeysCallback ukcb,
							 CloseCallback ccb){
		 _caasdcb = caasdcb;
		 _coasldcb = coasldcb;
		 _saasrdcb = saasrdcb;
		 _usicb = usicb;
		 _ukcb = ukcb;
		 _ccb = ccb;
	 }
	
private:
	CreateAnswerAndSetDescriptionCallback _caasdcb;
	CreateOfferAndSetLocalDescriptionCallback _coasldcb;
	SetAnswerAndSetRemoteDescriptionCallback _saasrdcb;
	UpdateSessionIdCallback _usicb;
	UpdateKeysCallback _ukcb;
	CloseCallback _ccb;
	
};

using SharedWebRTCInterfaceInstance = std::shared_ptr<WebRtcInterfaceInstance>;
}
#endif // !_WebRtcInterfaceInstance_

