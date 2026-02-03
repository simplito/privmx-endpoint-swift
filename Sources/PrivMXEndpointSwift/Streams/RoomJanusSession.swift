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
		_createJanusConnection: @escaping () -> JanusConnection,
		roomId: String
	) {
		self._createJanusConnection = _createJanusConnection
		self.roomId = roomId
	}
	
	var keyStore: PMXKeyStore = PMXKeyStore()
	private var _pubJC: MutexGuarded<JanusPublisher>?
	private var _subJC: MutexGuarded<JanusSubscriber>?
	let roomId: String
	
	private var _createJanusConnection: (() -> JanusConnection)
	
	func getOrCreatePublisher(){
		if nil != _pubJC{
			var jc = _createJanusConnection()
			_pubJC = MutexGuarded(JanusPublisher(
				peerConnection: jc.peerConnection,
				peerConnectionDelegate: jc.delegate))
			
		}
	}
	
	func getOrCreateSubscriber(){
		if nil != _subJC{
			
		}
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
		_ type: ConnectionType
	) -> Bool {
		nil != _pubJC
	}
	
	public func hasSubscriber(
		_ type: ConnectionType
	) -> Bool {
		nil != _subJC
	}
	
}
