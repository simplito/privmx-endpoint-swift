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
import PrivMXEndpointSwiftNative

/// `ExtKey` is a class representing Extended keys and operations on it.
///
///  This class allows for safely using the underaying `privmx.endpoint.crypto.ExtKey`
public class ExtKey{
	internal var wrapped: privmx.endpoint.crypto.ExtKey
	
	init(
		wrapped: privmx.endpoint.crypto.ExtKey
	) {
		self.wrapped = wrapped
	}

	/// Creates ExtKey from given seed.
	/// - Parameter seed: the seed used to generate Key
	/// - Returns: `ExtKey` object
	public func fromSeed(
		seed: privmx.endpoint.core.Buffer
	) throws -> ExtKey {
		let res = privmx.endpoint.wrapper._call_ExtKey_fromSeed(seed)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedInstantiatingExtKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedInstantiatingExtKey(err)
		}
		return ExtKey(wrapped:result)
	}
	
	/// Decodes ExtKey from Base58 format.
	/// - Parameter base58:the ExtKey in Base58
	/// - Returns: `ExtKey` object
	public func fromBase58(
		base58: std.string
	) throws -> ExtKey {
		let res = privmx.endpoint.wrapper._call_ExtKey_fromBase58(base58)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedInstantiatingExtKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedInstantiatingExtKey(err)
		}
		return ExtKey(wrapped:result)
	}
	
	/// Generates a new ExtKey.
	/// - Returns: `ExtKey` object
	public func generateRandom(
	) throws -> ExtKey {
		let res = privmx.endpoint.wrapper._call_ExtKey_generateRandom()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedInstantiatingExtKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedInstantiatingExtKey(err)
		}
		return ExtKey(wrapped:result)
	}
	
	/// Generates child ExtKey from a current ExtKey using BIP32.
	/// - Parameter index: number from 0 to 2^31-1
	/// - Returns: `ExtKey` object
	public func derive(
		index:UInt32
	) throws -> ExtKey {
		let res = privmx.endpoint.wrapper._call_ExtKey_derive(wrapped, index)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDerivingExtKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDerivingExtKey(err)
		}
		return ExtKey(wrapped:result)
	}

	/// Generates hardened child ExtKey from a current ExtKey using BIP32.
	/// - Parameter index: number from 0 to 2^31-1
	/// - Returns: `ExtKey` object
	public func deriveHardened(
		index:UInt32
	) throws -> ExtKey {
		let res = privmx.endpoint.wrapper._call_ExtKey_deriveHardened(wrapped, index)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDerivingExtKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDerivingExtKey(err)
		}
		return ExtKey(wrapped:result)
	}
	
	/// Converts ExtKey to Base58 string.
	/// - Returns: `ExtKey` in Base58 format
	public func getPrivatePartAsBase58(
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPrivatePartAsBase58(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPrivatePartAsBase58(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPrivatePartAsBase58(err)
		}
		return result
	}
	
	/// Converts the public part of ExtKey to Base58 string.
	/// - Returns: `ExtKey` in Base58 format
	public func getPublicPartAsBase58(
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPublicPartAsBase58(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPublicPartAsBase58(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPublicPartAsBase58(err)
		}
		return result
	}
	
	/// Extracts ECC PrivateKey.
	/// - Returns: ECC key in WIF format
	public func getPrivateKey(
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPrivateKey(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPrivateKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPrivateKey(err)
		}
		return result
	}

	/// Extracts ECC PublicKey.
	/// - Returns: ECC key in BASE58DER format
	public func getPublicKey(
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPublicKey(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPublicKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPublicKey(err)
		}
		return result
	}
	
	/// Extracts ECC PublicKey Address.
	/// - Returns: ECC Address in BASE58 format
	public func getPublicKeyAsBase58Address(
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPublicKeyAsBase58Address(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPublicKeyAsBase58Address(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPublicKeyAsBase58Address(err)
		}
		return result
	}
	
	/// Extracts raw ECC PrivateKey.
	/// - Returns: ECC PrivateKey
	public func getPrivateEncKey(
	) throws -> privmx.endpoint.core.Buffer {
		let res = privmx.endpoint.wrapper._call_ExtKey_getPrivateEncKey(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingPrivateEncKey(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingPrivateEncKey(err)
		}
		return result
	}
	
	/// Gets the chain code of Extended Key.
	/// - Returns: Raw chain code
	public func getChainCode(
	) throws -> privmx.endpoint.core.Buffer {
		let res = privmx.endpoint.wrapper._call_ExtKey_getChainCode(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingChainCode(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingChainCode(err)
		}
		return result
	}
	
	///  Validates a signature of a message.
	/// - Parameter  message: data used on validation
	/// - Parameter  signature: signature of data to verify
	/// - Returns:  message validation result
	public func verifyCompactSignatureWithHash(
		message: privmx.endpoint.core.Buffer,
		signature: privmx.endpoint.core.Buffer
	) throws -> Bool {
		let res = privmx.endpoint.wrapper._call_ExtKey_verifyCompactSignatureWithHash(wrapped,
																					  message,
																					  signature)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedVerifyingCompactSignature(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedVerifyingCompactSignature(err)
		}
		return result
	}
	
	/// Checks if ExtKey is Private.
	/// - Returns: returns true if ExtKey is private
	public func isPrivate(
	) throws -> Bool {
		let res = privmx.endpoint.wrapper._call_ExtKey_isPrivate(wrapped)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCheckingIfExtKeyIsPrivate(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCheckingIfExtKeyIsPrivate(err)
		}
		return result
	}
	
}
