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

/// Contains helper methods to convert between `Buffer`s and Hex-encoded `std.strings`.
public enum Hex{
	
	/// Encodes buffer to a string in Hex format.
	/// - Parameter data: buffer to encode
	/// - Returns: string in Hex fromat
	public static func encode(
		data: privmx.endpoint.core.Buffer
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_Hex_encode(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEncodingToHex(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedEncodingToHex(err)
			
		}
		return result
	}
	
	/// Decodes  string in Hex to buffer.
	/// - Parameter hex_data: string to decode
	/// - Returns: buffer with decoded data
	public static func decode(
		hex_data: std.string
	) throws -> privmx.endpoint.core.Buffer {
		let res = privmx.endpoint.wrapper._call_Hex_decode(hex_data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDecodingFromHex(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDecodingFromHex(err)
		}
		return result
	}
	
	/// Checks if given string is in Hex format.
	/// - Parameter data: string to check
	/// - Returns: check result
	public static func `is`(
		data: std.string
	) throws -> Bool {
		let res = privmx.endpoint.wrapper._call_Hex_is(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCheckingifStringIsHex(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCheckingifStringIsHex(err)
		}
		return result
	}
}

/// Contains helper methods to convert between `Buffer`s and Base32-encoded `std.strings`.
public enum Base32{
	
	/// Encodes buffer to a string in Base32 format.
	/// - Parameter data: buffer to encode
	/// - Returns: string in Hex fromat
	public static func encode(
		data: privmx.endpoint.core.Buffer
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_Base32_encode(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEncodingToBase32(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedEncodingToBase32(err)
			
		}
		return result
	}
	
	/// Decodes  string in Base32 to buffer.
	/// - Parameter base32_data: string to decode
	/// - Returns: buffer with decoded data
	public static func decode(
		base32_data: std.string
	) throws -> privmx.endpoint.core.Buffer {
		let res = privmx.endpoint.wrapper._call_Base32_decode(base32_data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDecodingFromBase32(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDecodingFromBase32(err)
		}
		return result
	}
	
	/// Checks if given string is in Base32 format.
	/// - Parameter data: string to check
	/// - Returns: check result
	public static func `is`(
		data: std.string
	) throws -> Bool {
		let res = privmx.endpoint.wrapper._call_Base32_is(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCheckingifStringIsBase32(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCheckingifStringIsBase32(err)
		}
		return result
	}
	
}
/// Contains helper methods to convert between `Buffer`s and Base64-encoded `std.strings`.
public enum Base64{
	
	/// Encodes buffer to a string in Base64 format.
	/// - Parameter data: buffer to encode
	/// - Returns: string in Hex fromat
	public static func encode(
		data: privmx.endpoint.core.Buffer
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_Base64_encode(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedEncodingToBase64(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedEncodingToBase64(err)
			
		}
		return result
	}
	
	/// Decodes  string in Base64 to buffer.
	/// - Parameter base64_data: string to decode
	/// - Returns: buffer with decoded data
	public static func decode(
		base64_data: std.string
	) throws -> privmx.endpoint.core.Buffer {
		let res = privmx.endpoint.wrapper._call_Base64_decode(base64_data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDecodingFromBase64(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDecodingFromBase64(err)
		}
		return result
	}
	
	/// Checks if given string is in Base64 format.
	/// - Parameter data: string to check
	/// - Returns: check result
	public static func `is`(
		data: std.string
	) throws -> Bool {
		let res = privmx.endpoint.wrapper._call_Base64_is(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCheckingifStringIsBase64(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCheckingifStringIsBase64(err)
		}
		return result
	}
	
}

/// Helper methods for removing extraneous whitespace from, and splitting std.strings.
public enum Utils{
	
	/// Removes all trailing whitespace.
	/// - Parameter data:
	/// - Returns: copy of the string with removed trailing whitespace.
	public static func trim(
		data: std.string
	) throws -> std.string {
		let res = privmx.endpoint.wrapper._call_Utils_trim(data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedTrimmingString(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedTrimmingString(err)
		}
		return result
	}
	
	/// Removes all whitespace from the left of given string.
	/// - Parameter data: inout string to trim
	/// - Returns: copy of the string with removed leading whitespace.
	public static func ltrim(
		data: inout std.string
	) throws -> Void {
		let res = privmx.endpoint.wrapper._call_Utils_ltrim(&data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedTrimmingString(res.error.value!)
		}
	}
	
	/// Removes all whitespace from the right of given string.
	/// - Parameter data: inout string to trim
	/// - Returns: copy of the string with removed trailing whitespace.
	public static func rtrim(
		data: inout std.string
	) throws -> Void {
		let res = privmx.endpoint.wrapper._call_Utils_rtrim(&data)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedTrimmingString(res.error.value!)
		}
	}
	
	/// Splits string by given delimiter (delimiter is removed).
	///
	/// - Parameter data: string to split
	/// - Parameter delimiter: string which will be split
	/// - Returns: vector containing all split parts
	public static func split(
		data: std.string,
		delimiter: std.string
	) throws -> privmx.StringVector {
		let res = privmx.endpoint.wrapper._call_Utils_split(data,
															delimiter)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSplittingString(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedSplittingString(err)
		}
		return result
	}
}
