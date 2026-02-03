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
import WebRTC
import Foundation

public class PMXFrameCryptorDelegate: PMXFrameCryptorObserver{
	public func onFrameCryptionStateChanged(_ state: PMXFrameCryptionState) {
	// TODO: implement onFrameCryptionStateChanged
		print("FrameCryptionState changed to ",state, state.rawValue)
	}
}

// #endif
