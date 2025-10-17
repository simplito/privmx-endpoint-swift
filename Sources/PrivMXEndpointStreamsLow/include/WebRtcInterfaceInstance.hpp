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

#include "WebRTC/PMXFrameCryptorTransformer.h"
#include "PrivMXUtils.hpp"
namespace privmx{

using KeyVector = std::vector<Key>;

typedef std::string(*CreateOfferAndSetLocalDescriptionCallback)(const std::string&);
typedef std::string(*CreateAnswerAndSetDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef void(*SetAnswerAndSetRemoteDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef void(*UpdateSessionIdCallback)(const std::string&,const int64_t, const std::string&);
typedef void(*CloseCallback)(const std::string&);
typedef void(*UpdateKeysCallback)(const std::string&,const KeyVector&);

using ThreadSaveMapIntStreamData = utils::ThreadSaveMap<uint64_t,std::shared_ptr<endpoint::stream::StreamData>;

class WebRtcInterfaceInstance: public privmx::endpoint::WebRtcInterface{
public:
	std::string createOfferAndSetLocalDescription(const std::string& streamRoomId) override {
		return _coasldcb(streamRoomId);
	}
	std::string createAnswerAndSetDescriptions(const std::string& streamRoomId,
											   const std::string& sdp,
											   const std::string& type)override{
		return _caasdcb(streamRoomId, sdp, type);
	}
	void setAnswerAndSetRemoteDescription(const std::string& streamRoomId,
										  const std::string& sdp,
										  const std::string& type)override{
		_saasrdcb(streamRoomId, sdp, type);
	}
	void updateSessionId(const std::string& streamRoomId,
						 const int64_t sessionId,
						 const std::string& connectionType){
		_usicb(streamRoomId, sessionId, connectionType);
	}
	void close(const std::string& streamRoomId)override{
		_ccb(streamRoomId);
	}
	void updateKeys(const std::string& streamRoomId,
					const std::vector<Key>& keys)override{
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

}
#endif // !_WebRtcInterfaceInstance_

