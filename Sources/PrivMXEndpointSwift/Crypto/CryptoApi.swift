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

/// Swift wrapper for `privmx.NativeCryptoApiWrapper`.
///
/// This class provides cryptographic functions such as key generation, encryption, and decryption, as well as signing data. It wraps the underlying C++ implementation for use in Swift.
public class CryptoApi{
	
	/// An instance of the wrapped C++ class.
	private var api: privmx.NativeCryptoApiWrapper
	
	/// Creates a new `CryptoApi` instance.
	///
	/// - Returns: A new `CryptoApi` instance.
	public static func create(
	) -> CryptoApi {
		CryptoApi(api: privmx.NativeCryptoApiWrapper.create())
	}
	
	init(
		api: privmx.NativeCryptoApiWrapper
	){
		self.api = api
	}
	
	/// Signs the given data using the specified private key.
	///
	/// This method takes raw binary data and a WIF (Wallet Import Format) private key to generate a cryptographic signature. The resulting signature can be used to verify the authenticity and integrity of the signed data.
	///
	/// - Parameters:
	///   - data: The binary data to be signed, typically a message or a file.
	///   - privateKey: The WIF private key used to sign the data.
	///
	/// - Returns: The cryptographic signature as a binary buffer (`privmx.endpoint.core.Buffer`).
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedSigning` if the signing process fails due to an invalid key or data error.
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
	/// - Parameter data: buffer containing the data signature of which is being verified.
	/// - Parameter signature: signature to be verified.
	/// - Parameter publicKey: public ECC key in BASE58DER format used to validate data.
	/// - Returns: data validation result.
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
	
	/// Generates a new symmetric key (AES-256) for encryption and decryption.
	///
	/// Symmetric encryption uses the same key for both encryption and decryption, and AES-256 is a widely adopted standard for secure encryption. This method generates a 256-bit key which can be used for encrypting sensitive data.
	///
	/// **Use case:** This is typically used when you need to secure data in transit or at rest. The same key will be required to decrypt the data that was encrypted with it.
	///
	/// - Returns: A 256-bit symmetric key as a binary buffer (`privmx.endpoint.core.Buffer`).
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedGeneratingSymmetricKey` if there is an issue generating the key, for instance due to insufficient entropy or a system-level error.
	///
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
	
	/// Generates a new private key in WIF (Wallet Import Format).
	///
	/// The private key can be used for various cryptographic operations such as signing data, generating public keys, and encrypting sensitive information. You can optionally provide a seed to generate a deterministic key, or omit the seed to generate a random key. Here it can be used for identifying and authorizing User (after previous adding its Public Key to PrivMX Bridge)
	///
	/// **Use case:** Private keys are used in both asymmetric encryption and signing operations. This method is useful when you need a fresh key pair for a new user or system process.
	///
	/// - Parameter randomSeed: An optional seed to generate a deterministic private key. If `nil` is provided, a random key will be generated.
	///
	/// - Returns: The generated private key in WIF format.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedGeneratingPrivKey` if the key generation fails, potentially due to a system error or invalid seed.
	///
	/// **Security Note:** Private keys should be stored securely, ideally in an encrypted keystore or hardware security module (HSM).
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
	
	/// Derives a private key from a given password and salt using a key derivation function.
	///
	/// This method generates a private key based on a user-provided password and salt. The combination of the two ensures that the key is unique for each user and is always generated deterministically, and the salt prevents dictionary attacks.
	///
	/// **Use case:** Useful in scenarios where users are authenticated via passwords, but cryptographic operations require a private key. By deriving the key from a password, you avoid directly storing or transferring the private key.
	///
	/// - Parameters:
	///   - password: The base string (usually a user password) used for deriving the key.
	///   - salt: The salt value that makes the derived key unique, even if the same password is used by multiple users.
	///
	/// - Returns: The derived private key in WIF format.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedGeneratingPrivKey` if the key derivation fails, such as when using invalid input or a weak password.
	///
	/// **Security Note:** Passwords should never be stored or transmitted in plain text. Ensure that the salt is unique and sufficiently random to prevent predictable key generation.
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
	/// Derives a private key from a given password and salt using a key derivation function.
	///
	/// This method generates a private key based on a user-provided password and salt. The combination of the two ensures that the key is unique for each user and is always generated deterministically, and the salt prevents dictionary attacks.
	///
	/// **Use case:** Useful in scenarios where users are authenticated via passwords, but cryptographic operations require a private key. By deriving the key from a password, you avoid directly storing or transferring the private key.
	///
	/// - Parameters:
	///   - password: The base string (usually a user password) used for deriving the key.
	///   - salt: The salt value that makes the derived key unique, even if the same password is used by multiple users.
	///
	/// - Returns: The derived private key in WIF format.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedGeneratingPrivKey` if the key derivation fails, such as when using invalid input or a weak password.
	///
	/// **Security Note:** Passwords should never be stored or transmitted in plain text. Ensure that the salt is unique and sufficiently random to prevent predictable key generation.
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
	
	/// Derives a public key from the given private key.
	///
	/// In public-key cryptography, a public key is derived from a private key and can be shared publicly to allow others to verify signatures or encrypt messages for the private key holder. The private key remains secret.
	///
	/// **Use case:** This function is used to generate a public key for a user or system after they have generated or provided a private key. Public keys have to be registered in PrivMX Bridge for encryption or verification. This should be done via Bridge REST API.
	///
	/// - Parameter privKey: The WIF private key from which the public key will be derived.
	///
	/// - Returns: The derived public key in WIF format.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedGeneratingPubKey` if the derivation process fails, such as if the private key is invalid.
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
	
	
	/// Encrypts the given data using AES-256 symmetric encryption.
	///
	/// This method encrypts the data using the provided symmetric key. Symmetric encryption is fast and suitable for large data volumes, such as files or communication payloads.
	///
	/// **Use case:** This function is used to securely store or transmit data, ensuring that only those with the correct key can decrypt and access the original content.
	///
	/// - Parameters:
	///   - data: The data to be encrypted.
	///   - symmetricKey: The 256-bit key used for encryption (must be the same key used for decryption).
	///
	/// - Returns: The encrypted data as a binary buffer.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedEncrypting` if the encryption process fails, typically due to an invalid key or data format.
	///
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
	
	
	/// Decrypts the given data using AES-256 symmetric encryption.
	///
	/// This method decrypts data that was previously encrypted using the same symmetric key. If the correct key is not provided, the decryption will fail, resulting in corrupted or unreadable data.
	///
	/// **Use case:** Decryption is used to retrieve the original content that was securely encrypted, ensuring the data’s confidentiality and integrity.
	///
	/// - Parameters:
	///   - data: The encrypted data to be decrypted.
	///   - symmetricKey: The 256-bit key that was used for encryption (must match the key used during encryption).
	///
	/// - Returns: The decrypted data as a binary buffer.
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
	
	
	/// Converts a PEM-formatted key to WIF (Wallet Import Format).
	///
	/// This function converts keys that are in the PEM format, commonly used in SSL certificates and other cryptographic contexts, to WIF format, which is more commonly used in wallet and blockchain-based systems.
	///
	/// **Use case:** Useful when migrating keys from a PEM-based system to a WIF-compatible system, such as moving from an SSL-based infrastructure to a blockchain-based system.
	///
	/// - Parameter pemKey: The key in PEM format to be converted.
	///
	/// - Returns: The converted key in WIF format.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedConvertingKeyToWIF` if the conversion fails due to an invalid key or format.
	///
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
	/// - Parameters mnemonic: the BIP-39 entropy used to generate the Key
	/// - Parameters mnemonic: the password used to generate the Key
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
	/// - Parameters entropy: the BIP-39 entropy used to generate the Key
	/// - Parameters password: the password used to generate the Key
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
