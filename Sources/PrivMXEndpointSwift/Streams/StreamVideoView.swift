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


import PrivMXEndpointSwiftNative
import WebRTC
import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

#if os(macOS)
public class VideoViewController: NSViewController {
	weak var remoteVideoTrack: RTCVideoTrack?{
		didSet{
			if remoteVideoTrack == nil{
				if let remoteVideoView{
					oldValue?.remove(remoteVideoView)
				}
			}
		}
	}
	var remoteVideoView: RTCMTLVideoView?
	
	override public func viewDidLoad() {
		super.viewDidLoad()

		self.remoteVideoView = RTCMTLVideoView(frame: self.view.bounds)
		if let remoteVideoView = self.remoteVideoView {
			self.view.addSubview(remoteVideoView)
		}
	}
	public override func viewDidLayout() {
		remoteVideoView?.frame = self.view.bounds
	}
}


public struct StreamVideoView:NSViewControllerRepresentable {
	public typealias NSViewControllerType = VideoViewController
	@Binding var videoTrack: RTCVideoTrack?
	var videoViewDelegate :RTCVideoViewDelegate?
	
	public init(
		videoTrack: Binding<RTCVideoTrack?>,
		videoViewDelegate: RTCVideoViewDelegate? = nil
	) {
		self._videoTrack = videoTrack
		self.videoViewDelegate = videoViewDelegate
	}
	
	
	public func makeNSViewController(
		context: Context
	) -> VideoViewController {
		var renderer = VideoViewController()
		renderer.remoteVideoTrack?.isEnabled = true
		return renderer
	}
	
	public func updateNSViewController(
		_ nsView: VideoViewController,
		context: Context
	) -> Void {
		nsView.remoteVideoTrack = videoTrack
		if nil != nsView.remoteVideoView{
			videoTrack?.add(nsView.remoteVideoView!)
		}
		let frame = nsView.view.bounds
		nsView.remoteVideoView?.frame = frame
		nsView.remoteVideoView?.isEnabled = true
	}
}

#elseif os(iOS)
public class VideoViewController: UIViewController {
	weak var remoteVideoTrack: RTCVideoTrack?{
		didSet{
			if remoteVideoTrack == nil{
				if let remoteVideoView{
					oldValue?.remove(remoteVideoView)
				}
			}
		}
	}
	var remoteVideoView: RTCMTLVideoView?
	
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()

		self.remoteVideoView = RTCMTLVideoView(frame: self.view.bounds)
		if let remoteVideoView = self.remoteVideoView {
			self.view.addSubview(remoteVideoView)
			remoteVideoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		}
	}
	
	override public func viewDidLayoutSubviews(){
		super.viewDidLayoutSubviews()
		
		self.remoteVideoView?.frame = self.view.bounds
	}
	
}
public struct StreamVideoView:UIViewControllerRepresentable {
	public typealias UIViewControllerType = VideoViewController
	
	//public typealias UIViewType = VideoViewController
	@Binding var videoTrack: RTCVideoTrack?

	weak var videoViewDelegate: RTCVideoViewDelegate?
	public init(
		videoTrack: Binding<RTCVideoTrack?>,
		videoViewDelegate: RTCVideoViewDelegate? = nil
	) {
		self._videoTrack = videoTrack
		self.videoViewDelegate = videoViewDelegate
	}
	public func makeUIViewController(
		context: Context
	) -> VideoViewController {
		print("Made UIview")
		var renderer = VideoViewController()
		renderer.remoteVideoTrack?.isEnabled = true
		return renderer
	}
	
	public func updateUIViewController(
		_ nsView: VideoViewController,
		context: Context
	) -> Void {
		nsView.remoteVideoTrack = videoTrack
		if nil != nsView.remoteVideoView{
			videoTrack?.add(nsView.remoteVideoView!)
		}
		var frame = nsView.view.bounds
		nsView.remoteVideoView?.frame = frame
		nsView.remoteVideoView?.isEnabled = true
	}

}
#endif
