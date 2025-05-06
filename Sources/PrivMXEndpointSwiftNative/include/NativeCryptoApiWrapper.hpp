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

#ifndef _PRIVMX_ENDPOINT_SWIFT_NATIVE_CryptoApi_hpp
#define _PRIVMX_ENDPOINT_SWIFT_NATIVE_CryptoApi_hpp

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
	ResultWithError<std::string> generatePrivateKey(const OptionalString& randomSeed);
	
	/**
	 * Generates a new Private Key from two strings.
	 *
	 * @param password  : `const std::string&`
	 * @param salt : `const std::string&`
	 *
	 * @return Private WIF key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	[[deprecated("Use derivePrivateKey2(const std::string& password, const std::string& salt).")]]
	ResultWithError<std::string> derivePrivateKey(const std::string& password,
												 const std::string& salt);
	
	/**
	 * Generates a new Private Key from two strings.
	 *
	 * @param password  : `const std::string&`
	 * @param salt : `const std::string&`
	 *
	 * @return Private WIF key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> derivePrivateKey2(const std::string& password,
												 const std::string& salt);
	
	/**
	 * Derives a Public Key from the private one.
	 *
	 * @param privKey  : `const std::string&` — Private WIF key
	 *
	 * @return WIF Public key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> derivePublicKey(const std::string& privKey);
	
	
	/**
	 * Encrypts data using AES.
	 *
	 * @param data  : `const endpoint::core::Buffer&` — data to be encrypted
	 * @param key : `const endpoint::core::Buffer&` — 256-bit long binary key
	 *
	 * @return Encrypted data wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<endpoint::core::Buffer> encryptDataSymmetric(const endpoint::core::Buffer& data,
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
	ResultWithError<endpoint::core::Buffer> decryptDataSymmetric(const endpoint::core::Buffer& data,
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
	ResultWithError<endpoint::core::Buffer> signData(const endpoint::core::Buffer& data,
									 const std::string& key);
	
	/**
	 * Validate a signature of data using given key.
	 *
	 * @param data buffer containing the data signature of which is being verified
	 * @param signature signature to be verified
	 * @param publicKey public ECC key in BASE58DER format used to validate data
	 * @return data validation result
	 */
	ResultWithError<bool> verifySignature(
		const endpoint::core::Buffer& data,
		const endpoint::core::Buffer& signature,
		const std::string& publicKey
	);
	
	/**
	 * Converts a key from PEM format to WIF.
	 *
	 * @param keyPEM : `const std::string&` — kei in PEM format
	 *
	 * @return WIF Key wrapped in a`ResultWithError` structure for error handling.
	 *
	 */
	ResultWithError<std::string> convertPEMKeyToWIFKey(const std::string& keyPEM);
	
	/// Generates a key for symmetric encryption
	ResultWithError<endpoint::core::Buffer> generateKeySymmetric();
	
	ResultWithError<std::string> convertPGPAsn1KeyToBase58DERKey(const std::string& pgpKey);
	ResultWithError<endpoint::crypto::BIP39_t> generateBip39(std::size_t strength,
															 const std::string& password = std::string());
	ResultWithError<endpoint::crypto::BIP39_t> fromMnemonic(const std::string& mnemonic,
															const std::string& password = std::string());
	ResultWithError<endpoint::crypto::BIP39_t> fromEntropy(const endpoint::core::Buffer& entropy,
														   const std::string& password = std::string());
	ResultWithError<std::string> entropyToMnemonic(const endpoint::core::Buffer& entropy);
	ResultWithError<endpoint::core::Buffer> mnemonicToEntropy(const std::string& mnemonic);
	ResultWithError<endpoint::core::Buffer> mnemonicToSeed(const std::string& mnemonic,
														   const std::string& password = std::string());
	
private:
	std::shared_ptr<endpoint::crypto::CryptoApi> api;
	
	NativeCryptoApiWrapper();
	
	std::shared_ptr<endpoint::crypto::CryptoApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
};

}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_CryptoApi_hpp */
