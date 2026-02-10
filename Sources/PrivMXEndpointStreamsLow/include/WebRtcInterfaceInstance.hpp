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
# include "privmx/endpoint/stream/Types.hpp"
#include "privmx/endpoint/stream/WebRTCInterface.hpp"
#include <future>
#include <functional>
#include <iostream>

namespace privmx{

class ObjcErrorException : std::exception{
public:
	const char * what() const noexcept override{
		return "Objc returned an error";
	}
};

class CallbackNotSet : std::exception{
	const char * what() const noexcept override{
		
		return "The callback was not set.";
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
//using StringWithError = ResultWithError<std::string>;
//using NullWithError = ResultWithError<int>;

struct UKCBParam{
	std::string roomId;
	KeyVector keys;
	const void* context;
};

struct CCBParam{
	std::string roomId;
	const void* context;
};

struct COASLDCBParam{
	std::string roomId;
	const void* context;
};

struct CAASDCBParam{
	std::string roomId;
	std::string sdp;
	std::string type;
	const void* context;
};

struct SAASRDCBParam{
	std::string roomId;
	std::string sdp;
	std::string type;
	const void* context;
};

struct USICBParam{
	std::string roomId;
	int64_t sessionId;
	std::string connectionType;
	const void* context;
};

struct StringWithError{
	std::string result;
	bool isvalid;
	std::string errname;
	std::string errwhat;
};

typedef StringWithError(*CreateOfferAndSetLocalDescriptionCallback)(COASLDCBParam*);
typedef StringWithError(*CreateAnswerAndSetDescriptionCallback)(CAASDCBParam*);
typedef InternalError(*SetAnswerAndSetRemoteDescriptionCallback)(SAASRDCBParam*);
typedef InternalError(*UpdateSessionIdCallback)(USICBParam*);
typedef InternalError(*CloseCallback)(CCBParam*);
typedef std::string(*UpdateKeysCallback)(UKCBParam*);//const UKCBParam&);


class WebRtcInterfaceInstance: public privmx::endpoint::stream::WebRTCInterface{
public:
	virtual std::string createOfferAndSetLocalDescription(const std::string& streamRoomId) override {
		if (_coasldcb){
			COASLDCBParam ctx {
				.roomId = streamRoomId,
				.context = _coasldcbContext
			};
			std::future<std::string> fstring = std::async(std::launch::async,[&](){
				auto res = _coasldcb(&ctx);
				if (res.errname != ""){
					throw SwiftErrorException(InternalError{.name = res.errname, .description = res.errwhat});
				} else if (res.isvalid){
					return res.result;
				} else {
					throw ObjcErrorException();
				}
			});
			auto res = fstring.get();
			//std::cout<<"cOaSLD done"<<std::endl;
			return res;
		} else {
			//std::cout<<"cOaSLD failed"<<std::endl;
			throw CallbackNotSet();
		}
	}
	virtual std::string createAnswerAndSetDescriptions(const std::string& streamRoomId,
											   const std::string& sdp,
											   const std::string& type)override{
		if(_caasdcb){
			CAASDCBParam ctx {
				.roomId = streamRoomId,
				.sdp = sdp,
				.type = type,
				.context = _caasdcbContext
			};
			std::future<std::string> fstring = std::async(std::launch::async,[&](){
				auto res = _caasdcb(&ctx);
				if (res.errname != ""){
					std::cout<<"got error:"<<res.errname<<std::endl;
					throw SwiftErrorException(InternalError{.name = res.errname, .description = res.errwhat});
				} else if (res.isvalid){
					return res.result;
				} else {
					throw ObjcErrorException();
				}
			});
			auto res = fstring.get();
			//std::cout<<"cAaSD done"<<std::endl;
			return res;
		} else {
			//std::cout<<"cAaSD failed"<<std::endl;
			throw CallbackNotSet();
		}
	}
	virtual void setAnswerAndSetRemoteDescription(const std::string& streamRoomId,
										  const std::string& sdp,
												  const std::string& type)override{
		std::cout<<"setting Answer and Setting Remote Description.."<<std::endl;
		if (_saasrdcb){
			SAASRDCBParam ctx {
				.roomId = streamRoomId,
				.sdp = sdp,
				.type = type,
				.context = _saasrdcbContext
			};
			std::future<void> cb = std::async(std::launch::async,[&](){
				
				auto res = _saasrdcb(&ctx);
				if (res.name != ""){
					throw SwiftErrorException(res);
				}
			});
			cb.get();
		//	std::cout<<"sAaSRD done"<<std::endl;
		} else {
		//	std::cout<<"sAaSRD failed"<<std::endl;
			throw CallbackNotSet();
		}
	}
	 virtual void updateSessionId(const std::string& streamRoomId,
						 const int64_t sessionId,
								  const std::string& connectionType) override{
		// std::cout<<"updating Seesion Id..."<<std::endl;
		 if (_usicb){
			 USICBParam ctx {
				 .roomId = streamRoomId,
				 .sessionId = sessionId,
				 .connectionType = connectionType,
				 .context = _usicbContext
			 };
			 std::future<void> cb = std::async(std::launch::async,[&](){
				 auto res = _usicb(&ctx);
				 if (res.name != ""){
					 throw SwiftErrorException(res);
				 }
			 });
			 cb.get();
			// std::cout<<"uSI done"<<std::endl;
		 } else {
			//std::cout<<"uSI done failed"<<std::endl;
			 throw CallbackNotSet();
		 }
	 }
	virtual void close(const std::string& streamRoomId)override{
		//std::cout<<"closing"<<std::endl;
		if(_ccb){
			CCBParam ctx{
				.roomId = streamRoomId,
				.context = _ccbContext
			};
			std::future<void> cb = std::async(std::launch::async,[&](){
				auto res = _ccb(&ctx);
				if (res.name != ""){
					throw SwiftErrorException(res);
				}
			});
			cb.get();
		//	std::cout<<"closing done"<<std::endl;
		} else {
			//std::cout<<"closing failed"<<std::endl;
			throw CallbackNotSet();
		}
	}
	 virtual void updateKeys(const std::string& streamRoomId,
							 const std::vector<privmx::endpoint::stream::Key>& keys)override{
		 auto ctx = UKCBParam{
			 .keys = keys,
			 .roomId = streamRoomId,
			 .context = _ukcbContext
		 };
		 
		 //std::cout<<"[dbg]updating "<<keys.size()<<" Keys... "<<std::endl;
		 if(_ukcb){
			 std::future<void> cb = std::async([&](){
				 if (_ukcb && _ukcbContext){
				//	 printf("%p", &_ukcb);
				//	 std::cout<<"(uK) still has callback and context:"<<_ukcbContext<<std::endl;
				 }
				 auto res = _ukcb(&ctx);//ctx);
				 if (res != ""){
				//	 std::cout<<"uK failed"<<std::endl;
					 throw SwiftErrorException(InternalError());
				 }
				 std::cout<<res<<std::endl;
			 });
			 cb.get();
			 //std::cout<<"uK done"<<std::endl;
		 } else {
			 //std::cout<<"uK failed"<<std::endl;
			 throw CallbackNotSet();
		 }
	 }
	 WebRtcInterfaceInstance(const CreateOfferAndSetLocalDescriptionCallback coasldcb,
							 const void* coasldcbContext,
							 const CreateAnswerAndSetDescriptionCallback caasdcb,
							 const void* caasdcbContext,
							 const SetAnswerAndSetRemoteDescriptionCallback saasrdcb,
							 const void* saasrdcbContext,
							 const UpdateSessionIdCallback usicb,
							 const void* usicbContext,
							 const UpdateKeysCallback ukcb,
							 const void* ukcbContext,
							 const CloseCallback ccb,
							 const void* ccbContext
							 ){
		 _caasdcb = caasdcb;
		 _caasdcbContext = caasdcbContext;
		 _coasldcb = coasldcb;
		 _coasldcbContext = coasldcbContext;
		 _saasrdcb = saasrdcb;
		 _saasrdcbContext = saasrdcbContext;
		 _usicb = usicb;
		 _usicbContext = usicbContext;
		 _ukcb = ukcb;
		 _ukcbContext = ukcbContext;
		 _ccb = ccb;
		 _ccbContext = ccbContext;
	 }
	
private:
	CreateAnswerAndSetDescriptionCallback _caasdcb;
	const void* _caasdcbContext;
	CreateOfferAndSetLocalDescriptionCallback _coasldcb;
	const void* _coasldcbContext;
	SetAnswerAndSetRemoteDescriptionCallback _saasrdcb;
	const void* _saasrdcbContext;
	UpdateSessionIdCallback _usicb;
	const void* _usicbContext;
	UpdateKeysCallback _ukcb;
	const void*  _ukcbContext;
	CloseCallback _ccb;
	const void* _ccbContext;
	
};

}
#endif // !_WebRtcInterfaceInstance_

