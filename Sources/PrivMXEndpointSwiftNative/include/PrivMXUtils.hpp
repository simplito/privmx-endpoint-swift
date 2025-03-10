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
#include "privmx/endpoint/core/Types.hpp"
#include "privmx/endpoint/core/Connection.hpp"
#include "privmx/endpoint/crypto/CryptoApi.hpp"
#include "privmx/endpoint/store/StoreApi.hpp"
#include "privmx/endpoint/store/Types.hpp"
#include "privmx/endpoint/thread/ThreadApi.hpp"
#include "privmx/endpoint/thread/Types.hpp"
#include "privmx/endpoint/core/EventQueue.hpp"
#include "privmx/endpoint/core/Events.hpp"
#include "privmx/endpoint/thread/Events.hpp"
#include "privmx/endpoint/store/Events.hpp"
#include "privmx/endpoint/core/BackendRequester.hpp"
#include "privmx/endpoint/inbox/InboxApi.hpp"
#include "privmx/endpoint/inbox/Types.hpp"
#include "privmx/endpoint/inbox/Events.hpp"

namespace privmx {

class NullApiException : std::exception{
	const char * what() const noexcept override{
		return "The Api field is null";
	}
};


using StoreFileHandle = int64_t;
using InboxHandle [[deprecated("Use EntryHandle instead")]] = int64_t;
using EntryHandle = int64_t;
using InboxFileHandle = int64_t;
using InboxFileHandleVector = std::vector<InboxFileHandle>;
using StringVector = std::vector<std::string>;
using OptionalString = std::optional<std::string>;
using UserWithPubKeyVector = std::vector<endpoint::core::UserWithPubKey>;

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

/// Returns a copy of the underlying `std::string` from the provided Buffer
static std::string stringFromBuffer(const endpoint::core::Buffer& buf){
	return std::string(buf.stdString());
}
}

#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_PRIVMXUTILS */
