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

#include "NativeKvdbApiWrapper.hpp"

namespace privmx{
using namespace endpoint;

NativeKvdbApiWrapper::NativeKvdbApiWrapper(NativeConnectionWrapper& connection){
	api = std::make_shared<kvdb::KvdbApi>(kvdb::KvdbApi::create(*connection.getApi()));
}

ResultWithError<NativeKvdbApiWrapper> NativeKvdbApiWrapper::create(NativeConnectionWrapper &connection){
	auto res = ResultWithError<NativeKvdbApiWrapper>();
	try{
		res.result = NativeKvdbApiWrapper(connection);
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

ResultWithError<std::string> NativeKvdbApiWrapper::createKvdb(const std::string& kvdbId,
															  const UserWithPubKeyVector& users,
															  const UserWithPubKeyVector& managers,
															  const endpoint::core::Buffer& publicMeta,
															  const endpoint::core::Buffer& privateMeta,
															  const OptionalContainerPolicy& policies){
	auto res = ResultWithError<std::string>();
	try{
		res.result = getapi()->createKvdb(kvdbId,
										  users,
										  managers,
										  publicMeta,
										  privateMeta,
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


ResultWithError<nullptr_t> NativeKvdbApiWrapper::updateKvdb(const std::string& kvdbId,
															const UserWithPubKeyVector& users,
															const UserWithPubKeyVector& managers,
															const core::Buffer& publicMeta,
															const core::Buffer& privateMeta,
															const int64_t version,
															const bool force,
															const bool forceGenerateNewKey,
															const OptionalContainerPolicy& policies){
	auto res = ResultWithError();
	try{
		getapi()->updateKvdb(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::deleteKvdb(const std::string &kvdbId){
	auto res = ResultWithError();
	try {
		getapi()->deleteKvdb(kvdbId);
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

ResultWithError<kvdb::Kvdb> NativeKvdbApiWrapper::getKvdb(const std::string &kvdbId){
	auto res = ResultWithError<kvdb::Kvdb>();
	try{
		res.result = getapi()->getKvdb(kvdbId);
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

ResultWithError<KvdbList> NativeKvdbApiWrapper::listKvdbs(const std::string &contextId,
														  const endpoint::core::PagingQuery pagingQuery){
	auto res = ResultWithError<KvdbList>();
	try{
		res.result = getapi()->listKvdbs(contextId,
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

ResultWithError<kvdb::Item> NativeKvdbApiWrapper::getItem(const std::string &kvdbId,
														  const std::string &key){
	auto res = ResultWithError<kvdb::Item>();
	try{
		res.result = getapi()->getItem(kvdbId,
									   key);
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

ResultWithError<StringList> NativeKvdbApiWrapper::listItemKeys(const std::string &kvdbId,
															   const endpoint::kvdb::KeysPagingQuery &pagingQuery){
	auto res = ResultWithError<StringList>();
	try{
		res.result = getapi()->listItemKeys(kvdbId,
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

ResultWithError<ItemList> NativeKvdbApiWrapper::listItems(const std::string &kvdbId,
														  const endpoint::kvdb::ItemsPagingQuery &pagingQuery){
	auto res = ResultWithError<ItemList>();
	try{
		res.result = getapi()->listItem(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::setItem(const std::string &kvdbId,
														 const std::string &key,
														 const endpoint::core::Buffer &publicMeta,
														 const endpoint::core::Buffer &privateMeta,
														 const endpoint::core::Buffer &data,
														 const int64_t version){
	auto res = ResultWithError();
	try{
		getapi()->setItem(kvdbId,
						  key,
						  publicMeta,
						  privateMeta,
						  data,
						  version);
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::deleteItem(const std::string &kvdbId,
															const std::string &key){
	auto res = ResultWithError();
	try{
		getapi()->deleteItem(kvdbId,
							 key);
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::deleteItems(const std::string &kvdbId,
															 const StringVector &keys){
	ResultWithError res;
	try{
		getapi()->deleteItems(kvdbId,
							  keys);
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::subscribeForKvdbEvents(){
	ResultWithError res;
	try{
		getapi()->subscribeForKvdbEvents();
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::unsubscribeFromKvdbEvents(){
	ResultWithError res;
	try{
		getapi()->unsubscribeFromKvdbEvents();
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::subscribeForItemEvents(std::string kvdbId){
	auto res = ResultWithError();
	try{
		getapi()->subscribeForItemEvents(kvdbId);
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::unsubscribeFromItemEvents(std::string kvdbId){
	ResultWithError res;
	try{
		getapi()->unsubscribeFromItemEvents(kvdbId);
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

ResultWithError<bool> KvdbEventHandler::isKvdbCreatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbCreatedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbCreatedEvent> KvdbEventHandler::extractKvdbCreatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbCreatedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbCreatedEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbDeletedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbDeletedEvent> KvdbEventHandler::extractKvdbDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbDeletedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbDeletedEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbUpdatedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbUpdatedEvent> KvdbEventHandler::extractKvdbUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbUpdatedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbUpdatedEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbStatsChangedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbStatsEvent(eventHolder);
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

ResultWithError<kvdb::KvdbStatsChangedEvent> KvdbEventHandler::extractKvdbStatsChangedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbStatsChangedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbStatsEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbNewItemEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbNewItemEvent(eventHolder);
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

ResultWithError<kvdb::KvdbNewItemEvent> KvdbEventHandler::extractKvdbNewItemEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbNewItemEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbNewItemEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbItemUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbItemUpdatedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbItemUpdatedEvent> KvdbEventHandler::extractKvdbItemUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbItemUpdatedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbItemUpdatedEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbItemDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbItemDeletedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbItemDeletedEvent> KvdbEventHandler::extractKvdbItemDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbItemDeletedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbItemDeletedEvent(eventHolder);
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
