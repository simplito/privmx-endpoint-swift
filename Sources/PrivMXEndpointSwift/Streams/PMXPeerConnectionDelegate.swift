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
import Foundation
import WebRTC
import PrivMXEndpointSwiftNative
import Synchronization


final class PMXPeerConnectionDelegate:NSObject,RTCPeerConnectionDelegate, @unchecked Sendable{
	var streamRoomId: String
	var currentKeys : PMXKeyStore
	weak var peerConnectionFactory : RTCPeerConnectionFactory!
	
	var cryptors = MutexGuarded<[String : (PMXFrameCryptorTransformer,PMXFrameCryptorDelegate)]>([:])
	
	var unprocessedTracks = [String:RTCMediaStreamTrack]()
	var track2Stream: [String:String] = [:]
	public init(
		streamRoomId: String,
		peerConnectionFactory: RTCPeerConnectionFactory,
		currentKeys: inout PMXKeyStore,
		onConnectionSignalingStateChanged: ((RTCPeerConnection, RTCSignalingState) -> Void)? = nil,
		onConnectionPeerStateChanged: ((RTCPeerConnection, RTCPeerConnectionState) -> Void)? = nil,
		onStreamAdded: ((RTCPeerConnection, RTCMediaStream) -> Void)? = nil,
		onStreamRemoved: ((RTCPeerConnection, RTCMediaStream) -> Void)? = nil,
		onShouldRenegotiate: ((RTCPeerConnection) -> Void)? = nil,
		onIceCandidateErrorEvent: ((RTCPeerConnection, RTCIceCandidateErrorEvent) -> Void)? = nil,
		onIceConnectionStateChanged: ((RTCPeerConnection, RTCIceConnectionState) -> Void)? = nil,
		onIceGatheringStateChanged: ((RTCPeerConnection, RTCIceGatheringState) -> Void)? = nil,
		onIceCandidateGenerated: ((RTCPeerConnection, RTCIceCandidate) -> Void)? = nil,
		onIceCandidatesRemoved: ((RTCPeerConnection, [RTCIceCandidate]) -> Void)? = nil,
		onDataChannelOpened: ((RTCPeerConnection, RTCDataChannel) -> Void)? = nil,
		onStartedReceiving: ((RTCPeerConnection, RTCRtpTransceiver) -> Void)? = nil,
		onStoppedReceiving: ((RTCPeerConnection, RTCRtpReceiver) -> Void)? = nil,
		onTracksAdded: ((RTCPeerConnection, RTCRtpReceiver, [RTCMediaStream]) -> Void)? = nil,
		onTracksRemoved: ((RTCPeerConnection, RTCRtpReceiver) -> Void)? = nil,
		onLocalCandidateChanged: ((RTCPeerConnection, RTCIceCandidate, RTCIceCandidate, Int32, String) -> Void)? = nil
	) {
		self.peerConnectionFactory = peerConnectionFactory
		
		self.streamRoomId = streamRoomId
		self.currentKeys = currentKeys
		self.onConnectionSignalingStateChanged = onConnectionSignalingStateChanged
		self.onConnectionPeerStateChanged = onConnectionPeerStateChanged
		self.onStreamAdded = onStreamAdded
		self.onStreamRemoved = onStreamRemoved
		self.onShouldRenegotiate = onShouldRenegotiate
		self.onIceCandidateErrorEvent = onIceCandidateErrorEvent
		self.onIceConnectionStateChanged = onIceConnectionStateChanged
		self.onIceGatheringStateChanged = onIceGatheringStateChanged
		self.onIceCandidateGenerated = onIceCandidateGenerated
		self.onIceCandidatesRemoved = onIceCandidatesRemoved
		self.onDataChannelOpened = onDataChannelOpened
		self.onStartedReceiving = onStartedReceiving
		self.onStoppedReceiving = onStoppedReceiving
		self.onTracksAdded = onTracksAdded
		self.onTracksRemoved = onTracksRemoved
		self.onLocalCandidateChanged = onLocalCandidateChanged
	}
	
	
	private var onConnectionSignalingStateChanged: ((RTCPeerConnection,RTCSignalingState)->Void)?
	private var onConnectionPeerStateChanged: ((RTCPeerConnection,RTCPeerConnectionState)->Void)?
	private var onStreamAdded: ((RTCPeerConnection,RTCMediaStream)->Void)?
	private var onStreamRemoved: ((RTCPeerConnection,RTCMediaStream)->Void)?
	private var onShouldRenegotiate: ((RTCPeerConnection)->Void)?
	
	private var onIceCandidateErrorEvent:((RTCPeerConnection,RTCIceCandidateErrorEvent)->Void)?
	private var onIceConnectionStateChanged:((RTCPeerConnection,RTCIceConnectionState)->Void)?
	private var onIceGatheringStateChanged:((RTCPeerConnection,RTCIceGatheringState)->Void)?
	private var onIceCandidateGenerated:((RTCPeerConnection,RTCIceCandidate)->Void)?
	private var onIceCandidatesRemoved:((RTCPeerConnection,[RTCIceCandidate])->Void)?
	
	private var onDataChannelOpened:((RTCPeerConnection,RTCDataChannel)->Void)?
	private var onStartedReceiving:((RTCPeerConnection,RTCRtpTransceiver)->Void)?
	private var onStoppedReceiving:((RTCPeerConnection,RTCRtpReceiver)->Void)?
	
	
	private var onTracksAdded:((RTCPeerConnection, RTCRtpReceiver, [RTCMediaStream]) -> Void)?
	private var onTracksRemoved:((RTCPeerConnection, RTCRtpReceiver) -> Void)?
	
	private var onLocalCandidateChanged:((RTCPeerConnection,RTCIceCandidate,RTCIceCandidate,Int32,String)->Void)?
	
	nonisolated(unsafe) var onVideoTrack: ((String, RTCVideoTrack) -> Void)?
	nonisolated(unsafe) var onAudioTrack: ((String, RTCAudioTrack) -> Void)?
	
	public func setOnVideoTrackCallback(
		_ cb: ((String, RTCVideoTrack) -> Void)?
	) {
		RTCLogEx(.info, "[PMX][Observer] received new onVideoTrack callback")
		onVideoTrack = cb
	}
	
	public func setOnAudioTrackCallback(
		_ cb: ((String, RTCAudioTrack) -> Void)?
	) {
		RTCLogEx(.info, "[PMX][Observer] received new onAudioTrack callback")
		onAudioTrack = cb
	}
	
	public func setConnectionSignalingStateChangedCallback(
		_ cb: (@Sendable (RTCPeerConnection,RTCSignalingState)->Void)?
	) {
		onConnectionSignalingStateChanged = cb
	}
	
	public func setPeerConnectionStateChangedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCPeerConnectionState)->Void)?
	){
		onConnectionPeerStateChanged = cb
	}
	public func setStreamAddedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCMediaStream)->Void)?
	){
		RTCLogEx(.info, "[PMX][Observer] received new onStreamAdded callback")
		onStreamAdded = cb
	}
	public func setStreamRemovedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCMediaStream)->Void)?
	){
		onStreamRemoved = cb
	}
	public func setShouldRenegotiateCallback(
		_ cb :(@Sendable (RTCPeerConnection)->Void)?
	){
		onShouldRenegotiate = cb
	}
	
	public func setIceCandidateErrorEventCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCIceCandidateErrorEvent)->Void)?
	){
		onIceCandidateErrorEvent = cb
	}
	public func setIceConnectionStateChangedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCIceConnectionState)->Void)?
	){
		onIceConnectionStateChanged = cb
	}
	public func setIceGatheringStateChangedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCIceGatheringState)->Void)?
	){
		onIceGatheringStateChanged = cb
	}
	public func setIceCandidateGeneratedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCIceCandidate)->Void)?
	){
		onIceCandidateGenerated = cb
	}
	
	public func setIceCandidatesRemovedCallback(
		_ cb :(@Sendable (RTCPeerConnection,[RTCIceCandidate])->Void)?
	){
		onIceCandidatesRemoved = cb
	}
	
	public func setDataChannelOpenedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCDataChannel)->Void)?
	){
		onDataChannelOpened = cb
	}
	public func setStartedReceivingCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCRtpTransceiver)->Void)?
	){
		onStartedReceiving = cb
	}
	public func setStoppedReceivingCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCRtpReceiver)->Void)?
	){
		onStoppedReceiving = cb
	}
	
	
	public func setTracksAddedCallback(
		_ cb :(@Sendable (RTCPeerConnection, RTCRtpReceiver, [RTCMediaStream]) -> Void)?
	){
		onTracksAdded = cb
	}
	public func setTracksRemovedCallback(
		_ cb :(@Sendable (RTCPeerConnection, RTCRtpReceiver) -> Void)?
	){
		onTracksRemoved = cb
	}
	
	public func setLocalCandidateChangedCallback(
	_ cb :(@Sendable (RTCPeerConnection,RTCIceCandidate,RTCIceCandidate,Int32,String)->Void)?
	){
		onLocalCandidateChanged = cb
	}
	
	//MARK: - Delegate Methods
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange stateChanged: RTCSignalingState
	) -> Void {
		RTCLogEx(.info, "[PMX][observer] PC Signaling state changed to \(stateChanged.rawValue)")
		onConnectionSignalingStateChanged?(peerConnection,stateChanged)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd stream: RTCMediaStream
	) -> Void {
		RTCLogEx(.info, "[PMX][observer] PC StreamAdded with \(stream.videoTracks.count) video and \(stream.audioTracks.count) audio tracks")
		
		onStreamAdded?(peerConnection,stream)
		let streamId = stream.streamId
		for vtr in stream.videoTracks {
			self.track2Stream[vtr.trackId] = streamId
			onVideoTrack?(streamId,vtr)
		}
		for vtr in stream.audioTracks {
			self.track2Stream[vtr.trackId] = streamId
			onAudioTrack?(streamId,vtr)
		}
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove stream: RTCMediaStream
	) {
		RTCLogEx(.info, "[PMX][observer] PC StreamRemoved")
		onStreamRemoved?(peerConnection,stream)
	}
	
	public func peerConnectionShouldNegotiate(
		_ peerConnection: RTCPeerConnection
	) {
		RTCLogEx(.info, "[PMX][observer] PC should renegotiate")
		onShouldRenegotiate?(peerConnection)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceConnectionState
	) {
		RTCLogEx(.info, "[PMX][observer] PC ICE connection state changed to \(newState)")
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceGatheringState
	) {
		RTCLogEx(.info, "[PMX][observer] PC ICE gathering state changed")
		onIceGatheringStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didGenerate candidate: RTCIceCandidate
	) {
		RTCLogEx(.info, "[PMX][observer] PC generated ICE candidate")
		onIceCandidateGenerated?(peerConnection,candidate)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove candidates: [RTCIceCandidate]
	) {
		RTCLogEx(.info, "[PMX][observer] PC ICE candidate removed")
		onIceCandidatesRemoved?(peerConnection,candidates)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didOpen dataChannel: RTCDataChannel
	) {
		RTCLogEx(.info, "[PMX][observer] PC DATA channel opened")
		onDataChannelOpened?(peerConnection,dataChannel)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didStartReceivingOn transceiver: RTCRtpTransceiver
	) {
		RTCLogEx(.info, "[PMX][observer] PC Started receiving on transciever")
		let receiver = transceiver.receiver
		if let track = receiver.track, var peerConnectionFactory {
			var pfct = PMXFrameCryptorTransformer(for: receiver, with: peerConnectionFactory, pmxKeyStore: currentKeys)
			var deleg = PMXFrameCryptorDelegate()
			if pfct != nil{
			pfct!.register(deleg)
			pfct!.setDropFramesIfCryptionFailed(true)
				cryptors.value[track.trackId] = (pfct!,deleg)
			}
			unprocessedTracks[track.trackId] = track
			//onStartedReceiving?(peerConnection,transceiver)
		}
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd rtpReceiver: RTCRtpReceiver,
		streams mediaStreams: [RTCMediaStream]
	) {
		RTCLogEx(.info, "[PMX][observer] PC  receiver added streams")
		onTracksAdded?(peerConnection,rtpReceiver,mediaStreams)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCPeerConnectionState
	) {
		RTCLogEx(.info, "[PMX][observer] PC state changed to  \(newState), \(newState.rawValue) on : \(peerConnection)")
		onConnectionPeerStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove rtpReceiver: RTCRtpReceiver
	) {
		RTCLogEx(.info, "[PMX][observer] PC removed receiver")
		onStoppedReceiving?(peerConnection,rtpReceiver)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didFailToGatherIceCandidate event: RTCIceCandidateErrorEvent
	) {
		RTCLogEx(.info, "[PMX][observer] PC failed gathering ICE candidates")
		onIceCandidateErrorEvent?(peerConnection,event)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeStandardizedIceConnectionState newState: RTCIceConnectionState
	) {
		RTCLogEx(.info, "[PMX][observer] PC standardised Ice connection state changed: \(newState) raw: \(newState.rawValue)")
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeLocalCandidate local: RTCIceCandidate,
		remoteCandidate remote: RTCIceCandidate,
		lastReceivedMs lastDataReceivedMs: Int32,
		changeReason reason: String
	) {
		RTCLogEx(.info, "[PMX][observer] PC changed local candidate")
		onLocalCandidateChanged?(peerConnection,
								 local,
								 remote,
								 lastDataReceivedMs,
								 reason)
	}
}
// #endif // Streams
