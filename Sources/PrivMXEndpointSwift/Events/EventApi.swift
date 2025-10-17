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

/// 'EventApi' is a class representing Endpoint's API for context custom events.
public class EventApi{
	package var api : privmx.NativeEventApiWrapper
	
	private init(
		api: privmx.NativeEventApiWrapper
	) {
		self.api = api
	}
	
	/// Creates an instance of 'EventApi'.
	///
	/// - Parameter connection: instance of 'Connection'
	///
	/// - Throws: `PrivMXEndpointError.failedInstantiatingEventApi` if an error occurs during the initialization.
	///
	/// - Returns: `EventApi` object
	public static func create(
		connection: inout Connection
	) throws -> EventApi {
		let res = privmx.NativeEventApiWrapper.create(
			&connection.api)
		
		guard nil == res.error.value
		else {
			throw PrivMXEndpointError.failedInstantiatingEventApi(res.error.value!)
		}
		guard let result = res.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.failedInstantiatingEventApi(err)
		}
		return EventApi(api: result)
	}
	
	
	/// Emits the custom event on the given Context and channel.
	///
	/// - Parameter contextId: ID of the Context
	/// - Parameter channelName: list of UserWithPubKey objects which defines the recipients of the event
	/// - Parameter eventData: name of the Channel
	/// - Parameter users: event's data
	///
	/// - Throws: `PrivMXEndpointError.failedEmittingCustomEvent` if listing the messages fails.
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
			throw PrivMXEndpointError.failedEmittingCustomEvent(res.error.value!)
		}
	}
	
	
	/// Subscribe for the custom events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries.
	public func subscribeFor(
		subscriptionQueries: privmx.SubscriptionQueryVector
	) throws -> privmx.SubscriptionIdVector {
		let res = api.subscribeFor(subscriptionQueries)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedSubscribingForEvents(err)
		}
		return result
	}
	
	/// Unsubscribe from events for the given subscriptionId.
	///
	/// - Parameter subscriptionIds: list of subscriptionId
	///
	/// - Throws: When unsubscribing fails.
	public func unsubscribeFrom(
		subscriptionIds: privmx.SubscriptionIdVector
	) throws -> Void {
		let res = api.unsubscribeFrom(subscriptionIds)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Generate subscription Query for the Custom events.
	///
	/// - Parameter channelName: name of the Channel
	/// - Parameter selectorType: selector of scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	public func buildSubscriptionQuery(
		channelName: std.string,
		selectorType: privmx.endpoint.event.EventSelectorType,
		selectorId: std.string
	) throws -> privmx.SubscriptionQuery {
		let res = api.buildSubscriptionQuery(channelName, selectorType, selectorId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(err)
		}
		return result
	}
}
