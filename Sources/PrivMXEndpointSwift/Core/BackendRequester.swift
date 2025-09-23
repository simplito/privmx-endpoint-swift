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
import PrivMXEndpointSwiftNative

/// 'BackendRequester' provides functions to call PrivMX Bridge API.
public enum BackendRequester{
	
	/// Makes a direct request to PrivMX Bridge.
	///
	/// - Parameter serverUrl: PrivMX Bridge server URL
	/// - Parameter accessToken: token for authorization (see PrivMX Bridge API for more details)
	/// - Parameter method: API method to call
	/// - Parameter paramsAsJson: API method's parameters in JSON format
	///
	/// - Throws: `PrivMXEndpointError.failedRequestingBackend` if the request to the backend fails due to any error from the bridge or incorrect request formatting. And any other unexpected errors that might occur during the execution of the request.
	///
	/// - Returns: JSON string representing raw server response
	public static func backendRequest(
		serverUrl: std.string,
		accessToken: std.string,
		method: std.string,
		paramsAsJson: std.string
	) throws -> std.string {
		let res = privmx.NativeBackendRequesterWrapper.backendRequest(serverUrl,
																	  accessToken,
																	  method,
																	  paramsAsJson)
		guard res.error.value == nil else{
			throw PrivMXEndpointError.failedRequestingBackend(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedRequestingBackend(err)
		}
		return result
	}
	
	/// Sends request to PrivMX Bridge API.
	///
	/// - Parameter serverUrl: PrivMX Bridge server URL
	/// - Parameter method: API method to call
	/// - Parameter paramsAsJson: API method's parameters in JSON format
	///
	/// - Throws: `PrivMXEndpointError.failedRequestingBackend` if the request to the backend fails due to any error from the bridge or incorrect request formatting. And any other unexpected errors that might occur during the execution of the request.
	///
	/// - Returns: JSON string representing raw server response
	public static func backendRequest(
		serverUrl: std.string,
		method: std.string,
		paramsAsJson: std.string
	) throws -> std.string {
		let res = privmx.NativeBackendRequesterWrapper.backendRequest(serverUrl,
																	  method,
																	  paramsAsJson)
		guard res.error.value == nil else{
			throw PrivMXEndpointError.failedRequestingBackend(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedRequestingBackend(err)
		}
		return result
	}
	
	
	/// Sends a request to PrivMX Bridge API using pair of API KEY ID and API KEY SECRET for authorization.
	///
	/// - Parameter serverUrl: PrivMX Bridge server URL
	/// - Parameter apiKeyId: API KEY ID (see PrivMX Bridge API for more details)
	/// - Parameter apiKeySecret: API KEY SECRET (see PrivMX Bridge API for more details)
	/// - Parameter mode: allows you to set whether the request should be signed (mode = 1) or plain (mode = 0)
	/// - Parameter method: API method to call
	/// - Parameter paramsAsJson: API method's parameters in JSON format
	///
	/// - Returns: A string containing the response from PrivMX Bridge, typically in JSON format.
	public static func backendRequest(
		serverUrl: std.string,
		apiKeyId: std.string,
		apiKeySecret: std.string,
		mode: Int64,
		method: std.string,
		paramsAsJson: std.string
	) throws -> std.string {
		let res = privmx.NativeBackendRequesterWrapper.backendRequest(serverUrl,
																	  apiKeyId,
																	  apiKeySecret,
																	  mode,
																	  method,
																	  paramsAsJson)
		guard res.error.value == nil else{
			throw PrivMXEndpointError.failedRequestingBackend(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedRequestingBackend(err)
		}
		return result
	}
}
