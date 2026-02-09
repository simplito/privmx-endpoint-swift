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
import PrivMXEndpointStreamsLow
import Foundation
import WebRTC
#if os(macOS)
import ScreenCaptureKit
#endif
public class StreamApi: @unchecked Sendable{
	private var api: privmx.NativeStreamApiLowWrapper
	//public var rtcClient: WebRTCClient
	var roomSessionManager: RoomSessionManager!
	#if os(iOS)
	public private(set) var audioHandler : AVAudioEngineRTCAudioDevice
	private init(
		api: privmx.NativeStreamApiLowWrapper,
		audioHandler:AVAudioEngineRTCAudioDevice,
		//rtcClient: WebRTCClient
	) {
		self.api = api
		//self.rtcClient = rtcClient
		self.audioHandler = audioHandler
		//self.rtcClient.bindTrickleImpl(){ sessionId, candidate in
//			self.api.trickle(sessionId, std.string(candidate))}
	//	self.rtcClient.bindCreatePeerConnectionImpl()
	}
	private func bindRoomSessionManger(
		audioHandler: AVAudioEngineRTCAudioDevice,
		initOptions: InitOptions?
	){
		self.roomSessionManager = RoomSessionManager.create(
			onTrickle: { sessionId, candidate in
				self.api.trickle(sessionId, std.string(candidate))
				
			},
			audioHandler: audioHandler,
			options: initOptions
		)
	}
#else
	private init(
		api: privmx.NativeStreamApiLowWrapper,
		//rtcClient: WebRTCClient
	) {
		self.api = api
		//self.rtcClient = rtcClient
	}
	private func bindRoomSessionManger(){
		self.roomSessionManager = RoomSessionManager.create(
			onTrickle: { sessionId, candidate in
				self.api.trickle(sessionId, std.string(candidate))
			}
		)
	}
#endif
	
	
#if os(iOS)
	/// Creates the API instance
	public static func create(
		connection: Connection,
		audioHandler: AVAudioEngineRTCAudioDevice,
		eventApi: inout EventApi,
		initOptions: InitOptions? = nil
	) throws -> StreamApi{
		let low = privmx.NativeStreamApiLowWrapper.create(connection.api, &eventApi.api)
		guard var api = low.result.value
		else {
			throw PrivMXEndpointError.otherFailure(privmx.InternalError())
		}
		var sa = StreamApi(
			api: api,
			audioHandler:audioHandler
			//rtcClient: WebRTCClient.create(audioHandler:audioHandler)
		)
		sa.bindRoomSessionManger(
			audioHandler: audioHandler,
			initOptions: initOptions)
		return sa
	}
#else
	/// Creates the API instance
	public static func create(
		connection: Connection,
		eventApi: inout EventApi
	) throws -> StreamApi{
		let low = privmx.NativeStreamApiLowWrapper.create(connection.api, &eventApi.api)
		if let err = low.error.value {
			throw PrivMXEndpointError.otherFailure(err)
		}
		guard var api = low.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil result"
			throw PrivMXEndpointError.otherFailure(err)
		}
		var sa =  StreamApi(
			api: api,
		)
		sa.bindRoomSessionManger()
		return sa
	}
#endif
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
		
		print(mv.size(),uv.size())
		print("m(\(managers.count))")
		for m in managers{
			print(m)
		}
		print("u(\(users.count))")
		for u in users{
			print(u)
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
		videoTrackHandler: ((String,RTCVideoTrack) -> Void)?
	) throws -> Void {
		try roomSessionManager.addRoomSessionFor(streamRoomId)
		let res = api.joinStreamRoom(
			std.string(streamRoomId),
			roomSessionManager.webRtcInstance!.instance
		)
		if let err = res.error.value{
			roomSessionManager.roomSessions[streamRoomId] = nil
			throw PrivMXEndpointError.otherFailure(err)
		}
		roomSessionManager.setAudioStreamsHandler(audioTrackHandler)
		roomSessionManager.setVideoStreamsHandler(videoTrackHandler)
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
	
	/*
	@available(*, deprecated) // maybe
	public func getMediaDevices(
	) throws -> [privmx.endpoint.stream.MediaDevice] {
		var devices = [privmx.endpoint.stream.MediaDevice]()
		//Audio input
		let audioInDev = rtcClient.peerConnectionFactory.audioDeviceModule.inputDevice
		let videoInDevs = RTCCameraVideoCapturer.captureDevices()
		let desktopInDev = rtcClient.peerConnectionFactory.videoSource(forScreenCast: true)
		devices.append(.init(
			name: std.string(audioInDev.name),
			id: std.string(audioInDev.deviceId),
			type: privmx.endpoint.stream.Audio))
		return devices
	}
	public func addTrackFrom(
		_ device: TrackType,
		to streamHandle:privmx.endpoint.stream.StreamHandle,
		withHandler handler: @escaping (RTCMediaStreamTrack) -> Void = {_ in}
	) throws -> Void{
		//guard let str = streams[streamHandle]
		//else {
			throw PrivMXEndpointError.otherFailure(privmx.InternalError(
				name: "No such stream",
				message: "",
				description: "",
				code: nil, scope: nil))
		//}
		print("found stream")
		for entry in streamTracks{
			if nil != entry.value.track?.trackId
				&& entry.value.track!.trackId == String(device.getId()){
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(
					name: "Track already exists",
					message: "",
					description: "",
					code: nil, scope: nil))
			}
		}
		//streams[streamHandle]!.trackIds.append(String(device.id))
		
		print("track is not a duplicate")
		let sTrackId = UUID().uuidString
		var sTrack : StreamTrackInfo
		switch device {
			case .Audio(let id):
				var asrc = rtcClient.peerConnectionFactory.audioSource(with: nil)
				var idevs = rtcClient.peerConnectionFactory.audioDeviceModule.inputDevices
				var odevs = rtcClient.peerConnectionFactory.audioDeviceModule.outputDevices
				for d in idevs{
					print("i[dbg]",d.name,d.description,d.type,d.deviceId,d.isDefault)
				}
				for d in odevs{
					print("o[dbg]",d.name,d.description,d.type,d.deviceId,d.isDefault)
				}
				var atrack = rtcClient.peerConnectionFactory.audioTrack(
					with: asrc,
					trackId: String(id))
				sTrack = StreamTrackInfo(
					id: sTrackId,
					streamId: String(id),
					streamHandle: streamHandle,
					track: atrack,
					published: false,
				)
				print("adding audio track")
				
				try rtcClient.addVideoTrack(&sTrack,in:str.roomId)
				//handler(atrack)
				//streamTracks[sTrackId] = sTrack
				//streams[streamHandle]?.trackIds.append(sTrackId)
			case .Video(let id):
				var vs = rtcClient.peerConnectionFactory.videoSource(forScreenCast: false)
				var cptr = RTCCameraVideoCapturer(delegate: vs)
				var dev = AVCaptureDevice.default(for: .video)
				guard let dev
				else {
					throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "No default Device for video", message: "", description: ""))
				}
				var vtrack = rtcClient.peerConnectionFactory.videoTrack(
					with: vs,
					trackId: String(id))
				sTrack = StreamTrackInfo(
					id: sTrackId,
					streamId: String(id),
					streamHandle: streamHandle,
					track: vtrack,
					cameraCapturer: cptr,
					published: false,
				)
				print("adding video track")
				try rtcClient.addVideoTrack(&sTrack,in:str.roomId)
				handler(vtrack)
				try cptr.startCapture(with: dev, format: dev.activeFormat, fps: 24)
				streamTracks[sTrackId] = sTrack
				streams[streamHandle]?.trackIds.append(sTrackId)
#if os(macOS)
			case .Desktop(let id, let filter):
				
				var vs = self.rtcClient.peerConnectionFactory.videoSource(forScreenCast: true)
				var cptr = try? PMXDesktopCapturer(videoDelegate: vs,
												   filter: filter,
												   configuration: .init())
				var vtrack = self.rtcClient.peerConnectionFactory.videoTrack(
					with: vs,
					trackId: String(id))
				var sTrack = StreamTrackInfo(
					id: sTrackId,
					streamId: String(id),
					streamHandle: streamHandle,
					track: vtrack,
					desktopCapturer: cptr,
					published: false,
				)
				print("adding video track")
				try? self.rtcClient.addVideoTrack(&sTrack,in:str.roomId)
				handler(vtrack)
				Task{try? await cptr?.startRecording()}
				self.streamTracks[sTrackId] = sTrack
				self.streams[streamHandle]?.trackIds.append(sTrackId)
#endif // os(macOS)
			default:
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "Unknown Track Type", message: "", description: ""))
		}
	}
	*/
	
	//MARK: - ideas
	public func addTrack(
		_ track: RTCVideoTrack,
		toRoomSession roomId:String
	) throws -> Void {
		try roomSessionManager.addVideoTrack(track, to: roomId)
	}
	
	public func addTrack(
		_ track: RTCAudioTrack,
		toRoomSession roomId:String
	) throws -> Void {
		try roomSessionManager.addAudioTrack(track, to: roomId)
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
	
	//public func createRawTrack(
	//	id: String
	//) -> (track:RTCDA, source: RTCAudioSource) {
	//	var src = rtcClient.peerConnectionFactory.audioSource(with: nil)
	//	var trk = rtcClient.peerConnectionFactory.audioTrack(with: src, trackId: id)
	//	return (trk,src)
	//}
	
	

	public func removeVideoTrack(
		_ track: RTCVideoTrack,
		fromStreamWithHandle: privmx.endpoint.stream.StreamHandle
	) -> Bool{
		return false
	}
	//MARK: -
	public func removeTrack(
		_ track:privmx.endpoint.stream.MediaDevice,
		from streamHandle: privmx.endpoint.stream.StreamHandle
	) throws -> Void{
		//streams[streamHandle]?.capturers.value.
	}
	
	public func publishStream(
		_ streamHandle: privmx.endpoint.stream.StreamHandle
	) throws -> Void {
		guard let rid = roomSessionManager.streamHandles[streamHandle]
		else {
			throw PrivMXEndpointError.otherFailure(.init(
				name: "Unknown stream handle",
				message: "",
				description: "")
			)
		}
		guard let session = roomSessionManager.roomSessions[rid]
		else {
			throw PrivMXEndpointError.otherFailure(
				.init(
					name: "Couldn't create cryptor",
					message: "", description: ""
				)
			)
		}
		var publisher = try session.getOrCreatePublisher()
		//for t in publisher.videoTracks{
		//	guard let track = roomSessionManager.streamTracks[t]
		//	else {throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "missing track", message: "", description: ""))}
		//	roomSessionManager.streamTracks[t]?.published = true
		//}
		publisher.peerConnection
		let res = api.publishStream(streamHandle)
		if let err = res.error.value {
			throw PrivMXEndpointError.otherFailure(err)
		}
	}
	
	
	//public func openStream(
	//	streamId: Int64,
	//	_ streamRoomId: String,
	//	settings: privmx.endpoint.stream.StreamSettings,
	//	localStreamId: Int64
	//) throws -> Int64 {
	//	return 1
	//}
	
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
	
	public func modifyRemoteStreamsSubscriptions(
		streamRoomId: String,
		subscriptionsToAdd: [privmx.endpoint.stream.StreamSubscription],
		subscriptionsToRemove: [privmx.endpoint.stream.StreamSubscription],
		options: privmx.endpoint.stream.Settings
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
			rsiv,
			options)
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
		_ enable: Bool,
		in roomId:Bool
	) throws -> Void{
		
	}
	
	//public func reconfigureStream(
	//	localStreamId: Int64,
	//	optionsJSON : String = "{}"
	//) throws -> Void{}
	
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

// #endif // Streams
