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

#ifndef NativeInboxApiWrapper_hpp
#define NativeInboxApiWrapper_hpp

#include "PrivMXUtils.hpp"
#include "NativeStoreApiWrapper.hpp"
#include "NativeThreadApiWrapper.hpp"

namespace privmx{

class NativeInboxApiWrapper{
public:
	static ResultWithError<NativeInboxApiWrapper> create(NativeConnectionWrapper& connection,
														 NativeThreadApiWrapper& threadApi,
														 NativeStoreApiWrapper& storeApi);
	
	/**
	 * Creates a new Inbox.
	 *
	 * @param contextId ID of the Context of the new Inbox
	 * @param users vector of UserWithPubKey structs which indicates who will have access to the created Inbox
	 * @param managers vector of UserWithPubKey structs which indicates who will have access (and management rights) to
	 * the created Inbox
	 * @param publicMeta public (unencrypted) meta data
	 * @param privateMeta private (encrypted) meta data
	 * @param filesConfig struct to override default file configuration
	 * @return string inbox ID
	 * @param policies Inbox policies
	 */
	ResultWithError<std::string> createInbox(const std::string& contextId,
											 const UserWithPubKeyVector& users,
											 const UserWithPubKeyVector& managers,
											 const endpoint::core::Buffer& publicMeta,
											 const endpoint::core::Buffer& privateMeta,
											 const OptionalInboxFilesConfig& filesConfig,
											 const OptionalContainerPolicyWithoutItem& policies);

	/**
	 * Updates an existing Inbox.
	 *
	 * @param inboxId ID of the Inbox to update
	 * @param users vector of UserWithPubKey structs which indicates who will have access to the created Inbox
	 * @param managers vector of UserWithPubKey structs which indicates who will have access (and have manage rights) to
	 * the created Inbox
	 * @param publicMeta public (unencrypted) meta data
	 * @param privateMeta private (encrypted) meta data
	 * @param filesConfig struct to override default files configuration
	 * @param version current version of the updated Inbox
	 * @param force force update (without checking version)
	 * @param forceGenerateNewKey force to renenerate a key for the Inbox
	 * @param policies Inbox policies
	 */
	ResultWithError<nullptr_t> updateInbox(const std::string& inboxId,
										   const UserWithPubKeyVector& users,
										   const UserWithPubKeyVector& managers,
										   const endpoint::core::Buffer& publicMeta,
										   const endpoint::core::Buffer& privateMeta,
										   const OptionalInboxFilesConfig& filesConfig,
										   const int64_t version,
										   const bool force,
										   const bool forceGenerateNewKey,
										   const OptionalContainerPolicyWithoutItem& policies = std::nullopt);
	
	/**
	 * Gets a single Inbox by given Inbox ID.
	 *
	 * @param inboxId ID of the Inbox to get
	 * @return Inbox struct containing information about the Inbox
	 */
	ResultWithError<endpoint::inbox::Inbox> getInbox(const std::string& inboxId);
	
	/**
	 * Gets s list of Inboxes in given Context.
	 *
	 * @param contextId ID of the Context to get Inboxes from
	 * @param pagingQuery sturct with list query parameters
	 * @return PagingList struct containing list of Inboxes
	 */
	ResultWithError<InboxList> listInboxes(const std::string& contextId,
										   const endpoint::core::PagingQuery& pagingQuery);
	
	/**
	 * Gets public data of given Inbox.
	 * You do not have to be logged in to call this function.
	 *
	 * @param inboxId ID of the Inbox to get
	 * @return InboxPublicView struct containing public accessible information about the Inbox
	 */
	ResultWithError<endpoint::inbox::InboxPublicView> getInboxPublicView(const std::string& inboxId);
	
	/**
	 * Deletes an Inbox by given Inbox ID.
	 * The function also removes the related Thread and Store.
	 *
	 * @param inboxId ID of the Inbox to delete
	 */
	ResultWithError<nullptr_t> deleteInbox(const std::string& inboxId);

	/**
	 * Prepares a request to send data to an Inbox.
	 * You do not have to be logged in to call this function.
	 *
	 * @param inboxId ID of the Inbox to which the request applies
	 * @param inboxFileHandles optional list of file handles that will be sent with the request
	 * @param userPrivKey optional sender's private key which can be used later to encrypt data for that sender
	 * @return int64_t Inbox handle
	 */
	ResultWithError<EntryHandle> prepareEntry(const std::string& inboxId,
											  const endpoint::core::Buffer& data,
											  const InboxFileHandleVector& inboxFileHandles = InboxFileHandleVector(),
											  const OptionalString& userPrivKey = std::nullopt);
	
	/**
	 * Sends data to an Inbox.
	 * You do not have to be logged in to call this function.
	 *
	 * @param inboxHandle ID of the Inbox to which the request applies
	 */
	ResultWithError<nullptr_t> sendEntry(const EntryHandle inboxHandle);
	
	/**
	 * Gets an entry from an Inbox.
	 *
	 * @param inboxEntryId ID of an entry to read from the Inbox
	 * @return InboxEntry struct containing data of the selected entry stored in the Inbox
	 */
	ResultWithError<endpoint::inbox::InboxEntry> readEntry(const std::string& inboxEntryId);
	
	/**
	 * Gets list of entries of given Inbox.
	 *
	 * @param inboxId ID of the Inbox
	 * @param pagingQuery sturct with list query parameters
	 * @return PagingList struct containing list of entries
	 */
	ResultWithError<InboxEntryList> listEntries(const std::string& inboxId,
												const endpoint::core::PagingQuery& pagingQuery);

	/**
	 * Delete an entry from an Inbox.
	 *
	 * @param inboxEntryId ID of an entry to delete from the Inbox
	 */
	ResultWithError<nullptr_t> deleteEntry(const std::string& inboxEntryId);

	/**
	 * Creates a file handle to send a file to an Inbox.
	 * You do not have to be logged in to call this function.
	 *
	 * @param publicMeta public file meta_data
	 * @param privateMeta private file meta_data
	 * @param fileSize size of the file to send
	 * @return int64_t file handle
	 */
	ResultWithError<InboxFileHandle> createFileHandle(const endpoint::core::Buffer& publicMeta,
													  const endpoint::core::Buffer& privateMeta,
													  const int64_t& fileSize);

	/**
	 * Sends a file's data chunk to an Inbox.
	 * :::note To send the entire file - divide it into pieces of the desired size and call the function for each fragment. :::
	 * You do not have to be logged in to call this function.
	 *
	 * @param inboxHandle Handle to the prepared Inbox entry
	 * @param inboxFileHandle handle to the file where the uploaded chunk belongs
	 * @param Buffer dataChunk - file chunk to send
	 */
	ResultWithError<nullptr_t> writeToFile(const EntryHandle entryHandle,
										   const InboxFileHandle inboxFileHandle,
										   const endpoint::core::Buffer& dataChunk);


	/**
	 * Opens a file to read.
	 *
	 * @param fileId ID of the file to read
	 * @return int64_t handle to read file data
	 */
	ResultWithError<InboxFileHandle> openFile(const std::string& fileId);

	/**
	 * Reads file data.
	 *
	 * @param fileHandle handle to the file
	 * @param length size of data to read
	 * @return core::Buffer buffer with file data chunk
	 */
	ResultWithError<endpoint::core::Buffer> readFromFile(const InboxFileHandle fileHandle, const int64_t length);

	/**
	 * Moves file's read cursor.
	 *
	 * @param handle handle to the file
	 * @param position sets new cursor position
	 */
	ResultWithError<nullptr_t> seekInFile(const InboxFileHandle fileHandle,
										  const int64_t position);

	/**
	 * Closes the file by given handle.
	 *
	 * @param handle handle to the file
	 * @return string ID of closed file
	 */
	ResultWithError<std::string> closeFile(const InboxFileHandle fileHandle);

	/**
	 * Subscribes for the Inbox module main events.
	 */
	ResultWithError<nullptr_t> subscribeForInboxEvents();

	/**
	 * Unsubscribes from the Inbox module main events.
	 */
	ResultWithError<nullptr_t> unsubscribeFromInboxEvents();

	/**
	 * Subscribes for the events in given Inbox
	 * @param inbox ID of the inbox to subscribe to
	 */
	ResultWithError<nullptr_t> subscribeForEntryEvents(const std::string& inboxId);

	/**
	 * Unsubscribes from the events in given Inbox
	 * @param inbox ID of the inbox to unsubscribe from
	 */
	ResultWithError<nullptr_t> unsubscribeFromEntryEvents(const std::string& inboxId);

	
private:
	std::shared_ptr<endpoint::inbox::InboxApi> getapi(){
		if (!api) throw NullApiException();
		return api;
	}
	NativeInboxApiWrapper() = default;
	NativeInboxApiWrapper(std::shared_ptr<endpoint::inbox::InboxApi> _api);
	
	std::shared_ptr<endpoint::inbox::InboxApi> api;
};

class InboxEventHandler {
public:
	static ResultWithError<bool> isInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxCreatedEvent> extractInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxUpdatedEvent> extractInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxDeletedEvent> extractInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxEntryCreatedEvent> extractInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<bool> isInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);
	static ResultWithError<endpoint::inbox::InboxEntryDeletedEvent> extractInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder);
};

}

#endif /* NativeInboxApiWrapper_hpp */
