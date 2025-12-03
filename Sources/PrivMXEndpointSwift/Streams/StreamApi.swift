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

#if Streams
import PrivMXEndpointSwiftNative
import PrivMXEndpointStreamsLow
import Foundation
import WebRTC

public class StreamApi: @unchecked Sendable{
	// MARK: Fields
	private var api: privmx.NativeStreamApiLowWrapper
	private var rtcClient: WebRTCClient
	
	private var streams = [privmx.endpoint.stream.StreamHandle:privmx.endpoint.stream.Stream]()
	private var streamTracks = [String:StreamTrackInfo]()
	private var dataChannels = [String:RTCDataChannel]()
	
	required init(
		api: privmx.NativeStreamApiLowWrapper,
		rtcClient: WebRTCClient
	) {
		self.api = api
		self.rtcClient = rtcClient
		
		self.rtcClient.bindTrickleImpl(){ sessionId, candidate in
			self.api.trickle(sessionId, std.string(candidate))}
		self.rtcClient.bindCreatePeerConnectionImpl()
	}
	
	/// Creates the API instance
	static func create(
		connection: Connection,
		eventApi: inout EventApi
	) async throws -> StreamApi{
		let low = privmx.NativeStreamApiLowWrapper.create(connection.api, &eventApi.api)
		guard var api = low.result.value
		else {
			throw PrivMXEndpointError.otherFailure(privmx.InternalError())
		}
		
		return Self(
			api: api,
			rtcClient: WebRTCClient()
			)
	}
	
// MARK: - Rooms
	
	/// Creates a StreamRoom on the Bridge
	/// - Returns: StreamRoomId
	public func createStreamRoom(
		in contextId: String,
		for users: [privmx.endpoint.core.UserWithPubKey],
		managedBy managers:[privmx.endpoint.core.UserWithPubKey],
		withPublicMeta publicMeta: Data,
		privateMeta: Data,
		policies:privmx.endpoint.core.ContainerPolicy?
	) throws -> String{
		var uv = privmx.UserWithPubKeyVector()
		uv.reserve(users.count)
		for u in users{
			uv.push_back(u)
		}
		
		var mv = privmx.UserWithPubKeyVector()
		mv.reserve(managers.count)
		for m in managers{
			mv.push_back(m)
		}
		var op = privmx.OptionalContainerPolicy()
		if let policies{
			op = privmx.makeOptional(policies)
		}
		let res = api.createStreamRoom(
			std.string(contextId),
			uv,
			mv,
			publicMeta.asBuffer(),
			privateMeta.asBuffer(),
			op)
		guard res.error.value == nil
		else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let result = res.result.value
		else{
			throw PrivMXEndpointError.otherFailure(privmx.InternalError())
		}
		
		return String(result)
	}
	
	
	public func updateStreamRoom(
		_ streamRoomId: String,
		replacingUsers users: [privmx.endpoint.core.UserWithPubKey],
		managers: [privmx.endpoint.core.UserWithPubKey],
		publicMeta:Data,
		privateMeta: Data,
		atVersion version: Int64,
		force: Bool,
		forceGenerateNewKey: Bool,
		replacePolicies policies: privmx.endpoint.core.ContainerPolicy?
	) throws -> Void {
		
		var uv = privmx.UserWithPubKeyVector()
		uv.reserve(users.count)
		for u in users{
			uv.push_back(consuming: u)
		}
		
		var mv = privmx.UserWithPubKeyVector()
		mv.reserve(managers.count)
		for m in managers{
			mv.push_back(consuming: m)
		}
		var op = privmx.OptionalContainerPolicy()
		if let policies{
			op = privmx.makeOptional(policies)
		}
		
		let res = api.updateStreamRoom(
			std.string(streamRoomId),
			uv,
			mv,
			publicMeta.asBuffer(),
			privateMeta.asBuffer(),
			version,
			force,
			forceGenerateNewKey,
			op)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func listStreamRooms(
		from contextId: String,
		basedOn query: privmx.endpoint.core.PagingQuery
	) throws -> privmx.StreamRoomList {
		let res = api.listStreamRooms(
			std.string(contextId),
			query)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		return result
	}
	
	/// Gets a single StreamRoom by it's ID
	public func getStreamRoom(
		_ streamRoomId: String
	) throws -> privmx.endpoint.stream.StreamRoom {
		let res = api.getStreamRoom(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		return result
	}
	
	public func deleteStreamRoom(
		_ streamRoomId: String
	) throws -> Void {
		let res = api.deleteStreamRoom(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
// MARK: - STREAMS
	public func createStreamIn(
		_ streamRoomId: String
	) throws -> privmx.endpoint.stream.StreamHandle {
		let res = api.createStream(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		
		self.streams[result] = privmx.endpoint.stream.Stream(
			streamId: result,
			userId: "self")
		
		return result
	}
	
	public func listDevices(
	) throws -> [RTCIODevice] {
		RTCAudioDeviceModule().inputDevices
		
	}
	public func addTrack(
		_ track: privmx.endpoint.stream.MediaDevice,
		to streamId:Int64
	) throws -> Void{
		
	}
	
	public func removeTrack(
		_ track:privmx.endpoint.stream.MediaDevice,
		from streamId: Int64
	) throws -> Void{
	}
		
	
	public func publishStream(
		localStreamId: Int64
	) throws -> Void {
		let res = api.publishStream(localStreamId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func openStream(
		streamId: Int64,
		_ streamRoomId: String,
		settings: privmx.endpoint.stream.StreamSettings,
		localStreamId: Int64
	) throws -> Int64 {
		return 1
	}
	
		public func subscribeToRemoteStreams(
		in streamRoomId: String,
		subscriptions: [privmx.endpoint.stream.StreamSubscription],
		options: privmx.endpoint.stream.Settings
	) throws -> Void {
		
		var siv = privmx.StreamSubscriptiopnsVector()
		siv.reserve(subscriptions.count)
		for i in subscriptions{
			siv.push_back(i)
		}
		let res = api.subscribeToRemoteStreams(std.string(streamRoomId),
											   siv,
											   options)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func listStreams(
		in streamRoomId: String
	) throws -> privmx.StreamInfoVector {
		let res = api.listStreams(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		return result
	}
	
	public func unpublishStream(
		localStreamId: Int64
	) throws -> Void {
		let res = api.unpublishStream(localStreamId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func unsubscribeFromRemoteStreams(
		_ subscriptionsToRemove: [privmx.endpoint.stream.StreamSubscription],
		in streamRoomId:String
	) throws -> Void {
		var siv = privmx.StreamSubscriptiopnsVector()
		siv.reserve(subscriptionsToRemove.count)
		for i in subscriptionsToRemove{
			siv.push_back(i)
		}
		let res = api.unsubscribeFromRemoteStreams(std.string(streamRoomId), siv)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	func keyManagement(
		_ disable: Bool
	) throws -> Void{
	
	}
	
	public func dropBrokenFrames(
		in roomId:Bool,
		_ enable: Bool
	) throws -> Void{
		
	}

	//public func reconfigureStream(
	//	localStreamId: Int64,
	//	optionsJSON : String = "{}"
	//) throws -> Void{}
	
	// MARK: EVENTS
	
	/// Subscribe for the Store events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries
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
	
	/// Generate subscription Query for the Store events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter selectorType: scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQuery(
	eventType: privmx.endpoint.stream.EventType,
	selectorType: privmx.endpoint.stream.EventSelectorType,
	selectorId: String
	) throws -> privmx.SubscriptionQuery {
		let res = api.buildSubscriptionQuery(eventType, selectorType, std.string(selectorId))
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


public extension EventHandler{

	static func isStreamRoomCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	static func extractStreamRoomCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomCreatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomCreatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	static func isStreamRoomUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	static func extractStreamRoomUpdatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomUpdatedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	static func isStreamRoomDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	static func extractStreamRoomDeletedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomDeletedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomDeletedEvent(eventHolder)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
}

#endif // Streams
