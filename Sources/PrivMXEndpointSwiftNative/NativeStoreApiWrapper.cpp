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

#include "NativeStoreApiWrapper.hpp"

namespace privmx {

using namespace endpoint;

NativeStoreApiWrapper::NativeStoreApiWrapper(NativeCoreApiWrapper& coreApi){
	api = std::make_shared<store::StoreApi>(store::StoreApi::create(*(coreApi.getApi())));
}

NativeStoreApiWrapper NativeStoreApiWrapper::create(NativeCoreApiWrapper &coreApi){
	return NativeStoreApiWrapper(coreApi);
}

ResultWithError<endpoint::store::StoresList> NativeStoreApiWrapper::storeList(const std::string& contextId,
															const endpoint::core::ListQuery& query){
	ResultWithError<endpoint::store::StoresList> res;
	try{
		res.result = getapi()->storeList(contextId, query);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeList) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeList) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeList) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreInfo> NativeStoreApiWrapper::storeGet(const std::string &storeId){
	ResultWithError<endpoint::store::StoreInfo> res;
	try{
		res.result = getapi()->storeGet(storeId);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeGet) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeGet) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeGet) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::string> NativeStoreApiWrapper::storeCreate(const std::string& contextId,
														  const UserWithPubKeyVector& users,
														  const UserWithPubKeyVector& managers,
														  const std::string& title){
	ResultWithError<std::string> res;
	try{
		res.result = getapi()->storeCreate(contextId, users, managers, title);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeCreate) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeCreate) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeCreate) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::storeUpdate(const std::string &storeId,
												const UserWithPubKeyVector &users,
												const UserWithPubKeyVector &managers,
												const std::string &name,
												const int64_t version,
												const bool force,
												const bool generateNewKeyId,
												const bool accessToOldDataForNewUsers){
	ResultWithError<std::nullptr_t> res;
	try{
		getapi()->storeUpdate(storeId,
							  users,
							  managers,
							  name,
							  version,
							  force,
							  generateNewKeyId,
							  accessToOldDataForNewUsers);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(storeUpdate) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(storeUpdate) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(storeUpdate) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::FileInfo> NativeStoreApiWrapper::fileGet(const std::string &fileId){
	ResultWithError<endpoint::core::FileInfo> res;
	try{
		res.result = getapi()->fileGet(fileId);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileGet) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileGet) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileGet) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::FilesList> NativeStoreApiWrapper::fileList(const std::string& storeId,
																	const endpoint::core::ListQuery& query){
	ResultWithError<endpoint::core::FilesList> res;
	try{
		res.result = getapi()->fileList(storeId,query);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileList) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileList) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileList) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<PMXFileHandle> NativeStoreApiWrapper::fileCreate(const std::string &storeId,
																		  int64_t size,
																		  const std::string& mimetype,
																		  const std::string& name){
	ResultWithError<PMXFileHandle> res;
	try{
		res.result = getapi()->storeFileCreate(storeId, size, mimetype, name);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileCreate(no val)) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileCreate(no val)) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileCreate(no val)) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<PMXFileHandle> NativeStoreApiWrapper::fileUpdate(const std::string& fileId,
																		  int64_t size,
																		  const std::string& mimetype,
																		  const std::string& name){
	ResultWithError<PMXFileHandle> res;
	try{
		res.result = getapi()->storeFileUpdate(fileId, size, mimetype, name);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileCreate) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileCreate) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileCreate) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<PMXFileHandle> NativeStoreApiWrapper::fileOpen(const std::string& fileId){
	ResultWithError<PMXFileHandle> res;
	try{
		res.result = getapi()->fileOpen(fileId);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileOpen) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileOpen) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileCreate) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::core::Buffer> NativeStoreApiWrapper::fileRead(PMXFileHandle handle,
																			 int64_t length){
	ResultWithError<endpoint::core::Buffer> res;
	try{
		res.result = getapi()->fileRead(handle,length);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileRead) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileRead) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileRead) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::storeFileWrite(PMXFileHandle handle,
																	  const core::Buffer& dataChunk){
	ResultWithError<std::nullptr_t> res;
	try{
		getapi()->storeFileWrite(handle, dataChunk);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(storeFileWrite) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(storeFileWrite) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(storeFileWrite) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::fileDelete(const std::string &fileId){
	ResultWithError<bool> res;
	try{
		res.result = getapi()->storeFileDelete(fileId);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileDelete) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileDelete) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileDelete) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::fileSeek(PMXFileHandle handle,
																	 int64_t pos){
	ResultWithError<std::nullptr_t> res;
	try{
		getapi()->fileSeek(handle, pos);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(storeFileSeek) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(storeFileSeek) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(storeFileSeek) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::string> NativeStoreApiWrapper::fileClose(PMXFileHandle handle){
	ResultWithError<std::string> res;
	try{
		res.result = getapi()->fileClose(handle);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(storeFileDelete) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(storeFileDelete) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(storeFileDelete) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::storeDelete(const std::string &storeId){
	ResultWithError<std::nullptr_t> res;
	try {
		getapi()->storeDelete(storeId);
		res.error = "";
	}catch(core::Exception& err){
		res.error =std::string("(storeDelete) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error =std::string("(storeDelete) ") + std::string(err.what()) ;
	}catch (...) {
		res.error ="(storeDelete) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreCreatedEvent> NativeStoreApiWrapper::extractStoreCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreCreatedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreUpdatedEvent> NativeStoreApiWrapper::extractStoreUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreUpdatedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreDeletedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreDeletedEvent> NativeStoreApiWrapper::extractStoreDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreDeletedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreDeletedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreStatsChangedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreStatsChangedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreStatsChangedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreStatsChangedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreStatsChangedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreStatsChangedEvent> NativeStoreApiWrapper::extractStoreStatsChangedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreStatsChangedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreStatsChangedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreStatsChangedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreStatsChangedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreStatsChangedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreFileCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreFileCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreFileCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreFileCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreFileCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreFileCreatedEvent> NativeStoreApiWrapper::extractStoreFileCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreFileCreatedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreFileCreatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreFileCreatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreFileCreatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreFileCreatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreFileUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreFileUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreFileUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreFileUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreFileUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreFileUpdatedEvent> NativeStoreApiWrapper::extractStoreFileUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreFileUpdatedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreFileUpdatedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreFileUpdatedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreFileUpdatedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreFileUpdatedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<bool> NativeStoreApiWrapper::isStoreFileDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::StoreApi::isStoreFileDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(isStoreFileDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(isStoreFileDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(isStoreFileDeletedEvent) Unknown error, failed to work";
	}
	return res;
}

ResultWithError<endpoint::store::StoreFileDeletedEvent> NativeStoreApiWrapper::extractStoreFileDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<endpoint::store::StoreFileDeletedEvent> res;
	try{
		res.result = store::StoreApi::extractStoreFileDeletedEvent(eventHolder);
		res.error = "";
	}catch(core::Exception& err){
		res.error = std::string("(extractStoreFileDeletedEvent) ") + std::string(err.getFull());
	}catch (std::exception & err) {
		res.error = std::string("(extractStoreFileDeletedEvent) ") + std::string(err.what()) ;
	}catch (...) {
		res.error = "(extractStoreFileDeletedEvent) Unknown error, failed to work";
	}
	return res;
}


}
