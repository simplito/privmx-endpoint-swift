// MIT License
//
// Copyright (c) 2022 Yury Yaroshevich
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import WebRTC
import AVFoundation

//TODO: Properly implement the AudioDevice, replacing the copied example

// NOTE: Does not cover all corner cases with audio session interruptions, switch between devices etc.
// Please use only as an example
#if os(iOS)
public final class AVAudioEngineRTCAudioDevice: NSObject {
	public let audioSession = AVAudioSession.sharedInstance()

	private var subscribtions: [Any]?
	
	private let queue = DispatchQueue(label: "AVAudioEngineRTCAudioDevice")
	
	private lazy var backgroundPlayer = AVAudioPlayerNode()
	private var backgroundSound: AVAudioPCMBuffer?
	
	private var audioEngine: AVAudioEngine?
	private var audioEngineObserver: Any?
	private var inputEQ = AVAudioUnitEQ(numberOfBands: 2)
	
	private var audioConverer: AVAudioConverter?
	private var audioSinkNode: AVAudioSinkNode?
	private var audioSourceNode: AVAudioSourceNode?
	private var shouldPlay = false
	private var shouldRecord = false
	
	private lazy var audioInputFormat = AVAudioFormat(commonFormat: .pcmFormatInt16,
													  sampleRate: audioSession.sampleRate,
													  channels: AVAudioChannelCount(min(2, audioSession.inputNumberOfChannels)),
													  interleaved: false) {
		didSet {
			guard oldValue != audioInputFormat else { return }
			delegate?.notifyAudioInputParametersChange()
		}
	}
	private lazy var audioOutputFormat = AVAudioFormat(commonFormat: .pcmFormatInt16,
													   sampleRate: audioSession.sampleRate,
													   channels: AVAudioChannelCount(min(2, audioSession.outputNumberOfChannels)),
													   interleaved: false) {
		didSet {
			guard oldValue != audioOutputFormat else { return }
			delegate?.notifyAudioOutputParametersChange()
		}
	}
	private var isInterrupted_ = false
	private var isInterrupted: Bool {
		get {
			queue.sync {
				isInterrupted_
			}
		}
		set {
			queue.sync {
				isInterrupted_ = newValue
			}
		}
	}
	
	var delegate_: RTCAudioDeviceDelegate?
	private var delegate: RTCAudioDeviceDelegate? {
		get {
			queue.sync {
				delegate_
			}
		}
		set {
			queue.sync {
				delegate_ = newValue
			}
		}
	}
	
	public private(set) lazy var inputLatency = audioSession.inputLatency {
		didSet {
			guard oldValue != inputLatency else { return }
			delegate?.notifyAudioInputParametersChange()
		}
	}
	
	public private(set) lazy var outputLatency = audioSession.outputLatency {
		didSet {
			guard oldValue != outputLatency else { return }
			delegate?.notifyAudioOutputParametersChange()
		}
	}
	
	public override init() {
		super.init()
	}
	
	private func shutdownEngine() {
		guard let audioEngine = audioEngine else {
			return
		}
		if audioEngine.isRunning {
			audioEngine.stop()
		}
		if let audioEngineObserver = audioEngineObserver {
			NotificationCenter.default.removeObserver(audioEngineObserver)
			self.audioEngineObserver = nil
		}
		if let audioSinkNode = self.audioSinkNode {
			audioEngine.detach(audioSinkNode)
			self.audioSinkNode = nil
			delegate?.notifyAudioInputInterrupted()
		}
		if let audioSourceNode = audioSourceNode {
			audioEngine.detach(audioSourceNode)
			self.audioSourceNode = nil
			delegate?.notifyAudioOutputInterrupted()
		}
		self.audioEngine = nil
	}
	
	private func updateEngine()  {
		guard let delegate = delegate,
			  shouldPlay || shouldRecord,
			  !isInterrupted else {
			print("Audio Engine must be stopped: shouldPla=\(shouldPlay), shouldRecord=\(shouldRecord), isInterrupted=\(isInterrupted)")
			// measureTime(label: "Shutdown AVAudioEngine") {
			shutdownEngine()
			//}
			return
		}
		
		if let audioEngine = audioEngine, !audioEngine.isInputOutputSampleRatesNativeFor(audioSession: audioSession) {
			print("Shutdown AVAudioEngine to match HW format")
			shutdownEngine()
		}
		
		let useVoiceProcessingAudioUnit = audioSession.supportsVoiceProcessing
		if let audioEngine = audioEngine, audioEngine.inputNode.isVoiceProcessingEnabled != useVoiceProcessingAudioUnit {
			print("Shutdown AVAudioEngine to toggle usage of Voice Processing I/O")
			shutdownEngine()
		}
		
		var audioEngine: AVAudioEngine
		if let engine = self.audioEngine {
			audioEngine = engine
		} else {
			if !useVoiceProcessingAudioUnit {
				configureStereoRecording()
			}
			
			audioEngine = AVAudioEngine()
			audioEngine.isAutoShutdownEnabled = true
			// NOTE: Toggle voice processing state over outputNode, not to eagerly create inputNote.
			// Also do it just after creation of AVAudioEngine to avoid random crashes observed when voice processing changed on later stages.
			if audioEngine.outputNode.isVoiceProcessingEnabled != useVoiceProcessingAudioUnit {
				do {
					// Use VPIO to as I/O audio unit.
					try audioEngine.outputNode.setVoiceProcessingEnabled(useVoiceProcessingAudioUnit)
				}
				catch let e {
					print("setVoiceProcessingEnabled error: \(e)")
					return
				}
			}
			audioEngine.attach(backgroundPlayer)
			audioEngine.attach(inputEQ)
			
			audioEngineObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVAudioEngineConfigurationChange,
																		 object: audioEngine,
																		 queue: nil,
																		 using: { [weak self] notification in
				self?.handleAudioEngineConfigurationChanged()
			})
			
			// audioEngine.dumpState(label: "State of newly created audio engine")
			self.audioEngine = audioEngine
		}
		
		let shouldBypassVoiceProcessing = shouldRecord && !shouldPlay
		if useVoiceProcessingAudioUnit {
			if audioEngine.inputNode.isVoiceProcessingBypassed != shouldBypassVoiceProcessing {
				//measureTime(label: "Change bypass voice processing") {
				audioEngine.inputNode.isVoiceProcessingBypassed = shouldBypassVoiceProcessing
				//}
			}
		}
		
		let ioAudioUnit = audioEngine.outputNode.auAudioUnit
		if ioAudioUnit.isInputEnabled != shouldRecord ||
			ioAudioUnit.isOutputEnabled != shouldPlay {
			if audioEngine.isRunning {
				measureTime(label: "AVAudioEngine stop (to enable/disable AUAudioUnit output/input)") {
					audioEngine.stop()
				}
			}
			
			measureTime(label: "Change input/output enabled/disabled") {
				ioAudioUnit.isInputEnabled = shouldRecord
				ioAudioUnit.isOutputEnabled = shouldPlay
			}
		}
		
		if shouldRecord {
			if audioSinkNode == nil {
				measureTime(label: "Add AVAudioSinkNode") {
					let deliverRecordedData = delegate.deliverRecordedData
					let inputFormat = audioEngine.inputNode.outputFormat(forBus: 1)
					guard inputFormat.isSampleRateAndChannelCountValid else {
						print("Invalid input format: \(inputFormat)")
						return
					}
					audioEngine.connect(audioEngine.inputNode, to: inputEQ, format: inputFormat)
					
					let rtcRecordFormat = AVAudioFormat(commonFormat: .pcmFormatInt16,
														sampleRate: inputFormat.sampleRate,
														channels: inputFormat.channelCount,
														interleaved: true)!
					audioInputFormat = rtcRecordFormat
					inputLatency = audioSession.inputLatency
					
					// NOTE: AVAudioSinkNode provides audio data with HW sample rate in 32-bit float format,
					// WebRTC requires 16-bit int format, so do the conversion
					let converter = SimpleAudioConverter(from: inputFormat, to: rtcRecordFormat)!
					
					let customRenderBlock: RTCAudioDeviceRenderRecordedDataBlock = { actionFlags, timestamp, inputBusNumber, frameCount, abl, renderContext in
						let (converter, inputData) = renderContext!.assumingMemoryBound(to: (Unmanaged<SimpleAudioConverter>, UnsafeMutablePointer<AudioBufferList>).self).pointee
						return converter.takeUnretainedValue().convert(framesCount: frameCount, from: inputData, to: abl)
					}
					
					let audioSink = AVAudioSinkNode(receiverBlock: { (timestamp, framesCount, inputData) -> OSStatus in
						var flags: UInt32 = 0
						var renderContext = (Unmanaged.passUnretained(converter), inputData)
						return deliverRecordedData(&flags, timestamp, 1, framesCount, nil, &renderContext, customRenderBlock)
					})
					
					measureTime(label: "Attach AVAudioSinkNode") {
						audioEngine.attach(audioSink)
					}
					
					measureTime(label: "Connect AVAudioSinkNode") {
						audioEngine.connect(inputEQ, to: audioSink, format: inputFormat)
					}
					
					audioSinkNode = audioSink
				}
			}
		} else {
			if let audioSinkNode = audioSinkNode {
				audioEngine.detach(audioSinkNode)
				self.audioSinkNode = nil
			}
		}
		
		if shouldPlay {
			if audioSourceNode == nil {
				measureTime(label: "Add AVAudioSourceNode") {
					let outputFormat = audioEngine.outputNode.outputFormat(forBus: 0)
					guard outputFormat.isSampleRateAndChannelCountValid else {
						print("Invalid audio output format detected: \(outputFormat)")
						return
					}
					print("Playout format: \(outputFormat)")
					audioEngine.connect(audioEngine.mainMixerNode, to: audioEngine.outputNode, format: outputFormat)
					
					let rtcPlayFormat = AVAudioFormat(commonFormat: .pcmFormatInt16,
													  sampleRate: outputFormat.sampleRate,
													  channels: outputFormat.channelCount,
													  interleaved: true)!
					
					audioOutputFormat = rtcPlayFormat
					inputLatency = audioSession.inputLatency
					
					let getPlayoutData = delegate.getPlayoutData
					let audioSource = AVAudioSourceNode(format: rtcPlayFormat,
														renderBlock: { (isSilence, timestamp, frameCount, outputData) -> OSStatus in
						var flgs: AudioUnitRenderActionFlags.RawValue = 0
						let res = getPlayoutData(&flgs, timestamp, 0, frameCount, outputData)
						guard noErr == res else {
							return res
						}
						var flags = AudioUnitRenderActionFlags(rawValue: flgs)
						isSilence.initialize(to: ObjCBool(flags.contains(AudioUnitRenderActionFlags.unitRenderAction_OutputIsSilence)))
						return noErr
					})
					
					measureTime(label: "Attach AVAudioSourceNode") {
						audioEngine.attach(audioSource)
					}
					
					measureTime(label: "Connect AVAudioSourceNode") {
						audioEngine.connect(audioSource, to: audioEngine.mainMixerNode, format: outputFormat)
					}
					
					self.audioSourceNode = audioSource
				}
			}
		} else {
			if let audioSourceNode = audioSourceNode {
				audioEngine.detach(audioSourceNode)
				self.audioSourceNode = nil
			}
		}
		
		if !audioEngine.isRunning {
			measureTime(label: "Prepare AVAudioEngine") {
				audioEngine.prepare()
			}
			
			measureTime(label: "Start AVAudioEngine") {
				do {
					try audioEngine.start()
				} catch let e {
					print("Unable to start audio engine: \(e)")
				}
			}
			
			if let backgroundSound = backgroundSound, audioEngine.isRunning, shouldPlay {
				measureTime(label: "Background music") {
					audioEngine.disconnectNodeOutput(backgroundPlayer)
					audioEngine.connect(backgroundPlayer, to: audioEngine.mainMixerNode, format: nil)
					if !backgroundPlayer.isPlaying {
						backgroundPlayer.play()
						backgroundPlayer.scheduleBuffer(backgroundSound, at: nil, options: [.loops], completionHandler: nil)
					}
				}
			}
		}
		
		audioEngine.dumpState(label: "After updateEngine")
	}
	
	private func handleAudioEngineConfigurationChanged() {
		guard let delegate = delegate else {
			return
		}
		delegate.dispatchAsync { [weak self] in
			self?.updateEngine()
		}
	}
}

extension AVAudioEngineRTCAudioDevice: RTCAudioDevice {

  public var deviceInputSampleRate: Double {
	guard let sampleRate = audioInputFormat?.sampleRate, sampleRate > 0 else {
	  return audioSession.sampleRate
	}
	return sampleRate
  }

  public var deviceOutputSampleRate: Double {
	guard let sampleRate = audioOutputFormat?.sampleRate, sampleRate > 0 else {
	  return audioSession.sampleRate
	}
	return sampleRate
  }

	public var inputIOBufferDuration: TimeInterval { audioSession.ioBufferDuration }

	public var outputIOBufferDuration: TimeInterval { audioSession.ioBufferDuration }

	public var inputNumberOfChannels: Int {
	guard let channelCount = audioInputFormat?.channelCount, channelCount > 0 else {
	  return min(2, audioSession.inputNumberOfChannels)
	}
	return Int(channelCount)
  }

	public var outputNumberOfChannels: Int {
	guard let channelCount = audioOutputFormat?.channelCount, channelCount > 0 else {
	  return min(2, audioSession.outputNumberOfChannels)
	}
	return Int(channelCount)
  }

	public var isInitialized: Bool {
	self.delegate != nil
  }

	public func initialize(with delegate: RTCAudioDeviceDelegate) -> Bool {
		guard self.delegate == nil else {
			print("Already inititlized")
			return false
		}
		
		if subscribtions == nil {
			subscribtions = self.subscribeAudioSessionNotifications()
		}
		
		self.delegate = delegate
		
		if let fxURL = Bundle.main.url(forResource: "Synth", withExtension: "aif") {
			backgroundSound = getBuffer(fileURL: fxURL)
		}
		return true
	}

	public func terminateDevice() -> Bool {
		if let subscribtions = subscribtions {
			self.unsubscribeAudioSessionNotifications(observers: subscribtions)
		}
		subscribtions = nil
		
		shouldPlay = false
		shouldRecord = false
		measureTime {
			updateEngine()
		}
		delegate = nil
		return true
	}

	public var isPlayoutInitialized: Bool { isInitialized }

	public func initializePlayout() -> Bool {
	return isPlayoutInitialized
  }

	public var isPlaying: Bool {
	shouldPlay
  }

	public func startPlayout() -> Bool {
	print("Start playout")
	shouldPlay = true
	measureTime {
	  updateEngine()
	}
	return true
  }

	public func stopPlayout() -> Bool {
		print("Stop playout")
		shouldPlay = false
		measureTime {
			updateEngine()
		}
		return true
	}

	public var isRecordingInitialized: Bool { isInitialized }

	public func initializeRecording() -> Bool {
		return isRecordingInitialized
	}

	public var isRecording: Bool {
	shouldRecord
  }

	public func startRecording() -> Bool {
	print("Start recording")
	shouldRecord = true
	measureTime {
	  updateEngine()
	}
	return true
  }

	public func stopRecording() -> Bool {
	print("Stop recording")
	shouldRecord = false
	measureTime {
	  updateEngine()
	}
	return true
  }
}

extension AVAudioEngineRTCAudioDevice: AudioSessionHandler {
	public func handleInterruptionBegan(applicationWasSuspended: Bool) {
	guard !applicationWasSuspended else {
	  // NOTE: Not an actual interruption
	  return
	}
	isInterrupted = true
	guard let delegate = delegate else {
	  return
	}
	delegate.dispatchAsync { [weak self] in
	  self?.updateEngine()
	}
  }

	public func handleInterruptionEnd(shouldResume: Bool) {
	isInterrupted = false
	guard let delegate = delegate else {
	  return
	}
	delegate.dispatchAsync { [weak self] in
	  self?.updateEngine()
	}
  }

	public func handleAudioRouteChange() {
  }

	public func handleMediaServerWereReset() {
  }

	public func handleMediaServerWereLost() {
  }
}

//MARK: - UTILS

extension DispatchTimeInterval: CustomDebugStringConvertible {
  public var debugDescription: String {
	switch self {
	case .seconds(let secs):
	  return "\(secs) secs"
	case .milliseconds(let ms):
	  return "\(ms) ms"
	case .microseconds(let us):
	  return "\(Double(us) / 1000.0) ms"
	case .nanoseconds(let ns):
	  return "\(Double(ns) / 1_000_000.0) ms"
	case .never:
	  return "never"
	@unknown default:
	  return ""
	}
  }
}

func measureTime<Result>(label: String = #function, block: () -> Result) -> Result {
  let start = DispatchTime.now()
  let result = block()
  let end = DispatchTime.now()
  let duration = start.distance(to: end)
  print("Executed \(label) within \(duration.debugDescription)")
  return result
}

func getBuffer(fileURL: URL) -> AVAudioPCMBuffer? {
  let file: AVAudioFile!
  do {
	try file = AVAudioFile(forReading: fileURL)
  } catch {
	print("Could not load file: \(error)")
	return nil
  }
  file.framePosition = 0
  
  // Add 100 ms to the capacity.
  let bufferCapacity = AVAudioFrameCount(file.length)
  + AVAudioFrameCount(file.processingFormat.sampleRate * 0.1)
  guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat,
									  frameCapacity: bufferCapacity) else { return nil }
  do {
	try file.read(into: buffer)
  } catch {
	print("Could not load file into buffer: \(error)")
	return nil
  }
  file.framePosition = 0
  return buffer
}

extension AVAudioSession {

  public var supportsVoiceProcessing: Bool {
	self.category == .playAndRecord && (self.mode == .voiceChat || self.mode == .videoChat)
  }

  public var describedState: String {
	var description = "AudioSession: category=\(self.category.rawValue)" +
	  ", mode=\(self.mode.rawValue)" +
	  ", options=\(self.categoryOptions.rawValue)" +
	  ", preferredSampleRate=\(self.preferredSampleRate)" +
	  ", sampleRate=\(self.sampleRate)" +
	  ", preferredIOBufferDuration=\(self.preferredIOBufferDuration)" +
	  ", ioBufferDuration=\(self.ioBufferDuration)" +
	  ", preferredInputNumberOfChannels=\(self.preferredInputNumberOfChannels)" +
	  ", isInputAvailable=\(self.isInputAvailable)" +
	  ", inputNumberOfChannels=\(self.inputNumberOfChannels)" +
	  ", maximumInputNumberOfChannels=\(self.maximumInputNumberOfChannels)" +
	  ", preferredOutputNumberOfChannels=\(self.preferredOutputNumberOfChannels)" +
	  ", outputNumberOfChannels=\(self.outputNumberOfChannels)" +
	  ", maximumOutputNumberOfChannels=\(self.maximumOutputNumberOfChannels)" +
	  ", allowHapticsAndSystemSoundsDuringRecording=\(self.allowHapticsAndSystemSoundsDuringRecording)"

	if #available(iOS 14.5, *) {
	  description += ", prefersNoInterruptionsFromSystemAlerts=\(self.prefersNoInterruptionsFromSystemAlerts)"
	}
	description +=
	  ", currentRoute=\(self.currentRoute)"
	return description
  }
}

extension AVAudioEngine {
	public  func dumpState(label: String) {
		print("\(label): \(self.debugDescription)")
	}
	
	public func isInputOutputSampleRatesNativeFor(audioSession: AVAudioSession) -> Bool {
		let hardwareSampleRate = audioSession.sampleRate
		let inputSampleRate = self.inputNode.inputFormat(forBus: 1).sampleRate
		let outputSampleRate = self.outputNode.outputFormat(forBus: 0).sampleRate
		return inputSampleRate == hardwareSampleRate && outputSampleRate == hardwareSampleRate
	}
	
	public func isInputOutputSampleRatesWorseThan(audioSession: AVAudioSession) -> Bool {
		let hardwareSampleRate = audioSession.sampleRate
		let inputSampleRate = self.inputNode.inputFormat(forBus: 1).sampleRate
		let outputSampleRate = self.outputNode.outputFormat(forBus: 0).sampleRate
		return inputSampleRate < hardwareSampleRate && outputSampleRate < hardwareSampleRate
	}
}

extension AUAudioUnit {
  public func dumpState(label: String) {
	print("\(label): audioUnit.inputBusses[0].format = \(self.inputBusses[0].format)")
	print("\(label): audioUnit.inputBusses[1].format = \(self.inputBusses[1].format)")
	print("\(label): audioUnit.outputBusses[0].format = \(self.outputBusses[0].format)")
	print("\(label): audioUnit.outputBusses[1].format = \(self.outputBusses[1].format)")
  }
}

extension AVAudioFormat {
 public var isSampleRateAndChannelCountValid: Bool {
	!sampleRate.isZero && !sampleRate.isNaN && sampleRate.isFinite && channelCount > 0
  }
}


//MARK: - AUDIO CONVERTER
import Foundation
import CoreAudioTypes
import AVFAudio

public final class SimpleAudioConverter {
  public let from: AVAudioFormat
  public let to: AVAudioFormat
 nonisolated(unsafe) private var audioConverter: AudioConverterRef?

  public init?(from: AVAudioFormat, to: AVAudioFormat) {
	guard from.sampleRate == to.sampleRate else {
	  print("Sample rate conversion is not possible")
	  return nil
	}
	guard noErr == AudioConverterNew(from.streamDescription, to.streamDescription, &audioConverter) else {
	  return nil
	}
	self.from = from
	self.to = to
  }

  deinit {
	if let audioConverter = audioConverter {
	  AudioConverterDispose(audioConverter)
	}
	audioConverter = nil
  }

  public func convert(framesCount: AVAudioFrameCount, from: UnsafePointer<AudioBufferList>, to: UnsafeMutablePointer<AudioBufferList>) -> OSStatus {
	guard let audioConverter = audioConverter else {
	  preconditionFailure("Not properly inited")
	}
	let status = AudioConverterConvertComplexBuffer(audioConverter, framesCount, from, to)
	return status
  }
}

//MARK: - Audio Session handler

protocol AudioSessionHandler: AnyObject {
  var audioSession: AVAudioSession { get }
  
  func handleInterruptionBegan(applicationWasSuspended: Bool)
  
  func handleInterruptionEnd(shouldResume: Bool)
  
  func handleAudioRouteChange()
  
  func handleMediaServerWereReset()
  
  func handleMediaServerWereLost()
}

extension AudioSessionHandler {
  func subscribeAudioSessionNotifications() -> [Any] {
	let center = NotificationCenter.default
	let interruptionNotificationSubscribtion = center.addObserver(forName: AVAudioSession.interruptionNotification,
																  object: audioSession,
																  queue: nil) { [weak self] notification in
	  guard let self = self else {
		return
	  }
	  print(AVAudioSession.interruptionNotification)
	  guard let type = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? NSNumber,
			let interruptionType: AVAudioSession.InterruptionType = .init(rawValue: type.uintValue) else {
		print("Ignoring \(notification)")
		return
	  }
	  switch interruptionType {
	  case .began:
		var applicationWasSuspended: Bool = false
		if #available(iOS 14.5, *) {
		  if let rawReason = notification.userInfo?[AVAudioSessionInterruptionReasonKey] as? NSNumber,
			 let reason: AVAudioSession.InterruptionReason = .init(rawValue: rawReason.uintValue) {
			applicationWasSuspended = reason == .appWasSuspended
		  }
		} else {
		  if let wasSuspended = notification.userInfo?[AVAudioSessionInterruptionWasSuspendedKey] as? NSNumber, wasSuspended.boolValue {
			applicationWasSuspended = true
		  }
		}
		self.handleInterruptionBegan(applicationWasSuspended: applicationWasSuspended)
	  case .ended:
		var shouldResume = false
		if let type = notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? NSNumber {
		  let interruptionOptions: AVAudioSession.InterruptionOptions = .init(rawValue: type.uintValue)
		  shouldResume = interruptionOptions.contains(.shouldResume)
		}
		self.handleInterruptionEnd(shouldResume: shouldResume)
	  @unknown default:
		return
	  }
	  
	}
	let routeChangeNotificationSubscribtion = center.addObserver(forName: AVAudioSession.routeChangeNotification,
																 object: audioSession,
																 queue: nil) { [weak self] notification in
	  guard let self = self else {
		return
	  }
	  print("\(AVAudioSession.routeChangeNotification): \(notification) -> \(self.audioSession.describedState)")
	  self.handleAudioRouteChange()
	}
	
	let mediaServicesWereLostNotificationSubscribtion = center.addObserver(forName: AVAudioSession.mediaServicesWereLostNotification,
																		   object: audioSession,
																		   queue: nil) { [weak self] notification in
	  print(AVAudioSession.mediaServicesWereLostNotification)
	  guard let self = self else {
		return
	  }
	  self.handleMediaServerWereLost()
	}
	let mediaServicesWereResetNotificationSubscribtion = center.addObserver(forName: AVAudioSession.mediaServicesWereResetNotification,
																			object: audioSession,
																			queue: nil) { [weak self] notification in
	  print(AVAudioSession.mediaServicesWereResetNotification)
	  guard let self = self else {
		return
	  }
	  self.handleMediaServerWereReset()
	}
	
	return [
	  interruptionNotificationSubscribtion,
	  routeChangeNotificationSubscribtion,
	  mediaServicesWereLostNotificationSubscribtion,
	  mediaServicesWereResetNotificationSubscribtion
	]
  }
  
  func unsubscribeAudioSessionNotifications(observers: [Any]) {
	let center = NotificationCenter.default
	for observer in observers {
	  center.removeObserver(observer)
	}
  }

  func configureStereoRecording() {
	// Find the built-in microphone input.
	guard let availableInputs = audioSession.availableInputs,
		  let builtInMicInput = availableInputs.first(where: { $0.portType == .builtInMic }) else {
	  print("The device must have a built-in microphone.")
	  return
	}
	
	// Make the built-in microphone input the preferred input.
	do {
	  try audioSession.setPreferredInput(builtInMicInput)
	} catch {
	  print("Unable to set the built-in mic as the preferred input.")
	  return
	}
	
	
	guard let preferredInput = audioSession.preferredInput,
		  let dataSources = preferredInput.dataSources,
		  let frontStereo = dataSources.first(where: { $0.orientation == .front }),
		  let supportedPolarPatterns = frontStereo.supportedPolarPatterns else {
	  print("No polar patterns.")
	  return
	}
	var isStereoSupported = false
	do {
	  isStereoSupported = supportedPolarPatterns.contains(.stereo)
	  // If the data source supports stereo, set it as the preferred polar pattern.
	  if isStereoSupported {
		// Set the preferred polar pattern to stereo.
		try frontStereo.setPreferredPolarPattern(.stereo)
	  }
	  
	  // Set the preferred data source and polar pattern.
	  try preferredInput.setPreferredDataSource(frontStereo)
	  
	  // Update the input orientation to match the current user interface orientation.
	  try audioSession.setPreferredInputOrientation(.portrait)
	  
	} catch {
	  fatalError("Unable to select the \(frontStereo.dataSourceName) data source.")
	}
  }
}
#endif
