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
	
	
	public func emitEvent(
		contextId: std.string,
		channelName: std.string,
		eventData: privmx.endpoint.core.Buffer,
		users: privmx.UserWithPubKeyVector
	) throws -> Void {
		let res = api.emitEvent(
			contextId,
			channelName,
			eventData,
			users)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedEmittingCustomEvent(res.error.value!)
		}
	}
	
	
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
