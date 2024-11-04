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

/// Tool for direct requests to PrivMX Bridge.
public enum BackendRequester{
	
	/// Makes a direct request to PrivMX Bridge.
    ///
    /// This function allows you to make direct API requests to PrivMX Bridge with the required authorization and parameters. The response is returned as a string, representing the result of the request.
    ///
    /// - Parameters:
    ///   - serverUrl: The URL of PrivMX cloud server to which the request will be sent.
    ///   - memberToken: The authorization token for the member making the request.
    ///   - method: The API method or endpoint to be called on PrivMX Bridge.
    ///   - paramsAsJson: The parameters for the request, formatted as a JSON string.
    ///
    /// - Throws: 
    ///   - `PrivMXEndpointError.failedRequestingBackend` if the request to the backend fails due to any error from the bridge or incorrect request formatting.
    ///   - Any other unexpected errors that might occur during the execution of the request.
    ///
    /// - Returns: 
    ///   - A string containing the response from PrivMX Bridge, typically in JSON format.
	public static func backendRequest(
		serverUrl: std.string,
		memberToken: std.string,
		method: std.string,
		paramsAsJson: std.string
	) throws -> std.string {
		let res = privmx.NativeBackendRequesterWrapper.backendRequest(serverUrl,
																	  memberToken,
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
	
	/// Makes a direct request to PrivMX Bridge.
	///
	/// This function allows you to make direct API requests to PrivMX Bridge with the required parameters. The response is returned as a string, representing the result of the request.
	///
	/// - Parameters:
	///   - serverUrl: The URL of PrivMX cloud server to which the request will be sent.
	///   - method: The API method or endpoint to be called on PrivMX Bridge.
	///   - paramsAsJson: The parameters for the request, formatted as a JSON string.
	///
	/// - Throws:
	///   - `PrivMXEndpointError.failedRequestingBackend` if the request to the backend fails due to any error from the bridge or incorrect request formatting.
	///   - Any other unexpected errors that might occur during the execution of the request.
	///
	/// - Returns:
	///   - A string containing the response from PrivMX Bridge, typically in JSON format.
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
	/// - Parameters:
	///   - serverUrl: PrivMX Bridge server URL
	///   - apiKeyId: API KEY ID (see PrivMX Bridge API for more details)
	///   - apiKeySecret: API KEY SECRET (see PrivMX Bridge API for more details)
	///   - mode: allows you to set whether the request should be signed (mode = 1) or plain (mode = 0)
	///   - method: API method to call
	///   - paramsAsJson: API method's parameters in JSON format
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
