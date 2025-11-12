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
import os.lock

public class PmxPeerConnectionObserver:NSObject,RTCPeerConnectionDelegate{
	
	public var onConnectionChanged: ((RTCPeerConnection,RTCSignalingState)->Void)?
	public var onStreamAdded: ((RTCPeerConnection,RTCMediaStream)->Void)?
	public var onStreamRemoved: ((RTCPeerConnection,RTCMediaStream)->Void)?
	public var onShouldRenegotiate: ((RTCPeerConnection)->Void)?
	public var onIceConnectionStateChanged:((RTCPeerConnection,RTCIceConnectionState)->Void)?
	public var onIceGatheringStateChanged:((RTCPeerConnection,RTCIceGatheringState)->Void)?
	public var onIceCandindateGenerated:((RTCPeerConnection,RTCIceCandidate)->Void)?
	public var onIceCandindatesRemoved:((RTCPeerConnection,[RTCIceCandidate])->Void)?
	public var onDataChannelOpened:((RTCPeerConnection,RTCDataChannel)->Void)?
	public var onStartedReceiving:((RTCPeerConnection,RTCRtpTransceiver)->Void)?
	
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange stateChanged: RTCSignalingState
	) -> Void {
		onConnectionChanged?(peerConnection,stateChanged)
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
		onIceCandindateGenerated?(peerConnection,candidate)
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove candidates: [RTCIceCandidate]
	) {
		onIceCandindatesRemoved?(peerConnection,candidates)
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
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didAdd rtpReceiver: RTCRtpReceiver,
		streams mediaStreams: [RTCMediaStream]
	) {
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChange newState: RTCPeerConnectionState
	) {
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didRemove rtpReceiver: RTCRtpReceiver
	) {
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didFailToGatherIceCandidate event: RTCIceCandidateErrorEvent
	) {
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeStandardizedIceConnectionState newState: RTCIceConnectionState
	) {
		
	}
	
	public func peerConnection(
		_ peerConnection: RTCPeerConnection,
		didChangeLocalCandidate local: RTCIceCandidate,
		remoteCandidate remote: RTCIceCandidate,
		lastReceivedMs lastDataReceivedMs: Int32,
		changeReason reason: String
	) {
		
	}
}
#endif
