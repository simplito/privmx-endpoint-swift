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
#include <future>

namespace privmx{

class ObjcErrorException : std::exception{
	const char * what() const noexcept override{
		
		return "Objc returned an error";
	}
};

class SwiftErrorException: std::exception{
public:
	InternalError internalError;
	
	SwiftErrorException(const InternalError& error){
		internalError = error;
	}
	
	const char * what() const noexcept override {
		return "There were Errors thrown in Swift";
	}
};


using KeyVector = std::vector<privmx::endpoint::stream::Key>;
using StringWithError = ResultWithError<std::string>;
using NullWithError = ResultWithError<std::nullptr_t>;

typedef StringWithError(*CreateOfferAndSetLocalDescriptionCallback)(const std::string&);
typedef StringWithError(*CreateAnswerAndSetDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef NullWithError(*SetAnswerAndSetRemoteDescriptionCallback)(const std::string&,const std::string&, const std::string&);
typedef NullWithError(*UpdateSessionIdCallback)(const std::string&,const int64_t, const std::string&);
typedef NullWithError(*CloseCallback)(const std::string&);
typedef NullWithError(*UpdateKeysCallback)(const std::string&,const KeyVector&);

class WebRtcInterfaceInstance: public privmx::endpoint::stream::WebRTCInterface{
public:
	virtual std::string createOfferAndSetLocalDescription(const std::string& streamRoomId) override {
		std::future<std::string> fstring = std::async(std::launch::async,[&](){
			auto res = _coasldcb(streamRoomId);
			if (res.error){
				throw res.error; //TODO better exception(?)
			} else if (res.result){
				return res.result.value();
			} else {
				throw ObjcErrorException();
			}
		});
		return fstring.get();
	}
	virtual std::string createAnswerAndSetDescriptions(const std::string& streamRoomId,
											   const std::string& sdp,
											   const std::string& type)override{
		
		std::future<std::string> fstring = std::async(std::launch::async,[&](){
			auto res = _caasdcb(streamRoomId, sdp, type);
			if (res.error){
				throw SwiftErrorException(res.error.value()); //TODO better exception(?)
			} else if (res.result){
				return res.result.value();
			} else {
				throw ObjcErrorException();
			}
		});
		
		return fstring.get();
	}
	virtual void setAnswerAndSetRemoteDescription(const std::string& streamRoomId,
										  const std::string& sdp,
										  const std::string& type)override{
		std::future<void> cb = std::async(std::launch::async,[&](){
			
			auto res = _saasrdcb(streamRoomId,sdp,type);
			if (res.error){
				throw SwiftErrorException(res.error.value());
			}
		});
		cb.get();
	}
	 virtual void updateSessionId(const std::string& streamRoomId,
						 const int64_t sessionId,
						 const std::string& connectionType) override{
		 std::future<void> cb = std::async(std::launch::async,[&](){
			 auto res = _usicb(streamRoomId, sessionId, connectionType);
			 if (res.error){
				 throw SwiftErrorException(res.error.value());
			 }
		 });
		 cb.get();
	}
	virtual void close(const std::string& streamRoomId)override{
		std::future<void> cb = std::async(std::launch::async,[&](){
			auto res = _ccb(streamRoomId);
			if (res.error){
				throw SwiftErrorException(res.error.value());
			}
		});
		cb.get();
	}
	 virtual void updateKeys(const std::string& streamRoomId,
					const std::vector<privmx::endpoint::stream::Key>& keys)override{
		 std::future<void> cb = std::async(std::launch::async,[&](){
			 auto res = _ukcb(streamRoomId, keys);
			 if (res.error){
				 throw SwiftErrorException(res.error.value());
			 }
		 });
		 cb.get();
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

