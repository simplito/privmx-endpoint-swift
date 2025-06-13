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

ResultWithError<kvdb::KvdbEntry> NativeKvdbApiWrapper::getEntry(const std::string &kvdbId,
														  const std::string &key){
	auto res = ResultWithError<kvdb::KvdbEntry>();
	try{
		res.result = getapi()->getEntry(kvdbId,
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

ResultWithError<StringList> NativeKvdbApiWrapper::listEntriesKeys(const std::string &kvdbId,
																const endpoint::kvdb::KvdbKeysPagingQuery &pagingQuery){
	auto res = ResultWithError<StringList>();
	try{
		res.result = getapi()->listEntriesKeys(kvdbId,
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

ResultWithError<KvdbEntryList> NativeKvdbApiWrapper::listEntries(const std::string &kvdbId,
														  const endpoint::kvdb::KvdbEntryPagingQuery &pagingQuery){
	auto res = ResultWithError<KvdbEntryList>();
	try{
		res.result = getapi()->listEntries(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::setEntry(const std::string &kvdbId,
														 const std::string &key,
														 const endpoint::core::Buffer &publicMeta,
														 const endpoint::core::Buffer &privateMeta,
														 const endpoint::core::Buffer &data,
														 const int64_t version){
	auto res = ResultWithError();
	try{
		getapi()->setEntry(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::deleteEntry(const std::string &kvdbId,
															const std::string &key){
	auto res = ResultWithError();
	try{
		getapi()->deleteEntry(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::deleteEntries(const std::string &kvdbId,
															 const StringVector &keys){
	ResultWithError res;
	try{
		getapi()->deleteEntries(kvdbId,
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::subscribeForEntryEvents(std::string kvdbId){
	auto res = ResultWithError();
	try{
		getapi()->subscribeForEntryEvents(kvdbId);
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

ResultWithError<nullptr_t> NativeKvdbApiWrapper::unsubscribeFromEntryEvents(std::string kvdbId){
	ResultWithError res;
	try{
		getapi()->unsubscribeFromEntryEvents(kvdbId);
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

ResultWithError<bool> KvdbEventHandler::isKvdbNewEntryEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbNewEntryEvent(eventHolder);
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

ResultWithError<kvdb::KvdbNewEntryEvent> KvdbEventHandler::extractKvdbNewEntryEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbNewEntryEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbNewEntryEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbEntryUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbEntryUpdatedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbEntryUpdatedEvent> KvdbEventHandler::extractKvdbEntryUpdatedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbEntryUpdatedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbEntryUpdatedEvent(eventHolder);
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

ResultWithError<bool> KvdbEventHandler::isKvdbEntryDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<bool> res;
	try{
		res.result = kvdb::Events::isKvdbEntryDeletedEvent(eventHolder);
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

ResultWithError<kvdb::KvdbEntryDeletedEvent> KvdbEventHandler::extractKvdbEntryDeletedEvent(const endpoint::core::EventHolder &eventHolder){
	ResultWithError<kvdb::KvdbEntryDeletedEvent> res;
	try{
		res.result = kvdb::Events::extractKvdbEntryDeletedEvent(eventHolder);
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
