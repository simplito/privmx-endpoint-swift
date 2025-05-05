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

public class ExtKey{
	internal var wrapped: privmx.endpoint.crypto.ExtKey
	
	init(
		wrapped: privmx.endpoint.crypto.ExtKey
	) {
		self.wrapped = wrapped
	}
	
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
