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

import Foundation
import Cxx
import CxxStdlib
import PrivMXEndpointSwiftNative

/// 'CryptoApi' is a class representing Endpoint's API for cryptographic operations.
///
/// This class wraps the underlying C++ implementation for use in Swift.
public class CryptoApi{
	
	/// An instance of the wrapped C++ class.
	private var api: privmx.NativeCryptoApiWrapper
	
	/// Creates instance of 'CryptoApi'.
	///
	/// - Returns: CryptoApi object
	public static func create(
	) -> CryptoApi {
		CryptoApi(api: privmx.NativeCryptoApiWrapper.create())
	}
	
	init(
		api: privmx.NativeCryptoApiWrapper
	){
		self.api = api
	}
	
	/// Creates a signature of data using given key.
	///
	/// - Parameter data: buffer to sign
	/// - Parameter privateKey: key used to sign data
	///
	/// - Returns: signature of data
	///
	/// - Throws: `PrivMXEndpointError.failedSigning` if the signing process fails due to an invalid key or data error.
	public func signData(
		data: privmx.endpoint.core.Buffer,
		privateKey: std.string
	) throws -> privmx.endpoint.core.Buffer {
		
		let res = api.signData(data, privateKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSigning(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedSigning(err)
		}
		return result
	}
	
	/// Validate a signature of data using given key.
	///
	/// - Parameter data: buffer
	/// - Parameter signature: signature of data to verify
	/// - Parameter publicKey: public ECC key in BASE58DER format used to validate data
	///
	/// - Returns: data validation result
	///
	/// - Throws: `PrivMXEndpointError.failedVerifyingSignature` if an verification process fails.
	public func verifySignature(
		data: privmx.endpoint.core.Buffer,
		signature: privmx.endpoint.core.Buffer,
		publicKey: std.string
	) throws -> Bool {
		let res = api.verifySignature(data,
									  signature,
									  publicKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedVerifyingSignature(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedVerifyingSignature(err)
		}
		return result
	}
	
	/// Generates a new symmetric key.
	///
	/// - Returns: generated key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingSymmetricKey` if there is an issue generating the key, for instance due to insufficient entropy or a system-level error.
	public func generateKeySymmetric(
	) throws -> privmx.endpoint.core.Buffer {
		let res = api.generateKeySymmetric()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingSymmetricKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGeneratingSymmetricKey(err)
		}
		return result
	}
	
	/// Generates a new private ECC key.
	///
	/// - Parameter randomSeed: optional string used as the base to generate the new key
	///
	/// - Returns: generated ECC key in WIF format
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if the key generation fails, potentially due to a system error or invalid seed.
	public func generatePrivateKey(
		randomSeed: std.string?
	) throws -> std.string {
		var rs = privmx.OptionalString()
		
		if let randomSeed{
			rs = privmx.makeOptional(randomSeed)
		}
		let res = api.generatePrivateKey(rs)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGeneratingPrivKey(err)
		}
		return result
	}
	
	/// Generates a new private ECC key from a password using pbkdf2.
	///
	/// - Parameter password: the password used to generate the new key
	/// - Parameter salt: random string (additional input for the hashing function)
	///
	/// - Returns: generated ECC key in WIF format
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if the key derivation fails, such as when using invalid input or a weak password.
	@available(*,deprecated,renamed: "derivePrivateKey2(password:salt:)")
	public func derivePrivateKey(
		password: std.string,
		salt: std.string
	) throws -> std.string{
		
		let res = api.derivePrivateKey(password, salt)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGeneratingPrivKey(err)
		}
		return result
	}
	
	/// Generates a new private ECC key from a password using pbkdf2.
	///
	/// This version of the derive function has a rounds count increased to 200k. This makes using this function a safer choice, but it makes the received key different than in the original version.
	///
	/// - Parameter password: the password used to generate the new key
	/// - Parameter salt: random string (additional input for the hashing function)
	///
	/// - Returns: generated ECC key in WIF format
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPrivKey` if the key derivation fails, such as when using invalid input or a weak password.
	public func derivePrivateKey2(
		password: std.string,
		salt: std.string
	) throws -> std.string{
		
		let res = api.derivePrivateKey2(password, salt)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingPrivKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGeneratingPrivKey(err)
		}
		return result
	}
	
	/// Generates a new public ECC key as a pair for an existing private key.
	///
	/// - Parameter privKey: private ECC key in WIF format
	///
	/// - Returns: generated ECC key in BASE58DER format
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingPubKey` if the derivation process fails, such as if the private key is invalid.
	public func derivePublicKey(
		privKey: std.string
	) throws -> std.string {
		let res = api.derivePublicKey(privKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingPubKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedGeneratingPubKey(err)
		}
		return result
	}
	
	
	/// Encrypts buffer with a given key using AES.
	///
	/// - Parameter data: buffer to encrypt
	/// - Parameter symmetricKey: key used to encrypt data
	///
	/// - Returns: encrypted data buffer
	///
	/// - Throws: `PrivMXEndpointError.failedEncrypting` if the encryption process fails, typically due to an invalid key or data format.
	public func encryptDataSymmetric(
		data: privmx.endpoint.core.Buffer,
		symmetricKey: privmx.endpoint.core.Buffer
	) throws -> privmx.endpoint.core.Buffer{
		
		let res = api.encryptDataSymmetric(data, symmetricKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEncrypting(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedEncrypting(err)
		}
		return result
	}
	
	
	/// Decrypts buffer with a given key using AES.
	///
	/// - Parameter data: buffer to decrypt
	/// - Parameter symmetricKey: key used to decrypt data
	///
	/// - Returns: plain (decrypted) data buffer
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedDecrypting` if the decryption process fails, often due to an incorrect key or tampered data.
	public func decryptDataSymmetric(
		data: privmx.endpoint.core.Buffer,
		symmetricKey: privmx.endpoint.core.Buffer
	) throws -> privmx.endpoint.core.Buffer{
		
		let res = api.decryptDataSymmetric(data, symmetricKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDecrypting(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedDecrypting(err)
		}
		return result
	}
	
	
	/// Converts given private key in PEM format to its WIF format.
	///
	/// - Parameter pemKey: private key to convert
	///
	/// - Returns: private key in WIF format
	///
	/// - Throws: `PrivMXEndpointError.failedConvertingKeyToWIF` if the conversion fails due to an invalid key or format.
	public func convertPEMKeyToWIFKey(
		pemKey: std.string
	)throws -> std.string{
		
		let res = api.convertPEMKeyToWIFKey(pemKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConvertingKeyToWIF(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedConvertingKeyToWIF(err)
		}
		return result
	}
	
	
	/// Converts given public key in PGP format to its base58DER format.
	///
	/// - Parameter pgpKey: public key to convert
	///
	/// - Throws: `PrivMXEndpointError.failedConvertingKeyToBase58DER` if the conversion fails.
	///
	/// - Returns: public key in base58DER format
	public func convertPGPAsn1KeyToBase58DERKey(
		pgpKey: std.string
	) throws -> std.string {
		let res = api.convertPGPAsn1KeyToBase58DERKey(pgpKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConvertingKeyToBase58DER(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedConvertingKeyToBase58DER(err)
		}
		return result
	}
	
	
	/// Generates ECC key and BIP-39 mnemonic from a password using BIP-39.
	///
	/// - Parameter strength: size of BIP-39 entropy, must be a multiple of 32
	/// - Parameter password: the password used to generate the Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingBIP39` if the generating fails.
	///
	/// - Returns: `BIP39` object containing ECC Key and associated with it BIP-39 mnemonic and entropy
	public func generateBip39(
		strength: size_t,
		password: std.string = std.string()
	) throws -> BIP39 {
		let res = api.generateBip39(strength,
									password)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingBIP39(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGeneratingBIP39(err)
		}
		return BIP39(wrapping:result)
	}
	
	
	/// Generates ECC key using BIP-39 mnemonic.
	///
	/// - Parameter mnemonic: the BIP-39 entropy used to generate the Key
	/// - Parameter password: the password used to generate the Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingBIP39` if the generating fails.
	///
	/// - Returns: `BIP39` object containing ECC Key and associated with it BIP-39 mnemonic and entropy
	public func fromMnemonic(
		mnemonic: std.string,
		password: std.string = std.string()
	) throws -> BIP39 {
		let res = api.fromMnemonic(mnemonic,
								   password)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingBIP39(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGeneratingBIP39(err)
		}
		return BIP39(wrapping:result)
	}
	
	
	/// Generates ECC key using BIP-39 entropy.
	///
	/// - Parameter entropy: the BIP-39 entropy used to generate the Key
	/// - Parameter password: the password used to generate the Key
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingBIP39` if the generating fails.
	///
	/// - Returns: `BIP39` object containing ECC Key and associated with it BIP-39 mnemonic and entropy
	public func fromEntropy(
		entropy: privmx.endpoint.core.Buffer,
		password: std.string = std.string()
	)throws -> BIP39 {
		let res = api.fromEntropy(entropy,
								  password)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingBIP39(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGeneratingBIP39(err)
		}
		return BIP39(wrapping:result)
	}
	
	
	/// Converts BIP-39 mnemonic to entropy.
	///
	/// - Parameter entropy: BIP-39 entropy
	///
	/// - Throws: `PrivMXEndpointError.failedConvertingEntropyToMnemonic` if the conversion fails.
	///
	/// - Returns: BIP-39 mnemonic
	public func entropyToMnemonic(
		entropy: privmx.endpoint.core.Buffer
	) throws -> std.string {
		let res = api.entropyToMnemonic(entropy)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConvertingEntropyToMnemonic(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedConvertingEntropyToMnemonic(err)
		}
		return result
	}
	
	
	/// Converts BIP-39 mnemonic to entropy.
	///
	/// - Parameter mnemonic: BIP-39 mnemonic
	///
	/// - Throws: `PrivMXEndpointError.failedConvertingMnemonicToEntropy` if the conversion fails.
	///
	/// - Returns: BIP-39 entropy
	public func mnemonicToEntropy(
		mnemonic: std.string
	) throws -> privmx.endpoint.core.Buffer {
		let res = api.mnemonicToEntropy(mnemonic)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConvertingMnemonicToEntropy(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedConvertingMnemonicToEntropy(err)
		}
		return result
	}
	
	
	/// Generates a seed used to generate a key using BIP-39 mnemonic with PBKDF2.
	///
	/// - Parameters mnemonic: BIP-39 mnemonic
	/// - Parameters password: the password used to generate the seed
	///
	/// - Throws: `PrivMXEndpointError.failedGeneratingSeedFromMnemonic` if the generating fails.
	///
	/// - Returns: generated seed
	public func mnemonicToSeed(
		mnemonic: std.string,
		password: std.string = std.string()
	) throws -> privmx.endpoint.core.Buffer {
		let res = api.mnemonicToSeed(mnemonic,
									 password)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGeneratingSeedFromMnemonic(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGeneratingSeedFromMnemonic(err)
		}
		return result
	}
}
