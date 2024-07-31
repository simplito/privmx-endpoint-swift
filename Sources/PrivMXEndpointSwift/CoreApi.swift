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

/// Swift wrapper for privmx.NativeCoreApiWrapper
public class CoreApi{
	
	/// Sets path to .pem file with certificates.
	///
	/// - Parameter path: Path to the .pem file
	///
	/// - Throws: `PrivMXEndpointError.failedSettingCerts` if an exception was thrown in C++ code, or another error occurred.
	public static func setCertsPath(
		_ path: std.string
	) throws -> Void {
		let res = privmx.NativeCoreApiWrapper.setCertsPath(path)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedSettingCerts(msg: String(res.error))
		}
	}
	
	/// An instance of the wrapped C++ class.
	internal var api: privmx.NativeCoreApiWrapper
	
	/// Creates a new CoreApi instance.
	///
	/// Needs the path to certificates to be set beforehand.
	///
	/// - Parameter userPrivKey:  WIF Private Key of the user.
	/// - Parameter solutionId: ID of the Solution
	/// - Parameter platformUrl: URL of the Platform's endpoint
	///
	/// - Throws: `PrivMXEndpointError.failedConnecting` if an exception was thrown in C++ code, or another error occurred.
	public init(
		userPrivKey: std.string,
		solutionId: std.string,
		platformUrl: std.string
	) throws {
		let res = privmx.NativeCoreApiWrapper.platformConnect(
			userPrivKey,
			solutionId,
			platformUrl
		)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedConnecting(msg: String(res.error))
		}
		self.api = res.result.pointee.pointee
	}
	
	/// Subscribes to a data channel to listen for events
	///
	/// The available channels are:
	///
	/// "thread2" for events regarding threads;
	///
	/// "store" for events regarding stores;
	///
	/// "thread2/[threadId]/messages" for events regarding messages in a particular thread;
	///
	/// "store/[storeId]/files" for files in a particular store.
	///
	/// - Parameter channel: Which events should start arriving
	///
	/// - Throws: `PrivMXEndpointError.failedSubscribingToChannel` if an exception was thrown in C++ code, or another error occurred.
	public func subscribeToChannel(
		_ channel: std.string
	) throws -> Void {
		
		let res = api.subscribeToChannel(channel)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedSubscribingToChannel(msg: String(res.error))
		}
	}
	
	/// Ceases listening for events from the specified channel
	///
	/// The available channels are:
	///
	/// "thread2" for events regarding threads;
	///
	/// "store" for events regarding stores;
	///
	/// "thread2/[threadId]/messages" for events regarding messages in a particular thread;
	///
	/// "store/[storeId]/files" for files in a particular store.
	///
	/// - Parameter channel: Which events should start arriving
	///
	/// - Throws: `PrivMXEndpointError.failedUnsubscribingFromChannel` if an exception was thrown in C++ code, or another error occurred.
	public func unsubscribeFromChannel(
		_ channel: std.string
	) throws -> Void {
		
		let res = api.unsubscribeFromChannel(channel)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedUnsubscribingFromChannel(msg: String(res.error))
		}
	}
	
	/// Waits for next event.
	///
	/// This function will wait untill a new event arrives. However, should there be unprocesed Events, it will return first one of those.
	/// The returned object should be first queried with the `is*Event` methods, and extracted with an appropriate method thereafter.
	///
	/// - Parameter channel: Which events should start arriving
	///
	/// - Returns: An object holding an event, that needs to be extracted
	///
	/// - Throws: `PrivMXEndpointError.failedWaitingForEvent` if an exception was thrown in C++ code, or another error occurred.
	public func waitEvent(
	) throws -> privmx.endpoint.core.EventHolder{
		let res = api.waitEvent()
		guard res.error == "" else {
			throw PrivMXEndpointError.failedWaitingForEvent(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedWaitingForEvent(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Attempts to retrieve an event.
	///
	/// This function, unlike`waitEvent()`, attempts to retrieve first unprocessed event. Should there be no such events, it will simply return `nil`.
	/// The returned object should be first queried with the `is*Event` methods, and extracted with an appropriate method thereafter.
	///
	/// - Parameter channel: Which events should start arriving
	///
	/// - Returns: An object holding an event, that needs to be extracted, or Nil, if there were no events to get.
	///
	/// - Throws: `PrivMXEndpointError.failedUnsubscribingFromChannel` if an exception was thrown in C++ code, or another error occurred.
	public func getEvent(
	) throws -> privmx.endpoint.core.EventHolder?{
		let res = api.getEvent()
		guard res.error == "" else {
			throw PrivMXEndpointError.failedGettingEvent(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedGettingEvent(msg: "Unexpectedly received nil result")
		}
		return result.value
	}
	
	/// Severs the connection to PrivMX Platform.
	///
	/// Calling this function makes the CoreApi instance on which it was called, as well as any instances of StoreApi and ThreadApi created using it, completely useless.
	///
	/// - Parameter channel: Which events should start arriving
	///
	/// - Returns: An object holding an event, that needs to be extracted
	///
	/// - Throws: `PrivMXEndpointError.failedDisconnecting` if an exception was thrown in C++ code, or another error occurred.
	public func disconnect(
	) throws -> Void {
		let res = api.disconnect()
		guard res.error == "" else {
			throw PrivMXEndpointError.failedDisconnecting(msg: String(res.error))
		}
	}
	
	/// Lists contexts to which the connected user has access.
	///
	/// - Parameter query: Object holding parameters of the query
	///
	/// - Returns: Structure containing the total amount of Contexts and a vector of retrieved Contexts.
	///
	/// - Throws: `PrivMXEndpointError.failedListingContexts` if an exception was thrown in C++ code, or another error occurred.
	public func listContexts(
		query: privmx.endpoint.core.ListQuery
	)throws -> privmx.endpoint.core.ContextsList{
		let res = api.contextList(query)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedListingContexts(msg: String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedListingContexts(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.core.LibConnectedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of LibConnectedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isLibConnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeCoreApiWrapper.isLibConnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.core.LibDisconnectedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of LibDisconnectedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isLibDisconnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeCoreApiWrapper.isLibDisconnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Checks if the EventHolder contains a `privmx.endpoint.core.LibPlatformDisconnectedEvent`
	///
	/// - Parameter holder: EventHolder to be queried.
	///
	/// - Returns: `true` if the contained event is an instance of LibPlatformDisconnectedEvent, `false` otherwise.
	///
	/// - Throws: `PrivMXEndpointError.failedQueryingEventHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func isLibPlatformDisconnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.NativeCoreApiWrapper.isLibPlatformDisconnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedQueryingEventHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.core.LibConnectedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.core.LibConnectedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractLibConnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibConnectedEvent {
		let res = privmx.NativeCoreApiWrapper.extractLibConnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.core.LibDisconnectedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.core.LibDisconnectedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractLibDisconnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibDisconnectedEvent {
		let res = privmx.NativeCoreApiWrapper.extractLibDisconnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
	
	/// Extracts a `privmx.endpoint.core.LibPlatformDisconnectedEvent` from the provided EventHolder
	///
	/// - Parameter holder: EventHolder containing a `privmx.endpoint.core.LibPlatformDisconnectedEvent`
	///
	/// - Returns: Extracted event.
	///
	/// - Throws: `PrivMXEndpointError.failedExtractingEventFromHolder` if an exception was thrown in C++ code, or another error occurred.
	public static func extractLibPlatformDisconnectedEvent(
		holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.core.LibPlatformDisconnectedEvent {
		let res = privmx.NativeCoreApiWrapper.extractLibPlatformDisconnectedEvent(holder)
		guard res.error == "" else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg:String(res.error))
		}
		guard let result = res.result.value else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(msg: "Unexpectedly received nil result")
		}
		return result
	}
}
