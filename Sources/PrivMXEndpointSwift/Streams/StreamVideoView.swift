
import PrivMXEndpointStreamsLow
import WebRTC
import SwiftUI
#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

#if os(macOS)
public class VideoViewController: NSViewController {
	var remoteVideoTrack: RTCVideoTrack?
	var remoteVideoView: RTCMTLVideoView?
	
	override public func viewDidLoad() {
		super.viewDidLoad()

		self.remoteVideoView = RTCMTLVideoView(frame: self.view.frame)
		if let remoteVideoView = self.remoteVideoView {
			self.view.addSubview(remoteVideoView)
		}
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
		nsView.remoteVideoView?.isEnabled = true
	}
}

#elseif os(iOS)
public class VideoViewController: UIViewController {
	var remoteVideoTrack: RTCVideoTrack?
	var remoteVideoView: RTCMTLVideoView?

	override public func viewDidLoad() {
		super.viewDidLoad()

		self.remoteVideoView = RTCMTLVideoView(frame: self.view.frame)
		if let remoteVideoView = self.remoteVideoView {
			self.view.addSubview(remoteVideoView)
		}
	}
}
public struct StreamVideoView:UIViewControllerRepresentable {
	public typealias UIViewControllerType = VideoViewController
	
	//public typealias UIViewType = VideoViewController
	@Binding var videoTrack: RTCVideoTrack?
	
	let t :test
	init(
		videoTrack: Binding<RTCVideoTrack?>,
		t: test
	) {
		self._videoTrack = videoTrack
		self.t = t
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
		nsView.remoteVideoView?.isEnabled = true
	}
}
#endif
