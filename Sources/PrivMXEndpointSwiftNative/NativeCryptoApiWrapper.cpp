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

#include "NativeCryptoApiWrapper.hpp"
namespace privmx {

using namespace endpoint;
NativeCryptoApiWrapper::NativeCryptoApiWrapper(){
	api = std::make_shared<endpoint::crypto::CryptoApi>(endpoint::crypto::CryptoApi::create());
}

NativeCryptoApiWrapper NativeCryptoApiWrapper::create(){
	return NativeCryptoApiWrapper();
}

ResultWithError<std::string> NativeCryptoApiWrapper::cryptoPrivKeyNew(const OptionalString& basestring){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->cryptoPrivKeyNew(basestring);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(privKeyNew) ") + std::string(err.what());
	}catch (std::exception & err) {
		res.error = std::string("(privKeyNew) ") + std::string(err.what());
	}catch (...) {
		res.error = "(privKeyNew) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::string> NativeCryptoApiWrapper::cryptoPubKeyNew(const std::string& privKey){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->cryptoPubKeyNew(privKey);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(pubKeyNew) ") + std::string(err.what());
	}catch (std::exception & err) {
		res.error = std::string("(pubKeyNew) ") + std::string(err.what());
	}catch (...) {
		res.error = "(pubKeyNew) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::Buffer> NativeCryptoApiWrapper::cryptoEncrypt(const core::Buffer& data,
															const core::Buffer& key){
	ResultWithError<endpoint::core::Buffer> res;
	try {
		res.result = getapi()->cryptoEncrypt(data, key);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(encrypt) ") + std::string(err.what());
	}catch (std::exception & err) {
		res.error = std::string("(encrypt) ") + std::string(err.what());
	}catch (...) {
		res.error = "(encrypt) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::Buffer> NativeCryptoApiWrapper::cryptoDecrypt(const core::Buffer& data,
															const core::Buffer& key){
	ResultWithError<endpoint::core::Buffer> res;
	try {
		res.result = getapi()->cryptoDecrypt(data, key);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(decrypt) ") + std::string(err.what());
	}catch (std::exception & err) {
		res.error = std::string("(decrypt) ") + std::string(err.what());
	}catch (...) {
		res.error = "(decrypt) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::Buffer> NativeCryptoApiWrapper::cryptoSign(const core::Buffer& data,
														 const std::string& key){
	ResultWithError<endpoint::core::Buffer> res;
	try {
		res.result = getapi()->cryptoSign(data, key);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(sign) ") + std::string(err.what());
	}catch (std::exception & err) {
		res.error = std::string("(sign) ") + std::string(err.what());
	}catch (...) {
		res.error = "(sign) Unknown error, failed to work";
	}
	return res;
}


ResultWithError<std::string> NativeCryptoApiWrapper::cryptoKeyConvertPEMToWIF(const std::string &keyPEM){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->cryptoKeyConvertPEMToWIF(keyPEM);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(keyPEMToKeyWIF) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(keyPEMToKeyWIF) ") + std::string(err.what());
	}catch (...) {
		res.error = "(keyPEMToKeyWIF) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::string> NativeCryptoApiWrapper::cryptoPrivKeyNewPbkdf2(const std::string &password,
																	 const std::string &salt){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->cryptoPrivKeyNewPbkdf2(password, salt);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(privKeyNewPbkdf2) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(privKeyNewPbkdf2) ") + std::string(err.what());
	}catch (...) {
		res.error = "(privKeyNewPbkdf2) Unknown error, failed to work";
	}
	return res;
}

}
