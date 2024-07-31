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

#ifndef CryptoApi_hpp
#define CryptoApi_hpp

#include "PrivMXUtils.hpp"

namespace privmx {
/**
 * C++ wrapper of `privmx::endpoint::crypto::CryptoApi`
 *
 * Catches errors in methods and allows for error handling in Swift. Holds a shared pointer to the wrapped class.
 */
class NativeCryptoApiWrapper{
public:
	
	/**
	 * Constructor
	 */
	static NativeCryptoApiWrapper create();
	
	/**
	 * Generates a new Private Key.
	 *
	 * @param baseString  : `const OptionalString&` aka `const std::optional<std:string>&` — Optional base for generating the key
	 *
	 * @return WIF Private Key, wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> cryptoPrivKeyNew(const OptionalString& basestring);
	
	/**
	 * Generates a new Private Key from two strings.
	 *
	 * @param password  : `const std::string&`
	 * @param salt : `const std::string&`
	 *
	 * @return Private WIF key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> cryptoPrivKeyNewPbkdf2(const std::string& password,
												 const std::string& salt);
	
	/**
	 * Derives a Public Key from the private one.
	 *
	 * @param privKey  : `const std::string&` — Private WIF key
	 *
	 * @return WIF Public key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> cryptoPubKeyNew(const std::string& privKey);
	
	
	/**
	 * Encrypts data using AES.
	 *
	 * @param data  : `const endpoint::core::Buffer&` — data to be encrypted
	 * @param key : `const endpoint::core::Buffer&` — 256-bit long binary key
	 *
	 * @return Encrypted data wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::Buffer> cryptoEncrypt(const endpoint::core::Buffer& data,
										const endpoint::core::Buffer& key);
	/**
	 * Decrypts data using AES.
	 *
	 * @param data  : `const endpoint::core::Buffer&` — data to be decrypted
	 * @param key : `const endpoint::core::Buffer&` — 256-bit long binary key
	 *
	 * @return Decrypted data wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::Buffer> cryptoDecrypt(const endpoint::core::Buffer& data,
										const endpoint::core::Buffer& key);
	
	/**
	 * Creates a signature of given data and key.
	 *
	 * @param data  : `const endpoint::core::Buffer&` — data to sign
	 * @param key : `const std::string&` — WIF key
	 *
	 * @return Signed data wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::Buffer> cryptoSign(const endpoint::core::Buffer& data,
									 const std::string& key);
	
	/**
	 * Converts a key from PEM format to WIF.
	 *
	 * @param keyPEM : `const std::string&` — kei in PEM format
	 *
	 * @return WIF Key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> cryptoKeyConvertPEMToWIF(const std::string& keyPEM);
	
private:
	std::shared_ptr<endpoint::crypto::CryptoApi> api;
	
	NativeCryptoApiWrapper();
	
	std::shared_ptr<endpoint::crypto::CryptoApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
};

}
#endif /* CryptoApi_hpp */
