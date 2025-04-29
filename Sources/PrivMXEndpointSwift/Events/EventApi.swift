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

public class EventApi{
	internal var api : privmx.NativeEventApiWrapper
	
	private init(
		api: privmx.NativeEventApiWrapper
	) {
		self.api = api
	}
	
	/// Creates a new instance of `EventApi` from a `Connection` object.
	///
	/// This method initializes the `EventApi` instance, enabling CustomEvent-related operations over the specified connection.
	///
	/// - Parameter connection: The connection object to be used for interacting with Custom Events.
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingEventApi` if an error occurs during the initialization.
	///
	/// - Returns: A newly created `EventApi` instance.
	public static func create(
		connection: inout Connection
	) throws -> EventApi {
		let res = privmx.NativeEventApiWrapper.create(
			&connection.api)
		
		guard nil == res.error.value
		else {
			throw PrivMXEndpointError.FailedInstantiatingEventApi(res.error.value!)
		}
		guard let result = res.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.FailedInstantiatingEventApi(err)
		}
		return EventApi(api: result)
	}
	
	
	/// Emits the custom event on the given Context and channel.
	///
	/// - Parameter contextId: ID of the Context
	/// - Parameter channelName: list of UserWithPubKey objects which defines the recipeints of the event
	/// - Parameter eventData: name of the Channel
	/// - Parameter users: event's data
	///
	/// - Throws: `PrivMXEndpointError.failedEmittingCustomEvent` if listing the messages fails.
	///
	public func emitEvent(
		contextId: std.string,
		users: privmx.UserWithPubKeyVector,
		channelName: std.string,
		eventData: privmx.endpoint.core.Buffer,
	) throws -> Void {
		let res = api.emitEvent(
			contextId,
			users,
			channelName,
			eventData)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedEmittingCustomEvent(res.error.value!)
		}
	}
	
	/// Subscribe for the custom events on the given channel.
	///
	/// - Parameter contextId: ID of the Context
	/// - Parameter channelName: name of the Channel
	///
	/// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to custom events fails.
	public func subscribeForCustomEvents(
		contextId: std.string,
		channelName:std.string
	) throws -> Void {
		let res = api.subscribeForCustomEvents(contextId,
											   channelName)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedSubscribingForCustomEvents(res.error.value!)
		}
	}
	
	/// Unsubscribe from the custom events on the given channel.
	///
	/// - Parameter contextId: ID of the Context
	/// - Parameter channelName: name of the Channel
	///
	/// - Throws: `PrivMXEndpointError.failedSubscribingForEvents` if subscribing to message events fails.
	public func unsubscribeFromCustomEvents(
		contextId: std.string,
		channelName: std.string
	) throws -> Void {
		let res = api.unsubscribeFromCustomEvents(contextId,
												  channelName)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedUnsubscribingFromCustomEvents(res.error.value!)
		}
		
	}
}
