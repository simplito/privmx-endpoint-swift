//
//  PMXAudioPlayer.swift
//  privmx-endpoint-swift
//
//  Created by Simplito on 22/01/2026.
//

import WebRTC
import AVFoundation

public final class PMXAudioPlayer: NSObject, RTCAudioRenderer{
	public let node: AVAudioPlayerNode = AVAudioPlayerNode()
	public func render(pcmBuffer: AVAudioPCMBuffer) {
		do{
			print("scheduling")
			try node.scheduleBuffer(pcmBuffer)
		}catch {
			print(error)
			print("Failed scheduling")
		}
	}
}
