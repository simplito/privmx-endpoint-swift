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

#include "NativeCryptoApiWrapper.hpp"
namespace privmx {

using namespace endpoint;
NativeCryptoApiWrapper::NativeCryptoApiWrapper(){
	api = std::make_shared<endpoint::crypto::CryptoApi>(endpoint::crypto::CryptoApi::create());
}

NativeCryptoApiWrapper NativeCryptoApiWrapper::create(){
	return NativeCryptoApiWrapper();
}

ResultWithError<core::Buffer> NativeCryptoApiWrapper::generateKeySymmetric(){
	ResultWithError<core::Buffer> res;
	try {
		res.result = getapi()->generateKeySymmetric();
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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


ResultWithError<std::string> NativeCryptoApiWrapper::generatePrivateKey(const OptionalString& randomSeed){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->generatePrivateKey(randomSeed);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeCryptoApiWrapper::derivePublicKey(const std::string& privKey){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->derivePublicKey(privKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<core::Buffer> NativeCryptoApiWrapper::encryptDataSymmetric(const core::Buffer& data,
																		   const core::Buffer& symmetricKey){
	ResultWithError<core::Buffer> res;
	try {
		res.result = getapi()->encryptDataSymmetric(data,
													symmetricKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<core::Buffer> NativeCryptoApiWrapper::decryptDataSymmetric(const core::Buffer& data,
																		   const core::Buffer& symmetricKey){
	ResultWithError<core::Buffer> res;
	try {
		res.result = getapi()->decryptDataSymmetric(data,
													symmetricKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<core::Buffer> NativeCryptoApiWrapper::signData(const core::Buffer& data,
																 const std::string& privateKey){
	ResultWithError<core::Buffer> res;
	try {
		res.result = getapi()->signData(data,
										privateKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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


ResultWithError<std::string> NativeCryptoApiWrapper::convertPEMKeyToWIFKey(const std::string &pemKey){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->convertPEMKeytoWIFKey(pemKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeCryptoApiWrapper::derivePrivateKey(const std::string &password,
																	 const std::string &salt){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->derivePrivateKey(password,
												salt);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeCryptoApiWrapper::derivePrivateKey2(const std::string &password,
																	 const std::string &salt){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->derivePrivateKey2(password,
												salt);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> NativeCryptoApiWrapper::verifySignature(
	const endpoint::core::Buffer& data,
	const endpoint::core::Buffer& signature,
	const std::string& publicKey
){
	ResultWithError<bool> res;
	try {
		res.result = getapi()->verifySignature(data,
											   signature,
											   publicKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeCryptoApiWrapper::convertPGPAsn1KeyToBase58DERKey(const std::string& pgpKey){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->convertPGPAsn1KeyToBase58DERKey(pgpKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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


ResultWithError<endpoint::crypto::BIP39_t> NativeCryptoApiWrapper::generateBip39(std::size_t strength,
																				 const std::string& password){
	ResultWithError<endpoint::crypto::BIP39_t> res;
	try {
		res.result = getapi()->generateBip39(strength,
											 password);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<endpoint::crypto::BIP39_t> NativeCryptoApiWrapper::fromMnemonic(const std::string& mnemonic,
																				const std::string& password){
	ResultWithError<endpoint::crypto::BIP39_t> res;
	try {
		res.result = getapi()->fromMnemonic(mnemonic,
											password);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<endpoint::crypto::BIP39_t> NativeCryptoApiWrapper::fromEntropy(const endpoint::core::Buffer& entropy,
																			   const std::string& password){
	ResultWithError<endpoint::crypto::BIP39_t> res;
	try {
		res.result = getapi()->fromEntropy(entropy,
										   password);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeCryptoApiWrapper::entropyToMnemonic(const endpoint::core::Buffer& entropy){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->entropyToMnemonic(entropy);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<endpoint::core::Buffer> NativeCryptoApiWrapper::mnemonicToEntropy(const std::string& mnemonic){
	ResultWithError<endpoint::core::Buffer> res;
	try {
		res.result = getapi()->mnemonicToEntropy(mnemonic);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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


ResultWithError<endpoint::core::Buffer> NativeCryptoApiWrapper::mnemonicToSeed(const std::string& mnemonic,
																			   const std::string& password){
	ResultWithError<endpoint::core::Buffer> res;
	try {
		res.result = getapi()->mnemonicToSeed(mnemonic,
											  password);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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
