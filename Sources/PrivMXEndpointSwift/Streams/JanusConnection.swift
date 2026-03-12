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
import PrivMXEndpointSwiftNative
import WebRTC

public class JanusConnection: @unchecked Sendable{
	var peerConnection : RTCPeerConnection
	var peerConnectionDelegate: PMXPeerConnectionDelegate
	var sessionId: Int64 = -1
	init(
		peerConnection: RTCPeerConnection,
		peerConnectionDelegate:PMXPeerConnectionDelegate,
	) {
		self.peerConnection = peerConnection
		self.peerConnectionDelegate = peerConnectionDelegate
	}
	
	func reconfigure(
		sdp: String,
		type: String,
		roomId:String
	) async throws -> privmx.endpoint.stream.SdpWithRoomModel{
		throw PrivMXEndpointError.otherFailure(.init(name: "Not implemented in base", message: "Call this method on Publisher or Sender", description: ""))
	}
	
	func updateSessionId(
		_ sid: Int64
	) -> Void {
		self.sessionId = sid
	}
}

public final class JanusPublisher:JanusConnection, @unchecked Sendable{
	var audioTracks: [String: AudioTrackInfo] = [:]
	var videoTracks: [String: VideoTrackInfo] = [:]
	
	override func reconfigure(
		sdp: String,
		type: String,
		roomId:String
	) async throws -> privmx.endpoint.stream.SdpWithRoomModel{
		print("reconfigure peer connection")
		print("reconfigure type: ",type)
		let tp: RTCSdpType = switch type {
			case "answer","Answer":
					.answer
			case "PrAnswer","pranswer","prAnswer":
					.prAnswer
			case "Offer","offer":
					.offer
			case "rollback","Rollback":
					.rollback
			default:
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "Unknown Type", message: "", description: "got \(type) but couldn't map it to RTCSdpType"))
		}
		
		var pc = self.peerConnection
		
		try await pc.setRemoteDescription(RTCSessionDescription(type: tp, sdp: String(sdp)))
		
		return privmx.endpoint.stream.SdpWithRoomModel(
			roomId: std.string(roomId),
			sdp: std.string(sdp),
			type: std.string(type))
	}
}

public final class JanusSubscriber:JanusConnection, @unchecked Sendable{
	override func reconfigure(
		sdp: String,
		type: String,
		roomId:String
	) async throws -> privmx.endpoint.stream.SdpWithRoomModel{
		print("reconfigure peer connection")
		print("reconfigure type: ",type)
		let tp: RTCSdpType = switch type {
			case "answer","Answer":
					.answer
			case "PrAnswer","pranswer","prAnswer":
					.prAnswer
			case "Offer","offer":
					.offer
			case "rollback","Rollback":
					.rollback
			default:
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(name: "Unknown Type", message: "", description: "got \(type) but couldn't map it to RTCSdpType"))
		}
		
		var pc = self.peerConnection
		
		try await pc.setRemoteDescription(RTCSessionDescription(type: tp, sdp: String(sdp)))
		let ans = try await pc.answer(for: RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: nil))
		
		let atype:std.string = switch ans.type{
			case .answer:
				"answer"
			case .prAnswer:
				"prAnswer"
			case .offer:
				"offer"
			case .rollback:
				"rollback"
			@unknown default:
				throw PrivMXEndpointError.otherFailure(privmx.InternalError(
					name: "Unknown Type",
					message: "",
					description: "got \(type) but couldn't map it to RTCSdpType"))
		}
		let res = privmx.endpoint.stream.SdpWithRoomModel(roomId: std.string(roomId), sdp: std.string(ans.sdp), type: atype)
		
		try await pc.setLocalDescription(ans)
		
		return res
	}
}

// #endif // Streams
