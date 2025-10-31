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

import PrivMXEndpointSwift
import PrivMXEndpointSwiftNative
import Foundation
import WebRTC
import PrivMXEndpointStreamsLow

public actor StreamApi: @unchecked Sendable{
/*
	private var api: privmx.NativeStreamApiLowWrapper
	private var webRtcInstance: privmx.WebRtcInterfaceInstance
	private var peerConnectionFactory: RTCPeerConnectionFactory
	
	private var notificationListenerId : Int
	private var connectedListenerId : Int
	private var disconnectedListenerId : Int
	
	private var isStreamOnline: Bool = false
	
	private var frameCryptorOptions: Bool
	private var configuration: WebRTC.RTCConfiguration
	private var constraints: WebRTC.RTCMediaConstraints

	package init(
		api: privmx.NativeStreamApiLowWrapper,
		webRtcInstance: privmx.WebRtcInterfaceInstance,
		peerConnectionFactory: RTCPeerConnectionFactory,
		notificationListenerId: Int,
		connectedListenerId: Int,
		disconnectedListenerId: Int,
		isStreamOnline: Bool,
		frameCryptorOptions: Bool,
		configuration: WebRTC.RTCConfiguration,
		constraints: WebRTC.RTCMediaConstraints
	) {
		//self.api = api
		self.webRtcInstance = webRtcInstance
		self.peerConnectionFactory = peerConnectionFactory
		self.notificationListenerId = notificationListenerId
		self.connectedListenerId = connectedListenerId
		self.disconnectedListenerId = disconnectedListenerId
		self.isStreamOnline = isStreamOnline
		self.frameCryptorOptions = frameCryptorOptions
		self.configuration = configuration
		self.constraints = constraints
	}
	
	 static func create(
		connection: Connection,
		eventApi: inout EventApi
	) throws -> StreamApi{
		//let res = privmx.NativeStreamApiLowWrapper.create(connection.api, &eventApi.api)
		let peerConnectionFactory = RTCPeerConnectionFactory()
		//guard var api = res.result.value else {throw PrivMXEndpointError.otherFailure(privmx.InternalError())}
		let creds = api.getTurnCredentials()
		RTCInitializeSSL()
	}
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
			uv.push_back(consuming: u)
		}
		
		var mv = privmx.UserWithPubKeyVector()
		mv.reserve(managers.count)
		for m in managers{
			mv.push_back(consuming: m)
		}
		var op: privmx.OptionalContainerPolicy
		if let policies{
			op = privmx.makeOptional(policies)
		}
		let res = api.createStreamRoom(
			std.string(contextId),
			uv,
			mv,
			privmx.endpoint.core.Buffer(/*from:Data*/),
			privmx.endpoint.core.Buffer(/*from:Data*/),
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
		var op: privmx.OptionalContainerPolicy
		if let policies{
			op = privmx.makeOptional(policies)
		}
		
		let res = api.updateStreamRoom(
			std.string(streamRoomId),
			uv,
			mv,
			privmx.endpoint.core.Buffer(/*publicMeta*/),
			privmx.endpoint.core.Buffer(/*privateMeta*/),
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
	
	public func joinRoom(
		_ streamRoomId:String
	) throws -> Void{
		
	}

	public func leaveRoom(
		_ streamRoomId:String
	) throws -> Void{
		
	}
	
	
	public func deleteStreamRoom(
		_ streamRoomId: String
	) throws -> Void {
		let res = api.deleteStreamRoom(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func createStream(
		in streamRoomId: String,
		localStreamId: Int64,
		webRtc: privmx.WebRTCInterfaceReference
	) throws -> Int64 {
		let res = api.createStream(
			std.string(streamRoomId),
			localStreamId,
			webRtc)
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
	
	public func listDevices(
	) throws -> [RTCIODevice] {
		RTCAudioDeviceModule().inputDevices
		
	}
	public func addTrack(
		_ track: privmx.endpoint.stream.RemoteTrackId,
		to streamId:Int64
	) throws -> Void{
		
	}
	
	public func removeTrack(
		//_ track:Track,
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
	}
	
		public func openStreams(
		_ streamRoomId: String,
		streamsId: [Int64],
		settings: privmx.endpoint.stream.Settings,
		localStreamId: Int64
	) throws -> Int64 {
		
		//var siv = privmx.StreamIdVector()
		//siv.reserve(streamsId.count)
		//for i in siv{
		//	siv.push_back(i)
		//}
		let res = api.joinStream(
			std.string(streamRoomId),
			//siv,
			settings,
			localStreamId,
			webRtcInstance)
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
	
	
	/*public func listStreams(
		in streamRoomId: String
	) throws -> privmx.StreamVector {
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
	*/
	
	public func unpublishStream(
		localStreamId: Int64
	) throws -> Void {
		let res = api.unpublishStream(localStreamId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	
	public func leaveStream(
		localStreamId: Int64
	) throws -> Void {
		let res = api.leaveStream(localStreamId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
	}
	
	public func keyManagement(
		_ disable: Bool
	) throws -> Void{
	
	}
	
	public func dropBrokenFrames(
		_ enable: Bool
	) throws -> Void{
	
	}

	public func reconfigureStream(
		localStreamId: Int64,
		optionsJSON : String = "{}"
	) throws -> Void{
		
	}
	
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
		let res = api.buildSubscriptionQuery(eventType, selectorType, selectorId)
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

	
	private func trackAddAudio(
	streamId: Int64,
	id: Int64 = 0,
	params_JSON: String = "{}"
	) throws -> Void {}
	
	private func trackAddVideo(
	streamId: Int64,
	id: Int64 = 0,
	params_JSON: String = "{}"
	) throws -> Void {}
	
	private func trackAddDesktop(
	streamId: Int64,
	id: Int64 = 0,
	params_JSON: String = "{}"
	) throws -> Void {}
	
	private func trackRemoveAudio(
	streamId: Int64,
	id: Int64 = 0
	) throws -> Void {}
	
	private func trackRemoveVideo(
	streamId: Int64,
	id: Int64 = 0
	) throws -> Void {}
	
	private func trackRemoveDesktop(
	streamId: Int64,
	id: Int64 = 0
	) throws -> Void {}
}

public extension EventHandler{
	
	
	static func isStreamRoomCreatedEvent(
		eventHolder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		//let res = privmx.StreamApiLowEventHandler.()
		//guard res.error.value == nil else {
		//	throw PrivMXEndpointError.failedQueryingEventHolder(res.error.value!)
		//}
		//guard let result = res.result.value else {
		//	var err = privmx.InternalError()
		//	err.name = "Value error"
		//	err.description = "Unexpectedly recived nil result"
		//	throw PrivMXEndpointError.failedQueryingEventHolder(err)
		//}
		return false//result
	}
 */
}
