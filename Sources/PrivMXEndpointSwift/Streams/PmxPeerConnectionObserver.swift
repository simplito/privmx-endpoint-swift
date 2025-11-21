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
import Foundation
import WebRTC
import Synchronization

public final class PmxPeerConnectionObserver:NSObject,RTCPeerConnectionDelegate, @unchecked Sendable{
	
	
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
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange stateChanged: RTCSignalingState
	) -> Void {
		onConnectionSignalingStateChanged?(peerConnection,stateChanged)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd stream: RTCMediaStream
	) -> Void {
		onStreamAdded?(peerConnection,stream)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove stream: RTCMediaStream
	) {
		onStreamRemoved?(peerConnection,stream)
	}
	
	public func peerConnectionShouldNegotiate(
		_ peerConnection: RTCPeerConnection
	) {
		onShouldRenegotiate?(peerConnection)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceConnectionState
	) {
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCIceGatheringState
	) {
		onIceGatheringStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didGenerate candidate: RTCIceCandidate
	) {
		onIceCandidateGenerated?(peerConnection,candidate)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove candidates: [RTCIceCandidate]
	) {
		onIceCandidatesRemoved?(peerConnection,candidates)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didOpen dataChannel: RTCDataChannel
	) {
		onDataChannelOpened?(peerConnection,dataChannel)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didStartReceivingOn transceiver: RTCRtpTransceiver
	) {
		onStartedReceiving?(peerConnection,transceiver)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd rtpReceiver: RTCRtpReceiver,
		streams mediaStreams: [RTCMediaStream]
	) {
		onTracksAdded?(peerConnection,rtpReceiver,mediaStreams)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCPeerConnectionState
	) {
		onConnectionPeerStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove rtpReceiver: RTCRtpReceiver
	) {
		onStoppedReceiving?(peerConnection,rtpReceiver)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didFailToGatherIceCandidate event: RTCIceCandidateErrorEvent
	) {
		onIceCandidateErrorEvent?(peerConnection,event)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeStandardizedIceConnectionState newState: RTCIceConnectionState
	) {
		onIceConnectionStateChanged?(peerConnection,newState)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeLocalCandidate local: RTCIceCandidate,
		remoteCandidate remote: RTCIceCandidate,
		lastReceivedMs lastDataReceivedMs: Int32,
		changeReason reason: String
	) {
		onLocalCandidateChanged?(peerConnection,
								 local,
								 remote,
								 lastDataReceivedMs,
								 reason)
	}
}
#endif // Streams
