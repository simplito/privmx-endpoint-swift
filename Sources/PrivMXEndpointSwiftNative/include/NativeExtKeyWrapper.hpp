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

#ifndef NATIVE_EXTKEY_WRAPPER_HPP
#define NATIVE_EXTKEY_WRAPPER_HPP
#include "PrivMXUtils.hpp"

namespace privmx{
namespace endpoint{
namespace wrapper{

static ResultWithError<endpoint::crypto::ExtKey> _call_ExtKey_fromSeed(const core::Buffer& seed) noexcept{
	ResultWithError<endpoint::crypto::ExtKey> res;
	try{
		res.result = endpoint::crypto::ExtKey::fromSeed(seed);
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

static ResultWithError<endpoint::crypto::ExtKey> _call_ExtKey_fromBase58(const std::string& base58) noexcept{
	ResultWithError<endpoint::crypto::ExtKey> res;
	try{
		res.result = endpoint::crypto::ExtKey::fromBase58(base58);
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

static ResultWithError<endpoint::crypto::ExtKey> _call_ExtKey_generateRandom() noexcept{
	ResultWithError<endpoint::crypto::ExtKey> res;
	try{
		res.result = endpoint::crypto::ExtKey::generateRandom();
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

static ResultWithError<endpoint::crypto::ExtKey> _call_ExtKey_derive(const endpoint::crypto::ExtKey& extKey,
																			  uint32_t index) noexcept {
	ResultWithError<endpoint::crypto::ExtKey> res;
	try{
		res.result = extKey.derive(index);
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

static ResultWithError<endpoint::crypto::ExtKey> _call_ExtKey_deriveHardened(const endpoint::crypto::ExtKey& extKey,
																					  uint32_t index) noexcept {
	ResultWithError<endpoint::crypto::ExtKey> res;
	try{
		res.result = extKey.deriveHardened(index);
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

static ResultWithError<std::string> _call_ExtKey_getPrivatePartAsBase58(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<std::string> res;
	try{
		res.result = extKey.getPrivatePartAsBase58();
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

static ResultWithError<std::string> _call_ExtKey_getPublicPartAsBase58(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<std::string> res;
	try{
		res.result = extKey.getPublicPartAsBase58();
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

static ResultWithError<std::string> _call_ExtKey_getPrivateKey(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<std::string> res;
	try{
		res.result = extKey.getPrivateKey();
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

static ResultWithError<std::string> _call_ExtKey_getPublicKey(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<std::string> res;
	try{
		res.result = extKey.getPublicKey();
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

static ResultWithError<endpoint::core::Buffer> _call_ExtKey_getPrivateEncKey(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = extKey.getPrivateEncKey();
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

static ResultWithError<std::string> _call_ExtKey_getPublicKeyAsBase58Address(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<std::string> res;
	try{
		res.result = extKey.getPublicKeyAsBase58Address();
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

static ResultWithError<endpoint::core::Buffer> _call_ExtKey_getChainCode(const endpoint::crypto::ExtKey& extKey) noexcept{
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = extKey.getChainCode();
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

static ResultWithError<bool> _call_ExtKey_verifyCompactSignatureWithHash(const endpoint::crypto::ExtKey& extKey,
																		 const core::Buffer& message,
																		 const core::Buffer& signature) noexcept{
	ResultWithError<bool> res;
	try{
		res.result = extKey.verifyCompactSignatureWithHash(message,
														   signature);
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

static ResultWithError<bool> _call_ExtKey_isPrivate(const endpoint::crypto::ExtKey& extKey) noexcept {
	ResultWithError<bool> res;
	try{
		res.result = extKey.isPrivate();
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


#endif//NATIVE_EXTKEY_WRAPPER_HPP
