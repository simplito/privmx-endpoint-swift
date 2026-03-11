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

#if os(macOS)
import WebRTC
import ScreenCaptureKit
import PrivMXEndpointSwiftNative


final class StreamOutput:NSObject, SCStreamOutput{
	weak var capturer: PMXDesktopCapturer?
	public func stream(
		_ stream: SCStream,
		didOutputSampleBuffer sampleBuffer: CMSampleBuffer,
		of type: SCStreamOutputType
	) -> Void {
		if type == SCStreamOutputType.screen{
			if let imbuf = CMSampleBufferGetImageBuffer(sampleBuffer), let capturer{
				let pixbuf = RTCCVPixelBuffer(pixelBuffer: imbuf)
				
				capturer.delegate?.capturer(capturer, didCapture: RTCVideoFrame(
					buffer: pixbuf,
					rotation: RTCVideoRotation._0,
					timeStampNs: Int64(sampleBuffer.decodeTimeStamp.value)))
			}
		}
	}

}

public final class PMXDesktopCapturer: RTCVideoCapturer, @unchecked Sendable{

	private var sampleHandlerQueue = DispatchQueue(label: "sample_handler")
	//private var audioSource: RTCAudioSource?
	nonisolated(unsafe) private let stream: SCStream
	var x : RTCMediaSource?
	let output = StreamOutput()
	public init(
		videoDelegate: RTCVideoCapturerDelegate,
		//audioDelegate: RTCAudioSource? = nil,
		filter: SCContentFilter,
		configuration: SCStreamConfiguration
	) throws {
		if configuration.pixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange{
			throw PrivMXEndpointError.otherFailure(privmx.InternalError.init(name: "Illegal pixel format", message: "", description: ""))
		}
		//self.audioSource = audioDelegate
		self.stream = SCStream(
			filter: filter,
			configuration: configuration,
			delegate: nil)
		super.init(delegate: videoDelegate)
	}
	
	public func updateFilter(
		_ filter: SCContentFilter
	) async throws -> Void {
		try await stream.updateContentFilter(filter)
	}
	
	
	public func updateConfiguration(
		_ config: SCStreamConfiguration
	) async throws -> Void {
		try await stream.updateConfiguration(config)
	}
	
	public func startRecording(
	) throws -> Void {
		if nil == output.capturer{
			output.capturer = self
		}
		try stream.addStreamOutput(
			output,
			type: .screen,
			sampleHandlerQueue: sampleHandlerQueue)
		Task{
			try await stream.startCapture()
		}
	}
	
}
#endif
