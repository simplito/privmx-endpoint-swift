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
import os.lock

public final class PeerConnectionManager: Sendable {
	enum State{
		case reading,writing
		case idle
	}
	private let mutex = OSAllocatedUnfairLock(initialState: State.idle)
	private let _createPeerConnection : (@Sendable (String) -> PeerConnection)
	private let _onTrickle : (@Sendable (Int64,String) throws -> Void)
	nonisolated(unsafe) private var _connections : [String : [ConnectionType:JanusConnection]] = [:]
	nonisolated private var connections : [String : [ConnectionType:JanusConnection]]{
		set(val) {
			mutex.withLockUnchecked{
				state in
				state = .writing
				_connections = val
				state = .idle
			}
		}
		get {
			mutex.withLock{
				state in
				defer{
					state = .idle
				}
				state = .reading
				return _connections
			}
			
		}
	}
	
	init(
		_createPeerConnection: @Sendable @escaping (String) -> PeerConnection,
		_onTrickle: (@Sendable @escaping (Int64,String) throws -> Void)
	) {
		self._createPeerConnection = _createPeerConnection
		self._onTrickle = _onTrickle
	}
	
	public func initializeConnection(
		in streamRoomId: String,
		ofType type: ConnectionType,
		sessionId: Int64 = -1
	) throws {
		if connections.contains(where: {$0 == streamRoomId && $1.keys.contains(type)}){
			throw PrivMXEndpointError.failedInitializingPeerConnection(privmx.InternalError(
				name: "Already Initialized",
				message: "JanusConnection with given parameters already initialized",
				description: "", code: nil, scope: nil))
		}
		if !connections.keys.contains(streamRoomId){
			connections[streamRoomId] = [:]
		}
		
		let pc = _createPeerConnection(streamRoomId)
		
		
		pc.rtcPeerConnectionObserver.setIceCandidateGeneratedCallback({
			peerConnection,candidate in
			
			let roomConnections = self.connections[streamRoomId] ?? [:]
			let roomConnection = roomConnections[type]
			if !candidate.sdp.isEmpty,let sessionId = roomConnection?.sessionId, sessionId > -1{
				var iceCandidate = candidate.sdp
				try? self._onTrickle(sessionId,iceCandidate)
			}
		})
		
		connections[streamRoomId]![type] = JanusConnection(
			peerConnection: pc,
			sessionId: sessionId,
			hasSubscriptions: false)
	}
	
	public func updateSessionForConnection(
		streamRoomId:String,
		connectionType: ConnectionType,
		sessionId: Int64
	) throws -> Void {
		if !connections.contains(where: {$0.key == streamRoomId}) || nil == connections[streamRoomId]?[connectionType] {
			try initializeConnection(
				in: streamRoomId,
				ofType: connectionType,
				sessionId: sessionId)
		}
		connections[streamRoomId]?[connectionType]?.sessionId = sessionId
	}
	
	public func hasConnection(
		streamRoomId: String,
		connectionType: ConnectionType
	) throws -> Bool {
		return nil != connections[streamRoomId]?[connectionType]
	}
	
	public func getConnectionWithSession(
		streamRoomId:String,
		connectionType: ConnectionType
	)  throws -> JanusConnection {
		if !connections.contains(where: {$0.key == streamRoomId})
			|| nil == connections[streamRoomId]?[connectionType] {
			try initializeConnection(
				in: streamRoomId,
				ofType: connectionType)
		}
		return connections[streamRoomId]![connectionType]!
	}
}
#endif // Streams
