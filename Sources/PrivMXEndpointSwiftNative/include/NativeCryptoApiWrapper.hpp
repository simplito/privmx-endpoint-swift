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
	
	static NativeCryptoApiWrapper create();
	
	ResultWithError<std::string> generatePrivateKey(const OptionalString& randomSeed);
	
	[[deprecated("Use derivePrivateKey2(const std::string& password, const std::string& salt).")]]
	ResultWithError<std::string> derivePrivateKey(const std::string& password,
												 const std::string& salt);
	
	ResultWithError<std::string> derivePrivateKey2(const std::string& password,
												 const std::string& salt);
	
	ResultWithError<std::string> derivePublicKey(const std::string& privKey);
	

	ResultWithError<endpoint::core::Buffer> encryptDataSymmetric(const endpoint::core::Buffer& data,
										const endpoint::core::Buffer& key);

	ResultWithError<endpoint::core::Buffer> decryptDataSymmetric(const endpoint::core::Buffer& data,
										const endpoint::core::Buffer& key);
	
	ResultWithError<endpoint::core::Buffer> signData(const endpoint::core::Buffer& data,
									 const std::string& key);
	
	ResultWithError<bool> verifySignature(
		const endpoint::core::Buffer& data,
		const endpoint::core::Buffer& signature,
		const std::string& publicKey
	);
	
	ResultWithError<std::string> convertPEMKeyToWIFKey(const std::string& keyPEM);
	
	
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
	
	std::shared_ptr<endpoint::crypto::CryptoApi> getApi(){
		if (!api) throw NullApiException();
		return api;
	}
};

}
#endif /* _PRIVMX_ENDPOINT_SWIFT_NATIVE_CryptoApi_hpp */
