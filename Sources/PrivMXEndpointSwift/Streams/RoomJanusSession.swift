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

//#if Streams
import WebRTC
import PrivMXEndpointSwiftNative

class RoomJanusSession{
	init(
		keyStore: PMXKeyStore,
		roomId: String,
		_getPeerConnectionWithDelegate: @escaping () -> (RTCPeerConnection?, PMXPeerConnectionDelegate),
		audioTrackHandler: (@escaping @Sendable (String,RTCAudioTrack) -> Void) = {_,_ in},
		videoTrackHandler: (@escaping @Sendable (String,RTCVideoTrack) -> Void) = {_,_ in},
		connectionStateChangedCallback:((RTCPeerConnectionState) -> Void) = {_ in}
	) {
		self._getPeerConnectionWithDelegate = _getPeerConnectionWithDelegate
		self.roomId = roomId
		self.keyStore = MutexGuarded(keyStore)
		self.defaultAudioTrackHandler = audioTrackHandler
		self.defaultVideoTrackHandler = videoTrackHandler
	}
	
	nonisolated(unsafe)var webRTCInstance: privmx.WRTCIIHolder!
	var keyStore: MutexGuarded<PMXKeyStore>
	private var defaultAudioTrackHandler:((String,RTCAudioTrack) -> Void)?
	private var defaultVideoTrackHandler:((String,RTCVideoTrack) -> Void)?
	private var _pubJC: MutexGuarded<JanusPublisher>?
	private var _subJC: MutexGuarded<JanusSubscriber>?
	let roomId: String
	
	private var _getPeerConnectionWithDelegate: (() -> (RTCPeerConnection?, PMXPeerConnectionDelegate))
	
	func getOrCreatePublisher(
	) throws -> JanusPublisher{
		if nil == _pubJC{
			var (pc,del) = _getPeerConnectionWithDelegate()
			guard let pc else {
				throw PrivMXEndpointError.otherFailure(
					.init(
						name: "Failed Creating PeerConnection",
						message: "",
						description: "")
				)
			}
			del.setPeerConnectionStateChangedCallback({
				_, state in
				print("[pmx][pcObserver] Publisher changed state to: ",state)
			})
			del.currentKeys = keyStore.value
			del.setOnAudioTrackCallback(defaultAudioTrackHandler)
			del.setOnVideoTrackCallback(defaultVideoTrackHandler)
			_pubJC = MutexGuarded(JanusPublisher(
				peerConnection: pc,
				peerConnectionDelegate: del))
		}
		return _pubJC!.value
	}
	
	func getOrCreateSubscriber(
	) throws -> JanusSubscriber {
		if nil == _subJC{
			var (pc,del) = _getPeerConnectionWithDelegate()
			guard let pc else {
				throw PrivMXEndpointError.otherFailure(
					.init(
						name: "Failed Creating PeerConnection",
						message: "",
						description: "")
				)
			}
			del.setPeerConnectionStateChangedCallback({
				_, state in
				print("[pmx][pcObserver] Publisher changed state to: ",state)
			})
			_subJC = MutexGuarded(JanusSubscriber(
				peerConnection: pc,
				peerConnectionDelegate: del
			))
			
		}
		return _subJC!.value
	}
	
	var publisher: JanusPublisher?{
		get{
			return _pubJC?.value
		}
	}
	
	var subscriber: JanusSubscriber?{
		get{
			return _subJC?.value
		}
	}
		
	public func hasPublisher(
	) -> Bool {
		nil != _pubJC
	}
	
	public func hasSubscriber(
	) -> Bool {
		nil != _subJC
	}
	
	public func updateKeys(
		_ keys: [PMXKSKey]
	){
		keyStore.value.setKeys(keys)
	}
}
