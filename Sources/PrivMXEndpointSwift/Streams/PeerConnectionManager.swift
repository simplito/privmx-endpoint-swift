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
	
	nonisolated(unsafe) var _createPeerConnection : (@Sendable (String) -> (RTCPeerConnection?,PmxPeerConnectionObserver))?
	nonisolated(unsafe) var _onTrickle : (@Sendable (Int64,String) throws -> Void)?
	nonisolated(unsafe) var connections = [String : [ConnectionType:JanusConnection]]()
	
	enum State{
		case reading,writing
		case idle
	}
	
	init(
		_createPeerConnection: (@Sendable (String) -> (RTCPeerConnection?,PmxPeerConnectionObserver))? = nil,
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
		if connections.contains(where: {$0 == streamRoomId && $1.keys.contains(type)}){
			throw PrivMXEndpointError.failedInitializingPeerConnection(privmx.InternalError(
				name: "Already Initialized",
				message: "JanusConnection with given parameters already initialized",
				description: "", code: nil, scope: nil))
		}
		if !connections.keys.contains(streamRoomId){
			connections[streamRoomId] = [:]
		}
		
		guard let tuple = _createPeerConnection?(streamRoomId),let pc = tuple.0
		else {
			throw PrivMXEndpointError.failedInitializingPeerConnection(privmx.InternalError(
				name: "PeerConnection wasn't created",
				message: "",
				description: "",
				code: nil,
				scope: nil))
		}
		var jv = JanusConnection(
			peerConnection: pc,
			sessionId: sessionId,
			delegate: tuple.1,
			hasSubscriptions: false)
		
		jv.delegate.setIceCandidateGeneratedCallback({
			peerConnection,candidate in
			
			let roomConnections = self.connections[streamRoomId] ?? [:]
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
		connections[streamRoomId]![type] = jv
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
