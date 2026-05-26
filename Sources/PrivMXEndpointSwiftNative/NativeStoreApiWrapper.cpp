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

#include "NativeStoreApiWrapper.hpp"

namespace privmx {

using namespace endpoint;

NativeStoreApiWrapper::NativeStoreApiWrapper(NativeConnectionWrapper& connection){
	api = std::make_shared<store::StoreApi>(store::StoreApi::create(*(connection.getApi())));
}

ResultWithError<NativeStoreApiWrapper> NativeStoreApiWrapper::create(NativeConnectionWrapper &connection){
	auto res = ResultWithError<NativeStoreApiWrapper>();
	try {
		res.result = NativeStoreApiWrapper(connection);
	}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<StoreList> NativeStoreApiWrapper::listStores(const std::string& contextId,
															const core::PagingQuery& pagingQuery){
	ResultWithError<StoreList> res;
	try{
		res.result = getApi()->listStores(contextId, pagingQuery);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::Store> NativeStoreApiWrapper::getStore(const std::string &storeId){
	ResultWithError<store::Store> res;
	try{
		res.result = getApi()->getStore(storeId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeStoreApiWrapper::createStore(const std::string& contextId,
																const UserWithPubKeyVector& users,
																const UserWithPubKeyVector& managers,
																const core::Buffer& publicMeta,
																const core::Buffer& privateMeta,
																const OptionalContainerPolicy& policies){
	ResultWithError<std::string> res;
	try{
		res.result = getApi()->createStore(contextId,
										   users,
										   managers,
										   publicMeta,
										   privateMeta,
										   policies);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::updateStore(const std::string &storeId,
																   const UserWithPubKeyVector &users,
																   const UserWithPubKeyVector &managers,
																   const core::Buffer& publicMeta,
																   const core::Buffer& privateMeta,
																   const int64_t version,
																   const bool force,
																   const bool forceGenerateNewKey,
																   const OptionalContainerPolicy& policies){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->updateStore(storeId,
							  users,
							  managers,
							  publicMeta,
							  privateMeta,
							  version,
							  force,
							  forceGenerateNewKey,
							  policies);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::File> NativeStoreApiWrapper::getFile(const std::string &fileId){
	ResultWithError<store::File> res;
	try{
		res.result = getApi()->getFile(fileId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<FileList> NativeStoreApiWrapper::listFiles(const std::string& storeId,
														   const core::PagingQuery& query){
	ResultWithError<FileList> res;
	try{
		res.result = getApi()->listFiles(storeId,query);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<StoreFileHandle> NativeStoreApiWrapper::createFile(const std::string &storeId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta,
																 int64_t size,
																   bool randomWriteSupport){
	ResultWithError<StoreFileHandle> res;
	try{
		res.result = getApi()->createFile(storeId, publicMeta, privateMeta, size,randomWriteSupport);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<StoreFileHandle> NativeStoreApiWrapper::updateFile(const std::string& fileId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta,
																 int64_t size){
	ResultWithError<StoreFileHandle> res;
	try{
		res.result = getApi()->updateFile(fileId, publicMeta, privateMeta, size);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::updateFileMeta(const std::string& fileId,
																 const core::Buffer& publicMeta,
																 const core::Buffer& privateMeta){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->updateFileMeta(fileId, publicMeta, privateMeta);
		} catch(core::Exception& err) {
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<StoreFileHandle> NativeStoreApiWrapper::openFile(const std::string& fileId){
	ResultWithError<StoreFileHandle> res;
	try{
		res.result = getApi()->openFile(fileId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<core::Buffer> NativeStoreApiWrapper::readFromFile(StoreFileHandle handle,
																			int64_t length){
	ResultWithError<core::Buffer> res;
	try{
		res.result = getApi()->readFromFile(handle,length);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::writeToFile(StoreFileHandle handle,
																   const core::Buffer& dataChunk,
																   bool truncate){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->writeToFile(handle, dataChunk,truncate);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::deleteFile(const std::string &fileId){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->deleteFile(fileId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::seekInFile(StoreFileHandle handle,
																	 int64_t position){
	ResultWithError<std::nullptr_t> res;
	try{
		getApi()->seekInFile(handle, position);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::string> NativeStoreApiWrapper::closeFile(StoreFileHandle handle){
	ResultWithError<std::string> res;
	try{
		res.result = getApi()->closeFile(handle);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::deleteStore(const std::string &storeId){
	ResultWithError<std::nullptr_t> res;
	try {
		getApi()->deleteStore(storeId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::syncFile(const StoreFileHandle handle){
	ResultWithError<std::nullptr_t> res;
	try {
		getApi()->syncFile(handle);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<SubscriptionIdVector> NativeStoreApiWrapper::subscribeFor(const SubscriptionQueryVector& subscriptionQueries){
	ResultWithError<SubscriptionIdVector> res;
	try {
		res.result = getApi()->subscribeFor(subscriptionQueries);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<std::nullptr_t> NativeStoreApiWrapper::unsubscribeFrom(const SubscriptionIdVector& subscriptionIds){
	ResultWithError<std::nullptr_t> res;
	try {
		getApi()->unsubscribeFrom(subscriptionIds);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<SubscriptionQuery> NativeStoreApiWrapper::buildSubscriptionQuery(endpoint::store::EventType eventType,
																				  endpoint::store::EventSelectorType selectorType,
																				  const std::string& selectorId){
	ResultWithError<SubscriptionQuery> res;
	try {
		res.result = getApi()->buildSubscriptionQuery(eventType, selectorType, selectorId);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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


ResultWithError<bool> StoreEventHandler::isStoreCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreCreatedEvent> StoreEventHandler::extractStoreCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreCreatedEvent> res;
	try{
		res.result = store::Events::extractStoreCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreUpdatedEvent> StoreEventHandler::extractStoreUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreUpdatedEvent> res;
	try{
		res.result = store::Events::extractStoreUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreDeletedEvent> StoreEventHandler::extractStoreDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreDeletedEvent> res;
	try{
		res.result = store::Events::extractStoreDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreStatsChangedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreStatsChangedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreStatsChangedEvent> StoreEventHandler::extractStoreStatsChangedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreStatsChangedEvent> res;
	try{
		res.result = store::Events::extractStoreStatsChangedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreFileCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreFileCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreFileCreatedEvent> StoreEventHandler::extractStoreFileCreatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreFileCreatedEvent> res;
	try{
		res.result = store::Events::extractStoreFileCreatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreFileUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreFileUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreFileUpdatedEvent> StoreEventHandler::extractStoreFileUpdatedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreFileUpdatedEvent> res;
	try{
		res.result = store::Events::extractStoreFileUpdatedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<bool> StoreEventHandler::isStoreFileDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = store::Events::isStoreFileDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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

ResultWithError<store::StoreFileDeletedEvent> StoreEventHandler::extractStoreFileDeletedEvent(const core::EventHolder& eventHolder){
	ResultWithError<store::StoreFileDeletedEvent> res;
	try{
		res.result = store::Events::extractStoreFileDeletedEvent(eventHolder);
		}catch(core::Exception& err){
		res.error = {
			.name = err.getName(),
			.code = err.getCode(),
			.scope = err.getScope(),
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
