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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_PRIVMXUTILS
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_PRIVMXUTILS

#include <optional>
#include <string>
#include <vector>
#include <memory>
#include <utility>

#include "privmx/endpoint/core/Config.hpp"
#include "privmx/endpoint/core/Exception.hpp"
#include "privmx/endpoint/core/ConvertedExceptions.hpp"
#include "privmx/endpoint/core/CoreException.hpp"
#include "privmx/endpoint/core/Types.hpp"
#include "privmx/endpoint/core/Connection.hpp"
#include "privmx/endpoint/core/EventQueue.hpp"
#include "privmx/endpoint/core/Events.hpp"
#include "privmx/endpoint/core/BackendRequester.hpp"
#include "privmx/endpoint/core/Utils.hpp"
#include "privmx/endpoint/core/UserVerifierInterface.hpp"

#include "privmx/endpoint/crypto/CryptoApi.hpp"
#include "privmx/endpoint/crypto/ExtKey.hpp"
#include "privmx/endpoint/crypto/Types.hpp"


#include "privmx/endpoint/inbox/InboxApi.hpp"
#include "privmx/endpoint/inbox/Types.hpp"
#include "privmx/endpoint/inbox/Events.hpp"
#include "privmx/endpoint/inbox/InboxException.hpp"
#include "privmx/endpoint/inbox/Constants.hpp"

#include "privmx/endpoint/store/StoreApi.hpp"
#include "privmx/endpoint/store/StoreException.hpp"
#include "privmx/endpoint/store/Types.hpp"
#include "privmx/endpoint/store/Events.hpp"
#include "privmx/endpoint/store/Constants.hpp"

#include "privmx/endpoint/thread/ThreadApi.hpp"
#include "privmx/endpoint/thread/Types.hpp"
#include "privmx/endpoint/thread/ThreadException.hpp"
#include "privmx/endpoint/thread/Events.hpp"
#include "privmx/endpoint/thread/Constants.hpp"

#include "privmx/endpoint/event/Events.hpp"
#include "privmx/endpoint/event/EventApi.hpp"
#include "privmx/endpoint/event/EventException.hpp"
#include "privmx/endpoint/event/Types.hpp"


namespace privmx {

class NullApiException : std::exception{
	const char * what() const noexcept override{
		return "The Api field is null";
	}
};

static const endpoint::store::StoreDataSchema::Version CurrentStoreSchema = endpoint::store::CURRENT_STORE_DATA_SCHEMA_VERSION;
static const endpoint::store::FileDataSchema::Version CurrentFileSchema = endpoint::store::CURRENT_FILE_DATA_SCHEMA_VERSION;
static const endpoint::thread::ThreadDataSchema::Version CurrentThreadSchema = endpoint::thread::CURRENT_THREAD_DATA_SCHEMA_VERSION;
static const endpoint::thread::MessageDataSchema::Version CurrentMessageSchema = endpoint::thread::CURRENT_MESSAGE_DATA_SCHEMA_VERSION;
static const endpoint::inbox::InboxDataSchema::Version CurrentInboxSchema = endpoint::inbox::CURRENT_INBOX_DATA_SCHEMA_VERSION;
static const endpoint::inbox::EntryDataSchema::Version CurrentEntrySchema = endpoint::inbox::CURRENT_ENTRY_DATA_SCHEMA_VERSION;

using StoreFileHandle = int64_t;
using InboxHandle [[deprecated("Use EntryHandle instead")]] = int64_t;
using EntryHandle = int64_t;
using InboxFileHandle = int64_t;
using InboxFileHandleVector = std::vector<InboxFileHandle>;
using StringVector = std::vector<std::string>;
using FileVector = std::vector<endpoint::store::File>;
using OptionalString = std::optional<std::string>;
using UserWithPubKeyVector = std::vector<endpoint::core::UserWithPubKey>;
using UserInfoVector = std::vector<endpoint::core::UserInfo>;

using OptionalInboxFilesConfig = std::optional<endpoint::inbox::FilesConfig>;

using OptionalItemPolicy = std::optional<endpoint::core::ItemPolicy>;
using OptionalContainerPolicy = std::optional<endpoint::core::ContainerPolicy>;
using OptionalContainerPolicyWithoutItem = std::optional<endpoint::core::ContainerPolicyWithoutItem>;

using ContextList = endpoint::core::PagingList<endpoint::core::Context>;
using ThreadList = endpoint::core::PagingList<endpoint::thread::Thread>;
using MessageList = endpoint::core::PagingList<endpoint::thread::Message>;
using StoreList = endpoint::core::PagingList<endpoint::store::Store>;
using FileList = endpoint::core::PagingList<endpoint::store::File>;
using InboxList = endpoint::core::PagingList<endpoint::inbox::Inbox>;
using InboxEntryList = endpoint::core::PagingList<endpoint::inbox::InboxEntry>;

using BoolVector = std::vector<bool>;
using VerificationRequestVector = std::vector<endpoint::core::VerificationRequest>;

typedef BoolVector(*VerificationImplementation)(const std::vector<endpoint::core::VerificationRequest>&);

/**
 * Holds data extracted from the thrown Exception
 **/
struct InternalError{
	std::string name; ///< Name of the error
	/**
	 * Message of the caught exception
	 */
	std::string message;
	/**
	 * Description of the internal error
	 */
	std::string description;
	/**
	 * Error Code, if it was provided
	 */
	std::optional<unsigned int> code;
};

/**
 * Holds the optional result of called method.\n
 * Used for bridging error handling from Cpp to Swift
 */
template<typename R = nullptr_t>
struct ResultWithError{
	/**
	 * An optional field holding the result.
	 */
	std::optional<R> result;
	/**
	 * Data extracted from the caught exception, if any
	 */
	std::optional<InternalError> error;
};



/// Creates a C++ `std::optional` containing the provided `std::string`
static OptionalString makeOptional(const std::string& val){
	return std::make_optional(val);
}

/// Creates a C++ `std::optional` containing the provided `FilesConfig`
static OptionalInboxFilesConfig makeOptional(const endpoint::inbox::FilesConfig& val){
	return std::make_optional(val);
}

/// Creates a C++ `std::optional` containing the provided `ItemPolicy`
static OptionalItemPolicy makeOptional(const endpoint::core::ItemPolicy& val){
	return std::make_optional(val);
}

/// Creates a C++ `std::optional` containing the provided `ContainerPolicy`
static OptionalContainerPolicy makeOptional(const endpoint::core::ContainerPolicy& val){
	return std::make_optional(val);
}

/// Creates a C++ `std::optional` containing the provided `ContainerPolicyWithoutItem`
static OptionalContainerPolicyWithoutItem makeOptional(const endpoint::core::ContainerPolicyWithoutItem& val){
	return std::make_optional(val);
}

/// Exposes vector comaprison in Swift
static bool compareVectors(const StringVector& lhs, const StringVector& rhs){
	return lhs == rhs;
}

/// Exposes vector comaprison in Swift
static bool compareVectors(const FileVector& lhs, const FileVector& rhs){
	auto lim = lhs.size();
	auto res = lim == rhs.size();
	for(long i=0;res && i<lim;++i){
		const endpoint::store::File& l=lhs.at(i),&r = rhs.at(i);
		res = l.size == r.size
		&& l.info.author == r.info.author
		&& l.info.createDate == r.info.createDate
		&& l.info.fileId == r.info.fileId
		&& l.info.storeId == r.info.storeId
		&& l.statusCode == r.statusCode
		&& l.authorPubKey == r.authorPubKey
		&& l.privateMeta == r.privateMeta
		&& l.publicMeta == r.publicMeta;
	}
	return res;
}

/// Returns a copy of the underlying `std::string` from the provided Buffer
static std::string stringFromBuffer(const endpoint::core::Buffer& buf){
	return std::string(buf.stdString());
}

static std::string getChannelFrom(const endpoint::event::ContextCustomEvent& event){
	return event.channel;
}

class UserVerifier : public endpoint::core::UserVerifierInterface{
public:
	BoolVector verify(const VerificationRequestVector& request) override {
		return _cb(request);
	}
	
	UserVerifier(VerificationImplementation cb){
		_cb=cb;
	}
private:
	VerificationImplementation _cb;
};

namespace endpoint{
namespace wrapper{

static ResultWithError<std::string> _call_Hex_encode(const endpoint::core::Buffer& data) noexcept{
	ResultWithError<std::string> res;
	try{
		res.result = endpoint::core::Hex::encode(data);
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

static ResultWithError<endpoint::core::Buffer> _call_Hex_decode(const std::string& hex_data) noexcept{
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = endpoint::core::Hex::decode(hex_data);
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

static ResultWithError<bool> _call_Hex_is(const std::string& data) noexcept{
	ResultWithError<bool> res;
	try{
		res.result = endpoint::core::Hex::is(data);
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

static ResultWithError<std::string> _call_Base32_encode(const endpoint::core::Buffer& data) noexcept{
	ResultWithError<std::string> res;
	try{
		res.result = endpoint::core::Base32::encode(data);
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

static ResultWithError<endpoint::core::Buffer> _call_Base32_decode(const std::string& base32_data) noexcept{
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = endpoint::core::Base32::decode(base32_data);
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

static ResultWithError<bool> _call_Base32_is(const std::string& data) noexcept{
	ResultWithError<bool> res;
	try{
		res.result = endpoint::core::Base32::is(data);
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

static ResultWithError<std::string> _call_Base64_encode(const endpoint::core::Buffer& data) noexcept{
	ResultWithError<std::string> res;
	try{
		res.result = endpoint::core::Base64::encode(data);
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

static ResultWithError<endpoint::core::Buffer> _call_Base64_decode(const std::string& base64_data) noexcept{
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = endpoint::core::Base64::decode(base64_data);
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

static ResultWithError<bool> _call_Base64_is(const std::string& data) noexcept{
	ResultWithError<bool> res;
	try{
		res.result = endpoint::core::Base64::is(data);
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

static ResultWithError<std::string> _call_Utils_trim(const std::string& data) noexcept{
	ResultWithError<std::string> res;
	try{
		res.result = endpoint::core::Utils::trim(data);
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

static ResultWithError<StringVector> _call_Utils_split(std::string data ,
													   const std::string &delimiter) noexcept{
	ResultWithError<StringVector> res;
	try{
		res.result = endpoint::core::Utils::split(data,
												  delimiter);
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

static ResultWithError<std::nullptr_t> _call_Utils_ltrim(std::string& data) noexcept{
	ResultWithError<> res;
	try{
		endpoint::core::Utils::ltrim(data);
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

static ResultWithError<std::nullptr_t> _call_Utils_rtrim(std::string& data) noexcept{
	ResultWithError<> res;
	try{
		endpoint::core::Utils::rtrim(data);
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
}

}

#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_PRIVMXUTILS */
