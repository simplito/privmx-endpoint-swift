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
import PrivMXEndpointStreamsLow
import WebRTC

public final class PeerConnectionManager: Sendable {
	
	nonisolated(unsafe) var _createPeerConnection : (@Sendable (String) -> RTCPeerConnection?)?
	nonisolated(unsafe) var _onTrickle : (@Sendable (Int64,String) throws -> Void)?
	nonisolated(unsafe) var connections = MutexGuarded<[String : [ConnectionType:JanusConnection]]>([:])
	
	enum State{
		case reading,writing
		case idle
	}
	
	init(
		_createPeerConnection: (@Sendable (String) -> RTCPeerConnection?)? = nil,
		_onTrickle: (@Sendable (Int64,String) throws -> Void)? = nil
	) {
		self._createPeerConnection = _createPeerConnection
		self._onTrickle = _onTrickle
	}
	
	public func initializeConnection(
		in streamRoomId: String,
		ofType type: ConnectionType,
		sessionId: Int64 = -1
	) throws {
		if connections.value.contains(where: {$0 == streamRoomId && $1.keys.contains(type)}){
			throw PrivMXEndpointError.failedInitializingPeerConnection(privmx.InternalError(
				name: "Already Initialized",
				message: "JanusConnection with given parameters already initialized",
				description: "", code: nil, scope: nil))
		}
		if !connections.value.keys.contains(streamRoomId){
			connections.value[streamRoomId] = [:]
		}
		
		guard let pc = _createPeerConnection?(streamRoomId)
		else {
			throw PrivMXEndpointError.failedInitializingPeerConnection(privmx.InternalError(
				name: "PeerConnection wasn't created",
				message: "",
				description: "",
				code: nil,
				scope: nil))
		}
		
		
		(pc.delegate as? PmxPeerConnectionObserver)?.setIceCandidateGeneratedCallback({
			peerConnection,candidate in
			
			let roomConnections = self.connections.value[streamRoomId] ?? [:]
			let roomConnection = roomConnections[type]
			if !candidate.sdp.isEmpty,let sessionId = roomConnection?.sessionId, sessionId > -1{
				var iceCandidate = candidate.sdp
				do{
					try self._onTrickle?(sessionId,iceCandidate)
				}catch{
					print("Failed to trickle candidate", error)
				}
			}
		})
		
		connections.value[streamRoomId]![type] = JanusConnection(
			peerConnection: pc,
			sessionId: sessionId,
			hasSubscriptions: false)
	}
	
	public func updateSessionForConnection(
		streamRoomId:String,
		connectionType: ConnectionType,
		sessionId: Int64
	) throws -> Void {
		if !connections.value.contains(where: {$0.key == streamRoomId}) || nil == connections.value[streamRoomId]?[connectionType] {
			try initializeConnection(
				in: streamRoomId,
				ofType: connectionType,
				sessionId: sessionId)
		}
		connections.value[streamRoomId]?[connectionType]?.sessionId = sessionId
	}
	
	public func hasConnection(
		streamRoomId: String,
		connectionType: ConnectionType
	) throws -> Bool {
		return nil != connections.value[streamRoomId]?[connectionType]
	}
	
	public func getConnectionWithSession(
		streamRoomId:String,
		connectionType: ConnectionType
	)  throws -> JanusConnection {
		if !connections.value.contains(where: {$0.key == streamRoomId})
			|| nil == connections.value[streamRoomId]?[connectionType] {
			try initializeConnection(
				in: streamRoomId,
				ofType: connectionType)
		}
		return connections.value[streamRoomId]![connectionType]!
	}
}
#endif // Streams
