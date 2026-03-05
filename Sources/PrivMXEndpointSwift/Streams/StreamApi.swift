//
// PrivMX Endpoint Swift
// Copyright © 2026 Simplito sp. z o.o.
//
// This file is part of PrivMX Platform (https://privmx.dev).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//

// #if Streams
import PrivMXEndpointSwiftNative
import Foundation
import WebRTC
#if os(macOS)
import ScreenCaptureKit
#endif
public class StreamApi: @unchecked Sendable{
	private var api: privmx.NativeStreamApiLowWrapper
	public var roomSessionManager: RoomSessionManager!
	private init(
		api: privmx.NativeStreamApiLowWrapper,
	) {
		self.api = api
	}
	private func bindRoomSessionManger(
	//	initOptions: InitOptions?
	){
		self.roomSessionManager = RoomSessionManager.create(
			onTrickle: { sessionId, candidate in
				self.api.trickle(sessionId, std.string(candidate))
			},
		//	options: initOptions
		)
	}
	
	/// Creates the API instance
	public static func create(
		connection: Connection,
		eventApi: inout EventApi,
		//initOptions: InitOptions? = nil
	) throws -> StreamApi{
		
		let low = privmx.NativeStreamApiLowWrapper.create(connection.api, &eventApi.api)
		guard var api = low.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		var sa = StreamApi(
			api: api
		)
		sa.bindRoomSessionManger(
			//initOptions: initOptions
		)
		return sa
	}
	
	// MARK: - Rooms
	
	/// Creates a StreamRoom on the Bridge
	/// - Returns: StreamRoomId
	public func createStreamRoom(
		in contextId: String,
		for users: [privmx.endpoint.core.UserWithPubKey],
		managedBy managers: [privmx.endpoint.core.UserWithPubKey],
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
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.otherFailure(err)
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
	
	public func joinStreamRoom(
		_ streamRoomId: String,
		audioTrackHandler: ((String,RTCAudioTrack) -> Void)?,
		videoTrackHandler: ((String,RTCVideoTrack) -> Void)?,
		subscriberConnectionStateChangedCallback: ((RTCPeerConnectionState)->Void)?,
		publisherConnectionStateChangedCallback: ((RTCPeerConnectionState)->Void)?
	) throws -> Void {
		try roomSessionManager.addRoomSessionFor(streamRoomId)
		guard let instance = roomSessionManager.roomSessions[streamRoomId]?.webRTCInstance
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Missing session for room",
					message: "",
					description: ""))
		}
		let res = api.joinStreamRoom(
			std.string(streamRoomId),
			instance.instance
		)
		if let err = res.error.value{
			roomSessionManager.roomSessions[streamRoomId] = nil
			throw PrivMXEndpointError.otherFailure(err)
		}
		roomSessionManager.setAudioStreamsHandler(audioTrackHandler)
		roomSessionManager.setVideoStreamsHandler(videoTrackHandler)
		roomSessionManager.roomSessions[streamRoomId]
	}
	
	public func leaveStreamRoom(
		_ roomId: String
	) throws -> Void {
		if let handle = roomSessionManager.streamHandles.first(where: {$0.value == roomId}){
			roomSessionManager.streamHandles[handle.key] = nil
		}
		
		let res = api.leaveStreamRoom(std.string(roomId))
		
		if let err = res.error.value{
			throw PrivMXEndpointError.otherFailure(err)
		}
		
		roomSessionManager.roomSessions[roomId] = nil
	}
	
	// MARK: - STREAMS
	public func createStreamIn(
		_ streamRoomId: String
	) throws -> privmx.endpoint.stream.StreamHandle {
		try roomSessionManager.roomSessions[streamRoomId]?.getOrCreatePublisher()
		let res = api.createStream(std.string(streamRoomId))
		guard res.error.value == nil else {
			throw PrivMXEndpointError.otherFailure(res.error.value!)
		}
		guard let streamHandle = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		roomSessionManager.streamHandles[streamHandle] = streamRoomId
		return streamHandle
	}
	
	public func listCameras(
	) -> [AVCaptureDevice]{
		RTCCameraVideoCapturer.captureDevices()
	}
	
	//MARK: - Tracks
	public func addTrack(
		_ track: RTCVideoTrack,
		toRoomSession roomId:String
	) throws -> Void {
		print("[pmx][dbg] local video track count",roomSessionManager.roomSessions[roomId]?.publisher?.videoTracks.count)
		try roomSessionManager.addVideoTrack(track, to: roomId)
		print("[pmx][dbg] local video track count",roomSessionManager.roomSessions[roomId]?.publisher?.videoTracks.count)
	}
	
	public func addTrack(
		_ track: RTCAudioTrack,
		toRoomSession roomId:String
	) throws -> Void {
		print("[pmx][dbg] local audio track count",roomSessionManager.roomSessions[roomId]?.publisher?.audioTracks.count)
		try roomSessionManager.addAudioTrack(track, to: roomId)
		print("[pmx][dbg] local audio track count",roomSessionManager.roomSessions[roomId]?.publisher?.audioTracks.count)
		
	}
	
	#if os(macOS)
	public func createVideoTrackAndSource(
		id: String,
		forScreenCast: Bool = false
	) -> (track:RTCVideoTrack, source: RTCVideoSource) {
		var src = roomSessionManager.peerConnectionFactory.videoSource(forScreenCast: forScreenCast)
		var trk = roomSessionManager.peerConnectionFactory.videoTrack(with: src, trackId: id)
		return (trk,src)
	}
	#else
	public func createVideoTrackAndSource(
		id: String
	) -> (track:RTCVideoTrack, source: RTCVideoSource) {
		var src = roomSessionManager.peerConnectionFactory.videoSource(forScreenCast: false)
		var trk = roomSessionManager.peerConnectionFactory.videoTrack(with: src, trackId: id)
		return (trk,src)
	}
	#endif
	
	public func createAudioTrackAndSource(
		id: String
	) -> (track:RTCAudioTrack, source: RTCAudioSource) {
		var src = roomSessionManager.peerConnectionFactory.audioSource(with: nil)
		var trk = roomSessionManager.peerConnectionFactory.audioTrack(with: src, trackId: id)
		return (trk,src)
	}
	
	@available(*,unavailable)
	public func createRawTrack(
		id: String
	) -> Void {
		
	}
	
	

	public func removeTrack(
		_ track: RTCVideoTrack,
		fromStreamWithHandle: privmx.endpoint.stream.StreamHandle//RoomID?
	) -> Bool{
		return false
	}
	public func removeTrack(
		_ track: RTCAudioTrack,
		from roomId: privmx.endpoint.stream.StreamHandle//RoomID?
	) -> Bool{
		return false
	}
	
	//MARK: -
	
	public func publishStream(
		_ streamHandle: privmx.endpoint.stream.StreamHandle
	) throws -> Void {
		
		guard let sh = roomSessionManager.streamHandles[streamHandle]
		else {
			throw PrivMXEndpointError.otherFailure(.init(
				name: "Unknown stream handle",
				message: "",
				description: "")
			)
		}
		
		guard let session = roomSessionManager.roomSessions[sh]
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create cryptor",
					message: "", description: ""
				)
			)
		}
		var publisher = try session.getOrCreatePublisher()
		
		let res = api.publishStream(streamHandle)
		
		if let err = res.error.value {
			throw PrivMXEndpointError.otherFailure(err)
		}
		
	}
	
	public func subscribeToRemoteStreams(
		in streamRoomId: String,
		subscriptions: [privmx.endpoint.stream.StreamSubscription]
	) throws -> Void {
		
		var siv = privmx.StreamSubscriptiopnsVector()
		siv.reserve(subscriptions.count)
		for i in subscriptions{
			siv.push_back(i)
		}
		let res = api.subscribeToRemoteStreams(std.string(streamRoomId),
											   siv)
		if let err = res.error.value{
			throw PrivMXEndpointError.otherFailure(err)
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
	
	public func modifyRemoteStreamsSubscriptions(
		streamRoomId: String,
		subscriptionsToAdd: [privmx.endpoint.stream.StreamSubscription],
		subscriptionsToRemove: [privmx.endpoint.stream.StreamSubscription]
	) throws -> Void{
		var rsiv = privmx.StreamSubscriptiopnsVector()
		rsiv.reserve(subscriptionsToRemove.count)
		for i in subscriptionsToRemove{
			rsiv.push_back(i)
		}
		var asiv = privmx.StreamSubscriptiopnsVector()
		asiv.reserve(subscriptionsToAdd.count)
		for i in subscriptionsToAdd{
			asiv.push_back(i)
		}
		
		let res = api.modifyRemoteStreamsSubscriptions(
			std.string(streamRoomId),
			asiv,
			rsiv)
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
	
	public func dropBrokenFrames(
		_ enable: Bool,
		in roomId:Bool
	) throws -> Void{
		
	}
	
	// MARK: EVENTS
	
	/// Subscribe for the Stream events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries
	public func subscribeFor(
		_ subscriptionQueries: privmx.SubscriptionQueryVector
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
		_ subscriptionIds: privmx.SubscriptionIdVector
	) throws -> Void {
		let res = api.unsubscribeFrom(subscriptionIds)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Generate subscription Query for the Stream events.
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
	
	public func setVideoStreamsHandler(
		_ handler: ((String,RTCVideoTrack) -> Void)?
	) -> Void {
		roomSessionManager.setVideoStreamsHandler(handler)
	}
	public func setAudioStreamsHandler(
		_ handler: ((String,RTCAudioTrack) -> Void)?
	) -> Void {
		roomSessionManager.setAudioStreamsHandler(handler)
	}
}

// #endif // Streams
