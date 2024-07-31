//
// PrivMX Endpoint Swift
// Copyright © 2024 Simplito sp. z o.o.
//
// This file is part of the PrivMX Platform (https://privmx.cloud).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//

#ifndef Header_h
#define Header_h

#include <optional>
#include <string>
#include <vector>
#include <memory>
#include <utility>

#include "privmx/endpoint/core/Config.hpp"
#include "privmx/endpoint/core/Exception.hpp"
#include "privmx/endpoint/core/Types.hpp"
#include "privmx/endpoint/core/CoreApi.hpp"
#include "privmx/endpoint/crypto/CryptoApi.hpp"
#include "privmx/endpoint/store/StoreApi.hpp"
#include "privmx/endpoint/thread/ThreadApi.hpp"

namespace privmx {

class NullApiException : std::exception{
	const char * what() const noexcept override{
		return "The Api field is null";
	}
};

using PMXFileHandle = int64_t;
using StringVector = std::vector<std::string>;
using OptionalString = std::optional<std::string>;
using UserWithPubKeyVector = std::vector<endpoint::core::UserWithPubKey>;

/**
* Holds the optional result of called method.\n
* Used for bridging error handling from Cpp to Swift
*/
template<class T = nullptr_t> struct ResultWithError{
	std::optional<T> result; ///< An optional field holding the result.
	std::string error; ///< Error message, usually contains the description of a thrown exception.
	};

static OptionalString makeOptional(const std::string& val){
	return std::make_optional(val);
}

/// Exposes vector comaprison in Swift
static bool compareVectors(const StringVector& lhs, const StringVector& rhs){
	return lhs == rhs;
}

/// Returns a copy of the underlying std::string from the provided Buffer
static std::string stringFromBuffer(const endpoint::core::Buffer& buf){
	return std::string(buf.stdString());
}

}

#endif /* Header_h */
