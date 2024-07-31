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

import Foundation
import Cxx
import CxxStdlib
import PrivMXEndpointSwiftNative

/// Swift wrapper for `privmx.NativeCryptoApiWrapper`.
public class CryptoApi{
	/// An instance of the wrapped C++ class.
	private var api: privmx.NativeCryptoApiWrapper
	
	/// Creates a new CryptoApi instance
	public init(
	){
		self.api = privmx.NativeCryptoApiWrapper.create()
	}
	
	/// Creates a signature of the given data and Key
	///
	/// - Parameter data: Data to be signed
	/// - Parameter key: WIF Key to be used in the signing
	///
	/// - Returns: Signed Data
	///
	/// - Throws: `PrivMXEndpointError.failedSigning` if an exception was thrown in C++ code, or another error occurred.
	public func sign(
		data: privmx.endpoint.core.Buffer,
		key: std.string
	) throws -> privmx.endpoint.core.Buffer {
		
		let res = api.cryptoSign(data, key)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedSigning(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedSigning(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Generates a new Private Key
	///
	/// - Parameter baseString: Optional base for generating the key.
	///
	/// - Returns: WIF Private Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if an exception was thrown in C++ code, or another error occurred.
	public func privKeyNew(
		baseString: std.string?
	) throws -> std.string {
		var bs = privmx.OptionalString()
		
		if let baseString{
			bs = privmx.makeOptional(baseString)
		}
		let res = api.cryptoPrivKeyNew(bs)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Deterministically generates a new Private Key from the provided strings
	///
	/// - Parameter password:
	/// - Parameter salt:
	///
	/// - Returns: WIF Private Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if an exception was thrown in C++ code, or another error occurred.
	public func privKeyNewPbkdf2(
		password: std.string,
		salt: std.string
	) throws -> std.string{
		
		let res = api.cryptoPrivKeyNewPbkdf2(password, salt)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Derives a Public Key from the Private Key
	///
	/// - Parameter from  privKey: Optional base for generating the key.
	///
	/// - Returns: WIF Private Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if an exception was thrown in C++ code, or another error occurred.
	public func pubKeyNew(
		from privKey: std.string
	) throws -> std.string {
		let res = api.cryptoPubKeyNew(privKey)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGeneratingPubKey(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGeneratingPubKey(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Encrypts data using AES.
	///
	/// - Parameter data: Data to be signed
	/// - Parameter key: 256bit binary data
	///
	/// - Returns: Encrypted data
	///
	/// - Throws: `PrivMXEndpointError.failedEncrypting` if an exception was thrown in C++ code, or another error occurred.
	public func encrypt(
		data: privmx.endpoint.core.Buffer,
		key: privmx.endpoint.core.Buffer
	) throws -> privmx.endpoint.core.Buffer{
		
		let res = api.cryptoEncrypt(data, key)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedEncrypting(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedEncrypting(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Decrypts data using AES.
	///
	/// - Parameter data: Data to be signed
	/// - Parameter key: 256bit binary data
	///
	/// - Returns: Encrypted data
	///
	/// - Throws: `PrivMXEndpointError.failedDecrypting` if an exception was thrown in C++ code, or another error occurred.
	public func decrypt(
		data: privmx.endpoint.core.Buffer,
		key: privmx.endpoint.core.Buffer
	) throws -> privmx.endpoint.core.Buffer{
		
		let res = api.cryptoDecrypt(data, key)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDecrypting(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedDecrypting(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	
	/// Converts a key from PEM format to WIF.
	///
	/// - Parameter kayPEM: key in PEM format
	///
	/// - Returns: Encrypted data
	///
	/// - Throws: `PrivMXEndpointError.failedEncrypting` if an exception was thrown in C++ code, or another error occurred.
	public func convertKeyPEMToWIF(
		_ keyPEM: std.string
	)throws -> std.string{
		
		let res = api.cryptoKeyConvertPEMToWIF(keyPEM)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedConvertingKeyToWIF(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedConvertingKeyToWIF(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
}
