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

#include "NativeInboxApiWrapper.hpp"

namespace privmx {
using namespace endpoint;

NativeInboxApiWrapper::NativeInboxApiWrapper(std::shared_ptr<inbox::InboxApi> _api){
	api = _api;
}

ResultWithError<NativeInboxApiWrapper> NativeInboxApiWrapper::create(NativeConnectionWrapper &connection,
																	 NativeThreadApiWrapper &threadApi,
																	 NativeStoreApiWrapper &storeApi){
	ResultWithError<NativeInboxApiWrapper> res;
	try {
		res.result = NativeInboxApiWrapper(std::make_shared<endpoint::inbox::InboxApi>(endpoint::inbox::InboxApi::create(*(connection.getApi()),
																														 *(threadApi.getapi()),
																														 *(storeApi.getapi()))));
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<std::string> NativeInboxApiWrapper::createInbox(const std::string& contextId,
																const UserWithPubKeyVector& users,
																const UserWithPubKeyVector& managers,
																const endpoint::core::Buffer& publicMeta,
																const endpoint::core::Buffer& privateMeta,
																const OptionalInboxFilesConfig& filesConfig,
																const OptionalContainerPolicyWithoutItem& policies) {
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->createInbox(contextId,
										   users,
										   managers,
										   publicMeta,
										   privateMeta,
										   filesConfig,
										   policies);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::updateInbox(const std::string& inboxId,
															  const UserWithPubKeyVector& users,
															  const UserWithPubKeyVector& managers,
															  const endpoint::core::Buffer& publicMeta,
															  const endpoint::core::Buffer& privateMeta,
															  const OptionalInboxFilesConfig& filesConfig,
															  const int64_t version,
															  const bool force,
															  const bool forceGenerateNewKey,
															  const OptionalContainerPolicyWithoutItem& policies){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->updateInbox(inboxId,
							  users,
							  managers,
							  publicMeta,
							  privateMeta,
							  filesConfig,
							  version,
							  force,
							  forceGenerateNewKey,
							  policies);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<inbox::Inbox> NativeInboxApiWrapper::getInbox(const std::string &inboxId){
	ResultWithError<inbox::Inbox> res;
	try {
		res.result = getapi()->getInbox(inboxId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<InboxList> NativeInboxApiWrapper::listInboxes(const std::string& contextId,
															  const core::PagingQuery& pagingQuery){
	ResultWithError<InboxList> res;
	try {
		res.result = getapi()->listInboxes(contextId,
										   pagingQuery);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}
ResultWithError<inbox::InboxPublicView> NativeInboxApiWrapper::getInboxPublicView(const std::string &inboxId){
	ResultWithError<inbox::InboxPublicView> res;
	try {
		res.result = getapi()->getInboxPublicView(inboxId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::deleteInbox(const std::string &inboxId){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->deleteInbox(inboxId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<EntryHandle> NativeInboxApiWrapper::prepareEntry(const std::string& inboxId,
																 const endpoint::core::Buffer& data,
																 const InboxFileHandleVector& inboxFileHandles,
																 const OptionalString& userPrivKey){
	ResultWithError<EntryHandle> res;
	try {
		res.result = getapi()->prepareEntry(inboxId,
											data,
											inboxFileHandles,
											userPrivKey);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}


ResultWithError<nullptr_t> NativeInboxApiWrapper::sendEntry(const EntryHandle entryHandle){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->sendEntry(entryHandle);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<inbox::InboxEntry> NativeInboxApiWrapper::readEntry(const std::string& inboxEntryId){
	ResultWithError<inbox::InboxEntry> res;
	try {
		res.result = getapi()->readEntry(inboxEntryId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<InboxEntryList> NativeInboxApiWrapper::listEntries(const std::string& inboxId,
																   const endpoint::core::PagingQuery& pagingQuery){
	ResultWithError<InboxEntryList> res;
	try {
		res.result = getapi()->listEntries(inboxId,
										   pagingQuery);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::deleteEntry(const std::string& inboxEntryId){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->deleteEntry(inboxEntryId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<InboxFileHandle> NativeInboxApiWrapper::createFileHandle(const endpoint::core::Buffer& publicMeta,
																		 const endpoint::core::Buffer& privateMeta,
																		 const int64_t& fileSize){
	ResultWithError<InboxFileHandle> res;
	try {
		res.result = getapi()->createFileHandle(publicMeta,
												privateMeta,
												fileSize);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::writeToFile(const EntryHandle entryHandle,
															  const InboxFileHandle inboxFileHandle,
															  const endpoint::core::Buffer& dataChunk){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->writeToFile(entryHandle,
							  inboxFileHandle,
							  dataChunk);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<InboxFileHandle> NativeInboxApiWrapper::openFile(const std::string& fileId){
	ResultWithError<InboxFileHandle> res;
	try {
		res.result = getapi()->openFile(fileId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<core::Buffer> NativeInboxApiWrapper::readFromFile(const InboxFileHandle fileHandle,
																  const int64_t length){
	ResultWithError<core::Buffer> res;
	try {
		res.result = getapi()->readFromFile(fileHandle,
											length);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::seekInFile(const InboxFileHandle fileHandle,
															 const int64_t position){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->seekInFile(fileHandle,
							 position);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<std::string> NativeInboxApiWrapper::closeFile(const InboxFileHandle fileHandle){
	ResultWithError<std::string> res;
	try {
		res.result = getapi()->closeFile(fileHandle);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::subscribeForInboxEvents(){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->subscribeForInboxEvents();
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::unsubscribeFromInboxEvents(){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->unsubscribeFromInboxEvents();
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::subscribeForEntryEvents(const std::string& inboxId){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->subscribeForEntryEvents(inboxId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<nullptr_t> NativeInboxApiWrapper::unsubscribeFromEntryEvents(const std::string& inboxId){
	ResultWithError<nullptr_t> res;
	try {
		getapi()->unsubscribeFromEntryEvents(inboxId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}


ResultWithError<bool> InboxEventHandler::isInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try {
		res.result = inbox::Events::isInboxCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}


ResultWithError<endpoint::inbox::InboxCreatedEvent> InboxEventHandler::extractInboxCreatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<endpoint::inbox::InboxCreatedEvent> res;
	try {
		res.result = inbox::Events::extractInboxCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<bool> InboxEventHandler::isInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try {
		res.result = inbox::Events::isInboxUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<endpoint::inbox::InboxUpdatedEvent> InboxEventHandler::extractInboxUpdatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<endpoint::inbox::InboxUpdatedEvent> res;
	try {
		res.result = inbox::Events::extractInboxUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<bool> InboxEventHandler::isInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try {
		res.result = inbox::Events::isInboxDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<endpoint::inbox::InboxDeletedEvent> InboxEventHandler::extractInboxDeletedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<endpoint::inbox::InboxDeletedEvent> res;
	try {
		res.result = inbox::Events::extractInboxDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<bool> InboxEventHandler::isInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try {
		res.result = inbox::Events::isInboxEntryCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<endpoint::inbox::InboxEntryCreatedEvent> InboxEventHandler::extractInboxEntryCreatedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<endpoint::inbox::InboxEntryCreatedEvent> res;
	try {
		res.result = inbox::Events::extractInboxEntryCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<bool> InboxEventHandler::isInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try {
		res.result = inbox::Events::isInboxEntryDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

ResultWithError<endpoint::inbox::InboxEntryDeletedEvent> InboxEventHandler::extractInboxEntryDeletedEvent(const endpoint::core::EventHolder& eventHolder){
	ResultWithError<endpoint::inbox::InboxEntryDeletedEvent> res;
	try {
		res.result = inbox::Events::extractInboxEntryDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.description = err.getDescription(),
			.message = err.what()
		};
	}catch (std::exception & err) {
		res.error ={
			.name = "std::Exception",
			.message = err.what()
		};
	}catch (...) {
		res.error ={
			.name = "Unknown Exception",
			.message = "Failed to work"
		};
	}
	return res;
}

}
