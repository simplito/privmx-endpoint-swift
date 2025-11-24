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

import Foundation
import PrivMXEndpointSwiftNative
import PrivMXEndpointStreamsLow
import WebRTC

class FrameImpl{
	private var _frame : RTCVideoFrame
	public var cxxImpl : privmx.FrameImpl
	init(_frame: RTCVideoFrame) {
		self._frame = _frame
		self.cxxImpl = privmx.FrameImpl{
			dst_argb,dst_stride_argb,dest_width,dest_height in
			
			
			
			RTCYUVHelper.i420(
				toARGB: <#T##UnsafePointer<UInt8>!#>,
				srcStrideY: <#T##Int32#>,
				srcU: <#T##UnsafePointer<UInt8>!#>,
				srcStrideU: <#T##Int32#>,
				srcV: <#T##UnsafePointer<UInt8>!#>,
				srcStrideV: <#T##Int32#>,
				dstARGB: dst_argb,
				dstStrideARGB: dst_stride_argb,
				width: <#T##Int32#>,
				height: <#T##Int32#>)
		}
	}
	
}

public final class WebRTCNativeInterface: Sendable {
	nonisolated(unsafe) private var api : privmx.SharedWebRTCInterfaceInstance
	nonisolated(unsafe) private var peerConnectionFactory: RTCPeerConnectionFactory
	nonisolated(unsafe) private var constraints : RTCMediaConstraints
	nonisolated(unsafe) private var onTrickle : @Sendable (Int64, String) -> Void
	nonisolated(unsafe) private var peerConnectionManager: PeerConnectionManager
	
	init(
		api: privmx.SharedWebRTCInterfaceInstance,
		peerConnectionFactory: RTCPeerConnectionFactory,
		constraints: RTCMediaConstraints,
		onTrickle: @escaping @Sendable (Int64, String) -> Void,
		peerConnectionManager: PeerConnectionManager) {
		self.api = api
		self.peerConnectionFactory = peerConnectionFactory
		self.constraints = constraints
		self.onTrickle = onTrickle
		self.peerConnectionManager = PeerConnectionManager(
			_createPeerConnection:{
				streamRoomId in
				peerConnectionFactory
				
			},
		_onTrickle: onTrickle)
	}
}
