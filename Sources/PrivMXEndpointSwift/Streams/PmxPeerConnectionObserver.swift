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

// #if Streams
import Foundation
import WebRTC
import PrivMXEndpointStreamsLow
import Synchronization


public final class PmxPeerConnectionObserver:NSObject,RTCPeerConnectionDelegate, @unchecked Sendable{
	var streamRoomId: String
	var currentKeys = MutexGuarded<PMXKeyStore>(PMXKeyStore())
	weak var peerConnectionFactory : RTCPeerConnectionFactory!
	weak private var peerConnectionManager: PeerConnectionManager!
	
	private var cryptors = MutexGuarded<[String : (PMXFrameCryptorTransformer,PMXFrameCryptorDelegate)]>([:])
	
	private var onFrameCallback:((Int64, Int64) -> Void)?
	
	
	public init(
		streamRoomId: String,
		peerConnectionFactory: RTCPeerConnectionFactory,
		peerConnectionManager: PeerConnectionManager,
		currentKeys: PMXKeyStore = PMXKeyStore(),
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
		self.currentKeys.value = currentKeys
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
	
	private nonisolated(unsafe) var onVideoTrack: ((String, RTCVideoTrack) -> Void)?
	private nonisolated(unsafe) var onAudioTrack: ((String, RTCAudioTrack) -> Void)?
	
	public func setOnVideoTrackCallback(
		_ cb: ((String, RTCVideoTrack) -> Void)?
	) {
		onVideoTrack = cb
	}
	
	public func setOnAudioTrackCallback(
		_ cb: ((String, RTCAudioTrack) -> Void)?
	) {
		onAudioTrack = cb
	}
	
	public func setConnectionSignalingStateChangedCallback(
		_ cb: (@Sendable (RTCPeerConnection,RTCSignalingState)->Void)?
	) {
		onConnectionSignalingStateChanged = cb
	}
	
	public func setConnectionPeerStateChangedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCPeerConnectionState)->Void)?
	){
		onConnectionPeerStateChanged = cb
	}
	public func setStreamAddedCallback(
		_ cb :(@Sendable (RTCPeerConnection,RTCMediaStream)->Void)?
	){
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
		print("Signaling state changed to ",stateChanged.rawValue)
		onConnectionSignalingStateChanged?(peerConnection,stateChanged)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd stream: RTCMediaStream
	) -> Void {
		print("StreamAdded")
		onStreamAdded?(peerConnection,stream)
		for vt in stream.videoTracks{
			//onVideoTrack?("\(streamRoomId)-\(vt.trackId)", vt)
		}
		print("SA done")
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove stream: RTCMediaStream
	) {
		print("StreamRemoved")
		onStreamRemoved?(peerConnection,stream)
	}
	
	public func peerConnectionShouldNegotiate(
		_ peerConnection: RTCPeerConnection
	) {
		print("shouldrenegotiate")
		onShouldRenegotiate?(peerConnection)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceConnectionState
	) {
		print("ICE connection state changed to", newState)
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceGatheringState
	) {
		print("ICE gathering state changed")
		onIceGatheringStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didGenerate candidate: RTCIceCandidate
	) {
		print("generated ICE candidate")
		onIceCandidateGenerated?(peerConnection,candidate)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove candidates: [RTCIceCandidate]
	) {
		print("ICE candidate removed")
		onIceCandidatesRemoved?(peerConnection,candidates)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didOpen dataChannel: RTCDataChannel
	) {
		print("DATA channel opened")
		onDataChannelOpened?(peerConnection,dataChannel)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didStartReceivingOn transceiver: RTCRtpTransceiver
	) {
		print("Started receiving on transciever")
		onStartedReceiving?(peerConnection,transceiver)
		let receiver = transceiver.receiver
		if let track = receiver.track, var peerConnectionFactory {
			var pfct = PMXFrameCryptorTransformer(for: receiver, with: peerConnectionFactory, pmxKeyStore: currentKeys.value)
			var deleg = PMXFrameCryptorDelegate()
			if pfct != nil{
			pfct!.register(deleg)
			pfct!.setDropFramesIfCryptionFailed(false)
				cryptors.value[track.trackId] = (pfct!,deleg)
			}
			if track.kind == kRTCMediaStreamTrackKindVideo {
				if let track = track as? RTCVideoTrack{
					print("Got a Video Track")
					onVideoTrack?("\(streamRoomId)-\(track.trackId)", track)
				} else {
					print("Couldn't cast media track as video track")
				}
			}
			else if track.kind == kRTCMediaStreamTrackKindAudio {
				if let track = track as? RTCAudioTrack{
					print("Got an Audio Track")
					onAudioTrack?("\(streamRoomId)-\(track.trackId)",track)
				}else{
					print("Couldn't cast media track as audio track")
				}
			}
		}
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd rtpReceiver: RTCRtpReceiver,
		streams mediaStreams: [RTCMediaStream]
	) {
		print("receiver added streams")
		onTracksAdded?(peerConnection,rtpReceiver,mediaStreams)
		print("?0")
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCPeerConnectionState
	) {
		print("peerconnection state changed")
		onConnectionPeerStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove rtpReceiver: RTCRtpReceiver
	) {
		print("peerConnection removed receiver")
		onStoppedReceiving?(peerConnection,rtpReceiver)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didFailToGatherIceCandidate event: RTCIceCandidateErrorEvent
	) {
		print("failed gathering ICE candidates")
		onIceCandidateErrorEvent?(peerConnection,event)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeStandardizedIceConnectionState newState: RTCIceConnectionState
	) {
		print("standardised Ice connection state changed")
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeLocalCandidate local: RTCIceCandidate,
		remoteCandidate remote: RTCIceCandidate,
		lastReceivedMs lastDataReceivedMs: Int32,
		changeReason reason: String
	) {
		print("PC changed local candidate")
		onLocalCandidateChanged?(peerConnection,
								 local,
								 remote,
								 lastDataReceivedMs,
								 reason)
	}
}
// #endif // Streams
