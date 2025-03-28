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

/// Swift wrapper for `privmx.NativeConnectionWrapper`, used to establish and manage secure connections with PrivMX platform.
public class Connection{
	
	/// Sets the path to the .pem file containing the necessary certificates for the connection, which are dependent on your PrivMX Bridge setup.
    ///
    /// This method must be called before attempting to establish a connection to ensure the certificates are properly set.
    ///
    /// - Parameter path: The path to the .pem file containing the certificates.
    ///
    /// - Throws: `PrivMXEndpointError.failedSettingCerts` if setting the certificate path fails.
   public static func setCertsPath(
		_ path: std.string
	) throws -> Void {
		let res = privmx.NativeConnectionWrapper.setCertsPath(path)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSettingCerts(res.error.value!)
		}
	}
	
	/// An instance of the wrapped C++ class.
	internal var api: privmx.NativeConnectionWrapper
	
	/// Creates a new connection instance to PrivMX platform using a private key.
	///
	/// The path to the certificates must be set beforehand using `setCertsPath()`. This connection is used to interact with secured operations such as Inboxes, Threads, and Stores.
	///
	/// - Parameter userPrivKey: The user's private key in WIF format, required for authentication.
	/// - Parameter solutionId: The ID of the Solution that the connection targets.
	/// - Parameter bridgeUrl: The URL of PrivMX platform endpoint.
	///
	/// - Throws: `PrivMXEndpointError.failedConnecting` if establishing the connection fails.
	///
	/// - Returns: A `Connection` instance that can be used for further operations.
	public static func connect(
		userPrivKey: std.string,
		solutionId: std.string,
		bridgeUrl: std.string
	) throws -> Connection{
		let res = privmx.NativeConnectionWrapper.connect(userPrivKey,
														 solutionId,
														 bridgeUrl)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConnecting(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedConnecting(err)
		}
		
		return Connection(api:result.pointee)
	}
	
	/// Creates a new connection instance to PrivMX platform using a private key.
    ///
    /// The path to the certificates must be set beforehand using `setCertsPath()`. This connection is used to interact with secured operations such as Inboxes, Threads, and Stores.
    ///
    /// - Parameter userPrivKey: The user's private key in WIF format, required for authentication.
    /// - Parameter solutionId: The ID of the Solution that the connection targets.
    /// - Parameter platformUrl: The URL of PrivMX platform endpoint.
    ///
    /// - Throws: `PrivMXEndpointError.failedConnecting` if establishing the connection fails.
    ///
    /// - Returns: A `Connection` instance that can be used for further operations.
	@available(*, deprecated, renamed: "connect(userPrivKey:solutionId:bridgeUrl:)")
	public static func connect(
		userPrivKey: std.string,
		solutionId: std.string,
		platformUrl: std.string
	) throws -> Connection{
		let res = privmx.NativeConnectionWrapper.platformConnect(userPrivKey,
																 solutionId,
																 platformUrl)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConnecting(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedConnecting(err)
		}
		
		return Connection(api:result.pointee)
	}
	
	/// Creates a new public connection to PrivMX platform.
    ///
    /// The path to the certificates must be set beforehand using `setCertsPath()`. This type of connection is primarily used for public operations, such as inbound Inbox traffic, where authentication is not required.
    ///
    /// - Parameter solutionId: The ID of the Solution that the connection targets.
    /// - Parameter bridgeUrl: The URL of PrivMX platform endpoint.
    ///
    /// - Throws: `PrivMXEndpointError.failedConnecting` if establishing the connection fails.
    ///
    /// - Returns: A public `Connection` instance that can be used for non-authenticated operations.
    public static func connectPublic(
		solutionId: std.string,
		bridgeUrl: std.string
	) throws -> Connection{
		let res = privmx.NativeConnectionWrapper.connectPublic(solutionId,
															   bridgeUrl)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConnecting(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedConnecting(err)
		}
		
		return Connection(api:result.pointee)
	}
	
	/// Creates a new public connection to PrivMX platform.
    ///
    /// The path to the certificates must be set beforehand using `setCertsPath()`. This type of connection is primarily used for public operations, such as inbound Inbox traffic, where authentication is not required.
    ///
    /// - Parameter solutionId: The ID of the Solution that the connection targets.
    /// - Parameter platformUrl: The URL of PrivMX platform endpoint.
    ///
    /// - Throws: `PrivMXEndpointError.failedConnecting` if establishing the connection fails.
    ///
    /// - Returns: A public `Connection` instance that can be used for non-authenticated operations.
	@available(*, deprecated, renamed: "connectPublic(solutionId:bridgeUrl:)")
    public static func connectPublic(
		solutionId: std.string,
		platformUrl: std.string
	) throws -> Connection{
		let res = privmx.NativeConnectionWrapper.platformConnectPublic(solutionId,
																	   platformUrl)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedConnecting(res.error.value!)
		}
		guard let result = res.result.value else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedConnecting(err)
		}
		
		return Connection(api:result.pointee)
	}
	
	/// Retrieves the unique ID of the connection.
    ///
    /// Each connection instance has a unique identifier that can be used to track and manage multiple connections.
    ///
    /// - Throws: `PrivMXEndpointError.failedGettingConnectionId` if retrieving the connection ID fails.
    ///
    /// - Returns: The unique ID of the current connection as an `Int64`.
    public func getConnectionId(
	) throws -> Int64 {
		let res = api.getConnectionId()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingConnectionId(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingContexts(err)
		}
		return result
	}
	
	private init(
		api:privmx.NativeConnectionWrapper
	){
		self.api = api
	}
	
	/// Disconnects the current connection to PrivMX platform.
    ///
    /// Once disconnected, the `Connection` instance, along with any associated API instances like `StoreApi` or `ThreadApi`, becomes unusable. It is important to call this method when the connection is no longer needed to free up resources.
    ///
    /// - Throws: `PrivMXEndpointError.failedDisconnecting` if the disconnection process fails.
    public func disconnect(
	) throws -> Void {
		let res = api.disconnect()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDisconnecting(res.error.value!)
		}
	}
	
	/// Lists all Contexts available to the currently connected user.
    ///
    /// Contexts represent different environments or groups to which the user has access. This method returns a list of these Contexts.
    ///
    /// - Parameter query: A `PagingQuery` object that specifies the filtering and pagination options for the query.
    ///
    /// - Throws: `PrivMXEndpointError.failedListingContexts` if listing the Contexts fails.
    ///
    /// - Returns: A `ContextList` structure containing the total number of Contexts and a list of the retrieved Contexts.
    public func listContexts(
		query: privmx.endpoint.core.PagingQuery
	)throws -> privmx.ContextList{
		let res = api.listContexts(query)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingContexts(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedListingContexts(err)
		}
		return result
	}
	
	/// Retrieves a list of Users from a particular Context.
	///
	/// - parameter contextId: Id of the Context.
	///
	/// - throws: When the operation fails.
	///
	/// - returns: a list of UserInfo objects.
	public func getContextUsers(
		contextId: std.string
	) throws -> privmx.UserInfoVector {
		let res = api.getContextUsers(contextId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingContextUsers(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingContextUsers(err)
		}
		return result
	}
	
	/// Sets user's custom verification callback.
	///
	/// The feature allows the developer to set up a callback for user verification.
	/// A developer can implement an interface and pass the implementation to the function.
	/// Each time data is read from the container, a callback will be triggered, allowing the developer to validate the sender in an external service,
	/// e.g. Developers Application Server or PKI Server
	///
	/// - Parameter verifier: an implementation of the `UserVerifierInterface` Cxx abstract class
	///
	/// - throws: When the operation fails.
	public func setUserVerifier(
		verifier: privmx.UserVerifier
	) throws -> Void {
		let res = api.setUserVerifier(verifier)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedSettingUserVerifier(res.error.value!)
		}
	}
}
