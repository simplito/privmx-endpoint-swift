//
// PrivMX Endpoint Swift
// Copyright © 2024 Simplito sp. z o.o.
//
// This file is part of the PrivMX Platform (https://privmx.cloud).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//


/// Errors thrown by PrivMX Endpoint Swift.
///
/// Cases have the descriptions of thrown errors as associated values. Additionally each case corresponds to a method.
public enum PrivMXEndpointError : Error{
	case otherFailure(msg:String)
	
	case failedEncrypting(msg:String)
	case failedDecrypting(msg:String)
    case failedSigning(msg:String)
    case failedGeneratingPubKey(msg:String)
	case failedGeneratingPrivKey(msg:String)
	case failedConvertingKeyToWIF(msg:String)

	case failedConnecting(msg:String)
	case failedDisconnecting(msg:String)
	case failedListingContexts(msg:String)
	case failedCreatingThread(msg:String)
	case failedGettingThread(msg:String)
	case failedListingThreads(msg:String)
	case failedGettingMessage(msg:String)
	case failedListingMessages(msg:String)
	case failedCreatingMessage(msg:String)
	case failedUpdatingThread(msg:String)
	
	case failedListingStores(msg:String)
	case failedGettingStore(msg:String)
	case failedCreatingStore(msg:String)
	case failedUpdatingStore(msg:String)
	
	case failedGettingFile(msg:String)
	case failedListingFiles(msg:String)
	case failedCreatingFile(msg:String)
	case failedUpdatingFile(msg:String)
	case failedOpeningFile(msg:String)
	case failedReadingFromFile(msg:String)
	case failedSeekingInFile(msg:String)
	case failedWritingToFile(msg:String)
	case failedClosingFile(msg:String)
	case failedDeletingFile(msg:String)
	
	case failedWaitingForEvent(msg:String)
	case failedGettingEvent(msg:String)
	
	case failedSubscribingToChannel(msg:String)
	case failedUnsubscribingFromChannel(msg:String)
	
	case failedDeletingThread(msg:String)
	case failedDeletingMessage(msg:String)
	case failedDeletingStore(msg:String)
	
	case failedQueryingEventHolder(msg:String)
	case failedExtractingEventFromHolder(msg:String)
	
	case failedSettingCerts(msg:String)
	
	/// Gets the description of the error
	///
	///  - Returns: String description of the error
	func getMessage() -> String{
		switch self{
		case .failedClosingFile(let msg):
			return msg
		case .otherFailure(msg: let msg):
			return msg
		case .failedEncrypting(msg: let msg):
			return msg
		case .failedDecrypting(msg: let msg):
			return msg
		case .failedSigning(msg: let msg):
			return msg
		case .failedGeneratingPubKey(msg: let msg):
			return msg
		case .failedGeneratingPrivKey(msg: let msg):
			return msg
		case .failedConvertingKeyToWIF(msg: let msg):
			return msg
		case .failedConnecting(msg: let msg):
			return msg
		case .failedDisconnecting(msg: let msg):
			return msg
		case .failedListingContexts(msg: let msg):
			return msg
		case .failedCreatingThread(msg: let msg):
			return msg
		case .failedGettingThread(msg: let msg):
			return msg
		case .failedListingThreads(msg: let msg):
			return msg
		case .failedListingMessages(msg: let msg):
			return msg
		case .failedCreatingMessage(msg: let msg):
			return msg
		case .failedGettingMessage(msg: let msg):
			return msg
		case .failedUpdatingThread(msg: let msg):
			return msg
		case .failedListingStores(msg: let msg):
			return msg
		case .failedGettingStore(msg: let msg):
			return msg
		case .failedCreatingStore(msg: let msg):
			return msg
		case .failedGettingFile(msg: let msg):
			return msg
		case .failedListingFiles(msg: let msg):
			return msg
		case .failedCreatingFile(msg: let msg):
			return msg
		case .failedUpdatingFile(msg: let msg):
			return msg
		case .failedOpeningFile(msg: let msg):
			return msg
		case .failedReadingFromFile(msg: let msg):
			return msg
		case .failedSeekingInFile(msg: let msg):
			return msg
		case .failedWritingToFile(msg: let msg):
			return msg
		case .failedDeletingFile(msg: let msg):
			return msg
		case .failedWaitingForEvent(msg: let msg):
			return msg
		case .failedGettingEvent(msg: let msg):
			return msg
		case .failedSubscribingToChannel(msg: let msg):
			return msg
		case .failedUnsubscribingFromChannel(msg: let msg):
			return msg
		case .failedDeletingThread(msg: let msg):
			return msg
		case .failedDeletingMessage(msg: let msg):
			return msg
		case .failedDeletingStore(msg: let msg):
			return msg
		case .failedSettingCerts(msg: let msg):
			return msg
		case .failedUpdatingStore(msg: let msg):
			return msg
		case .failedQueryingEventHolder(msg: let msg):
			return msg
		case .failedExtractingEventFromHolder(msg: let msg):
			return msg
		}
	}
}
