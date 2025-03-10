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

import PrivMXEndpointSwiftNative

/// Errors thrown by PrivMX Endpoint Swift.
///
/// Cases correspond to methods in which rthe error happened.
/// Each case has `privmx.InternalError` as associated value, which holds data about the error.
public enum PrivMXEndpointError : Error{
	/// Represents failure unrelated to methods in PrivmxEndpointSwift package
	case otherFailure(privmx.InternalError)
	
	/// Failed to get Connection ID
	case failedGettingConnectionId(privmx.InternalError)
	
	/// Failed to generate Symmetric Key
	case failedGeneratingSymmetricKey(privmx.InternalError)
	/// Failed to encrypt
	case failedEncrypting(privmx.InternalError)
	/// Failed to decrypt
	case failedDecrypting(privmx.InternalError)
	/// Failed to sign
	case failedSigning(privmx.InternalError)
	/// Failed to verify Signature
	case failedVerifyingSignature(privmx.InternalError)
	/// Failed to create a Public Key
	case failedGeneratingPubKey(privmx.InternalError)
	/// Failed to create a Private Key
	case failedGeneratingPrivKey(privmx.InternalError)
	/// Failed to convert a Key to WIF
	case failedConvertingKeyToWIF(privmx.InternalError)
	
	/// Failed to connect
	case failedConnecting(privmx.InternalError)
	/// Failed to disconnect
	case failedDisconnecting(privmx.InternalError)
	/// Failed to list Contexts
	case failedListingContexts(privmx.InternalError)
	/// Falied to get a list of Users from a Context
	case failedGettingContextUsers(privmx.InternalError)
	
	/// Failed to instantiate `ThreadApi`
	case failedInstantiatingThreadApi(privmx.InternalError)
	/// Failed to create a Thread
	case failedCreatingThread(privmx.InternalError)
	/// Failed to get a Thread
	case failedGettingThread(privmx.InternalError)
	/// Failed to list Threads
	case failedListingThreads(privmx.InternalError)
	/// Failed to get a Message
	case failedGettingMessage(privmx.InternalError)
	/// Failed to list Messages
	case failedListingMessages(privmx.InternalError)
	/// Failed to create a Message
	case failedCreatingMessage(privmx.InternalError)
	/// Failed to update a Thread
	case failedUpdatingThread(privmx.InternalError)
	/// Failed to update a Mesage
	case failedUpdatingMessage(privmx.InternalError)
	
	/// Failed to instantiate `StoreApi`
	case failedInstantiatingStoreApi(privmx.InternalError)
	/// Failed to list Stores
	case failedListingStores(privmx.InternalError)
	/// Failed to get a Store
	case failedGettingStore(privmx.InternalError)
	/// Failed to create a Store
	case failedCreatingStore(privmx.InternalError)
	/// Failed to update a Store
	case failedUpdatingStore(privmx.InternalError)
	
	/// Failed to get a File
	case failedGettingFile(privmx.InternalError)
	/// Failed to list Files
	case failedListingFiles(privmx.InternalError)
	/// Failed to create a File
	case failedCreatingFile(privmx.InternalError)
	/// Failed to update a File
	case failedUpdatingFile(privmx.InternalError)
	/// Failed to open a File
	case failedOpeningFile(privmx.InternalError)
	/// Failed to read from a File
	case failedReadingFromFile(privmx.InternalError)
	/// Failed to seek in a File
	case failedSeekingInFile(privmx.InternalError)
	/// Failed to write to a File
	case failedWritingToFile(privmx.InternalError)
	/// Failed to close a File
	case failedClosingFile(privmx.InternalError)
	/// Failed to delete a File
	case failedDeletingFile(privmx.InternalError)
	
	/// Failed to instantiate `InboxApi`
	case failedInstantiatingInboxApi(privmx.InternalError)
	/// Failed to create an Inbox
	case failedCreatingInbox(privmx.InternalError)
	/// Failed to update an Inbox
	case failedUpdatingInbox(privmx.InternalError)
	/// Failed to delete an Inbox
	case failedDeletingInbox(privmx.InternalError)
	/// Failed to get an Inbox
	case failedGettingInbox(privmx.InternalError)
	/// Failed to get a Public View of an Inbox
	case failedGettingInboxPublicView(privmx.InternalError)
	/// Failed to list Inboxes
	case failedListingInboxes(privmx.InternalError)
	
	/// Failed to prepare an Entry
	case failedPreparingEntry(privmx.InternalError)
	/// Failed to send an Entry
	case failedSendingEntry(privmx.InternalError)
	/// Failed to read an Entry
	case failedReadingEntry(privmx.InternalError)
	/// Failed to delete an Entry
	case failedDeletingEntry(privmx.InternalError)
	/// Failed to list Entries
	case failedListingEntries(privmx.InternalError)
	
	/// Failed to create a File Handle
	case failedCreatingFileHandle(privmx.InternalError)
	
	/// Failed to wait for an Event
	case failedWaitingForEvent(privmx.InternalError)
	/// Failed to get an Event
	case failedGettingEvent(privmx.InternalError)
	
	/// Failed to subscirbe for Events
	case failedSubscribingForEvents(privmx.InternalError)
	/// Failed to unsubscribe from Events
	case failedUnsubscribingFromEvents(privmx.InternalError)
	
	/// Failed to delete a Thread
	case failedDeletingThread(privmx.InternalError)
	/// Failed to delete a Message
	case failedDeletingMessage(privmx.InternalError)
	/// Failed to delete a Store
	case failedDeletingStore(privmx.InternalError)
	
	/// Failed to query and `EventHolder`
	case failedQueryingEventHolder(privmx.InternalError)
	/// Failed to extract an Event from an `EventHolder`
	case failedExtractingEventFromHolder(privmx.InternalError)
	
	/// Failed to set Certificates
	case failedSettingCerts(privmx.InternalError)
	
	/// Failed to instantiate `EventQueue`
	case failedInstantiatingEventQueue(privmx.InternalError)
	/// Failed to emit `LibBreakEvent`
	case failedEmittingBreakEvent(privmx.InternalError)
	
	/// Failed to send a request to the backend
	case failedRequestingBackend(privmx.InternalError)
	
	/// Gets the Message of the error
	///
	///  - Returns: Message of the error
	public func getMessage() -> String{
		switch self{
			case .failedUpdatingMessage(let err),
					.failedGettingConnectionId(let err),
					.failedRequestingBackend(let err),
					.failedEmittingBreakEvent(let err),
					.failedClosingFile(let err),
					.otherFailure(let err),
					.failedEncrypting(let err),
					.failedDecrypting(let err),
					.failedSigning(let err),
					.failedGeneratingPubKey(let err),
					.failedGeneratingPrivKey(let err),
					.failedConvertingKeyToWIF(let err),
					.failedConnecting(let err),
					.failedDisconnecting(let err),
					.failedListingContexts(let err),
					.failedGettingContextUsers(let err),
					.failedCreatingThread(let err),
					.failedGettingThread(let err),
					.failedListingThreads(let err),
					.failedListingMessages(let err),
					.failedCreatingMessage(let err),
					.failedGettingMessage(let err),
					.failedUpdatingThread(let err),
					.failedListingStores(let err),
					.failedGettingStore(let err),
					.failedCreatingStore(let err),
					.failedGettingFile(let err),
					.failedListingFiles(let err),
					.failedCreatingFile(let err),
					.failedUpdatingFile(let err),
					.failedOpeningFile(let err),
					.failedReadingFromFile(let err),
					.failedSeekingInFile(let err),
					.failedWritingToFile(let err),
					.failedDeletingFile(let err),
					.failedWaitingForEvent(let err),
					.failedGettingEvent(let err),
					.failedSubscribingForEvents(let err),
					.failedUnsubscribingFromEvents(let err),
					.failedDeletingThread(let err),
					.failedDeletingMessage(let err),
					.failedDeletingStore(let err),
					.failedSettingCerts(let err),
					.failedUpdatingStore(let err),
					.failedQueryingEventHolder(let err),
					.failedExtractingEventFromHolder(let err),
					.failedInstantiatingEventQueue(let err),
					.failedInstantiatingThreadApi(let err),
					.failedInstantiatingStoreApi(let err),
					.failedInstantiatingInboxApi(let err),
					.failedCreatingInbox(let err),
					.failedUpdatingInbox(let err),
					.failedDeletingInbox(let err),
					.failedGettingInbox(let err),
					.failedGettingInboxPublicView(let err),
					.failedListingInboxes(let err),
					.failedPreparingEntry(let err),
					.failedSendingEntry(let err),
					.failedReadingEntry(let err),
					.failedDeletingEntry(let err),
					.failedListingEntries(let err),
					.failedGeneratingSymmetricKey(let err),
					.failedVerifyingSignature(let err),
					.failedCreatingFileHandle(let err):
				return String(err.message)
		}
	}
	
	/// Gets the Code of the error, if it exists
	///
	///  - Returns: Code of the internal error, or nil
	public func getCode() -> CUnsignedInt?{
		switch self{
			case .failedUpdatingMessage(let err),
					.failedGettingConnectionId(let err),
					.failedRequestingBackend(let err),
					.failedEmittingBreakEvent(let err),
					.failedClosingFile(let err),
					.otherFailure(let err),
					.failedEncrypting(let err),
					.failedDecrypting(let err),
					.failedSigning(let err),
					.failedGeneratingPubKey(let err),
					.failedGeneratingPrivKey(let err),
					.failedConvertingKeyToWIF(let err),
					.failedConnecting(let err),
					.failedDisconnecting(let err),
					.failedListingContexts(let err),
					.failedGettingContextUsers(let err),
					.failedCreatingThread(let err),
					.failedGettingThread(let err),
					.failedListingThreads(let err),
					.failedListingMessages(let err),
					.failedCreatingMessage(let err),
					.failedGettingMessage(let err),
					.failedUpdatingThread(let err),
					.failedListingStores(let err),
					.failedGettingStore(let err),
					.failedCreatingStore(let err),
					.failedGettingFile(let err),
					.failedListingFiles(let err),
					.failedCreatingFile(let err),
					.failedUpdatingFile(let err),
					.failedOpeningFile(let err),
					.failedReadingFromFile(let err),
					.failedSeekingInFile(let err),
					.failedWritingToFile(let err),
					.failedDeletingFile(let err),
					.failedWaitingForEvent(let err),
					.failedGettingEvent(let err),
					.failedSubscribingForEvents(let err),
					.failedUnsubscribingFromEvents(let err),
					.failedDeletingThread(let err),
					.failedDeletingMessage(let err),
					.failedDeletingStore(let err),
					.failedSettingCerts(let err),
					.failedUpdatingStore(let err),
					.failedQueryingEventHolder(let err),
					.failedExtractingEventFromHolder(let err),
					.failedInstantiatingEventQueue(let err),
					.failedInstantiatingThreadApi(let err),
					.failedInstantiatingStoreApi(let err),
					.failedInstantiatingInboxApi(let err),
					.failedCreatingInbox(let err),
					.failedUpdatingInbox(let err),
					.failedDeletingInbox(let err),
					.failedGettingInbox(let err),
					.failedGettingInboxPublicView(let err),
					.failedListingInboxes(let err),
					.failedPreparingEntry(let err),
					.failedSendingEntry(let err),
					.failedReadingEntry(let err),
					.failedDeletingEntry(let err),
					.failedListingEntries(let err),
					.failedGeneratingSymmetricKey(let err),
					.failedVerifyingSignature(let err),
					.failedCreatingFileHandle(let err):
				return err.code.value
		}
	}
	
	/// Gets the Name of the error
	///
	///  - Returns: Name of the error
	public func getName() -> String{
		switch self{
			case .failedUpdatingMessage(let err),
					.failedGettingConnectionId(let err),
					.failedRequestingBackend(let err),
					.failedEmittingBreakEvent(let err),
					.failedClosingFile(let err),
					.otherFailure(let err),
					.failedEncrypting(let err),
					.failedDecrypting(let err),
					.failedSigning(let err),
					.failedGeneratingPubKey(let err),
					.failedGeneratingPrivKey(let err),
					.failedConvertingKeyToWIF(let err),
					.failedConnecting(let err),
					.failedDisconnecting(let err),
					.failedListingContexts(let err),
					.failedGettingContextUsers(let err),
					.failedCreatingThread(let err),
					.failedGettingThread(let err),
					.failedListingThreads(let err),
					.failedListingMessages(let err),
					.failedCreatingMessage(let err),
					.failedGettingMessage(let err),
					.failedUpdatingThread(let err),
					.failedListingStores(let err),
					.failedGettingStore(let err),
					.failedCreatingStore(let err),
					.failedGettingFile(let err),
					.failedListingFiles(let err),
					.failedCreatingFile(let err),
					.failedUpdatingFile(let err),
					.failedOpeningFile(let err),
					.failedReadingFromFile(let err),
					.failedSeekingInFile(let err),
					.failedWritingToFile(let err),
					.failedDeletingFile(let err),
					.failedWaitingForEvent(let err),
					.failedGettingEvent(let err),
					.failedSubscribingForEvents(let err),
					.failedUnsubscribingFromEvents(let err),
					.failedDeletingThread(let err),
					.failedDeletingMessage(let err),
					.failedDeletingStore(let err),
					.failedSettingCerts(let err),
					.failedUpdatingStore(let err),
					.failedQueryingEventHolder(let err),
					.failedExtractingEventFromHolder(let err),
					.failedInstantiatingEventQueue(let err),
					.failedInstantiatingThreadApi(let err),
					.failedInstantiatingStoreApi(let err),
					.failedInstantiatingInboxApi(let err),
					.failedCreatingInbox(let err),
					.failedUpdatingInbox(let err),
					.failedDeletingInbox(let err),
					.failedGettingInbox(let err),
					.failedGettingInboxPublicView(let err),
					.failedListingInboxes(let err),
					.failedPreparingEntry(let err),
					.failedSendingEntry(let err),
					.failedReadingEntry(let err),
					.failedDeletingEntry(let err),
					.failedListingEntries(let err),
					.failedGeneratingSymmetricKey(let err),
					.failedVerifyingSignature(let err),
					.failedCreatingFileHandle(let err):
				return String(err.name)
		}
	}
	/// Gets the Description of the error
	///
	///  - Returns: Description of the error
	public func getDescription() -> String{
		switch self{
			case .failedUpdatingMessage(let err),
					.failedGettingConnectionId(let err),
					.failedRequestingBackend(let err),
					.failedEmittingBreakEvent(let err),
					.failedClosingFile(let err),
					.otherFailure(let err),
					.failedEncrypting(let err),
					.failedDecrypting(let err),
					.failedSigning(let err),
					.failedGeneratingPubKey(let err),
					.failedGeneratingPrivKey(let err),
					.failedConvertingKeyToWIF(let err),
					.failedConnecting(let err),
					.failedDisconnecting(let err),
					.failedListingContexts(let err),
					.failedGettingContextUsers(let err),
					.failedCreatingThread(let err),
					.failedGettingThread(let err),
					.failedListingThreads(let err),
					.failedListingMessages(let err),
					.failedCreatingMessage(let err),
					.failedGettingMessage(let err),
					.failedUpdatingThread(let err),
					.failedListingStores(let err),
					.failedGettingStore(let err),
					.failedCreatingStore(let err),
					.failedGettingFile(let err),
					.failedListingFiles(let err),
					.failedCreatingFile(let err),
					.failedUpdatingFile(let err),
					.failedOpeningFile(let err),
					.failedReadingFromFile(let err),
					.failedSeekingInFile(let err),
					.failedWritingToFile(let err),
					.failedDeletingFile(let err),
					.failedWaitingForEvent(let err),
					.failedGettingEvent(let err),
					.failedSubscribingForEvents(let err),
					.failedUnsubscribingFromEvents(let err),
					.failedDeletingThread(let err),
					.failedDeletingMessage(let err),
					.failedDeletingStore(let err),
					.failedSettingCerts(let err),
					.failedUpdatingStore(let err),
					.failedQueryingEventHolder(let err),
					.failedExtractingEventFromHolder(let err),
					.failedInstantiatingEventQueue(let err),
					.failedInstantiatingThreadApi(let err),
					.failedInstantiatingStoreApi(let err),
					.failedInstantiatingInboxApi(let err),
					.failedCreatingInbox(let err),
					.failedUpdatingInbox(let err),
					.failedDeletingInbox(let err),
					.failedGettingInbox(let err),
					.failedGettingInboxPublicView(let err),
					.failedListingInboxes(let err),
					.failedPreparingEntry(let err),
					.failedSendingEntry(let err),
					.failedReadingEntry(let err),
					.failedDeletingEntry(let err),
					.failedListingEntries(let err),
					.failedGeneratingSymmetricKey(let err),
					.failedVerifyingSignature(let err),
					.failedCreatingFileHandle(let err):
				return String(err.description)
		}
	}
}
