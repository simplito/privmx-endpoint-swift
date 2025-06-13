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
import Foundation

public class KvdbApi: @unchecked Sendable{
	var api:privmx.NativeKvdbApiWrapper
	
	init(
		api:privmx.NativeKvdbApiWrapper
	){
		self.api = api
	}
	
	public static func create(
		connection: inout Connection
	) throws -> KvdbApi {
		let res = privmx.NativeKvdbApiWrapper.create(&connection.api)
		guard nil == res.error.value
		else{
			throw PrivMXEndpointError.failedInstantiatingKvdbApi(res.error.value!)
		}
		guard let result = res.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil value"
			throw PrivMXEndpointError.failedInstantiatingKvdbApi(err)
		}
		return KvdbApi(api: result)
	}
	
	
	public func createKvdb(
		contextId: std.__1.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		policies: privmx.OptionalContainerPolicy
	) throws -> std.string {
		let res = api.createKvdb(
			contextId,
			users,
			managers,
			publicMeta,
			privateMeta,
			policies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingKvdb(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingKvdb(err)
		}
		return result
	}
	
	
	public func updateKvdb(
		kvdbId: std.string,
		users:privmx.UserWithPubKeyVector,
		managers:privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		version: Int64,
		force:Bool,
		forceGenerateNewKey:Bool,
		policies:privmx.OptionalContainerPolicy
	) throws -> Void {
		let res = api.updateKvdb(
			kvdbId,
			users,
			managers,
			publicMeta,
			privateMeta,
			version,
			force,
			forceGenerateNewKey,
			policies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingKvdb(res.error.value!)
		}
	}
	
	
	public func deleteKvdb(
		kvdbId: std.__1.string
	) throws -> Void {
		let res = api.deleteKvdb(kvdbId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingKvdb(res.error.value!)
		}
	}
	
	
	public func getKvdb(
		kvdbId:std.string
	) throws -> privmx.endpoint.kvdb.Kvdb {
		let res = api.getKvdb(kvdbId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingKvdb(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingKvdb(err)
		}
		return result
	}
	
	
	public func listKvdbs(
		contextId:std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
	) throws -> privmx.KvdbList {
		let res = api.listKvdbs(contextId,
								pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingKvdbs(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedListingKvdbs(err)
		}
		return result
	}
	
	
	public func getEntry(
		kvdbId: std.string,
		key: std.string
	) throws -> privmx.endpoint.kvdb.KvdbEntry {
		let res = api.getEntry(kvdbId,
							  key)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedGettingKvdbEntry(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedGettingKvdbEntry(err)
		}
		return result
	}
	
	
	public func listEntriesKeys(
		kvdbId: std.string,
		pagingQuery: privmx.endpoint.kvdb.KvdbKeysPagingQuery
	) throws -> privmx.StringList {
		let res = api.listEntriesKeys(kvdbId,
								   pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingKvdbEntriesKeys(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedListingKvdbEntriesKeys(err)
		}
		return result
	}
	
	
	public func listEntries(
		kvdbId: std.string,
		pagingQuery: privmx.endpoint.kvdb.KvdbEntryPagingQuery
	) throws -> privmx.KvdbEntryList {
		let res = api.listEntries(kvdbId,
								pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedListingKvdbEntries(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedListingKvdbEntries(err)
		}
		return result
	}
	
	
	public func setEntry(
		kvdbId: std.string,
		key: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer,
		version: Int64
	) throws -> Void {
		let res = api.setEntry(kvdbId,
							  key,
							  publicMeta,
							  privateMeta,
							  data,
							  version)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSettingKvdbEntry(res.error.value!)
		}
	}
	
	
	public func deleteEntry(
		kvdbId: std.string,
		key: std.string
	) throws -> Void {
		let res = api.deleteEntry(kvdbId,
								 key)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingKvdbEntry(res.error.value!)
		}
	}
	
	public func deleteEntries(
		kvdbId: std.string,
		keys: privmx.StringVector
	) throws -> Void {
		let res = api.deleteEntries(kvdbId,
								  keys)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingKvdbEntries(res.error.value!)
		}
	}
	
	
	public func subscribeForKvdbEvents(
	) throws -> Void {
		let res = api.subscribeForKvdbEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	public func unsubscribeFromKvdbEvents(
	) throws -> Void {
		let res = api.unsubscribeFromKvdbEvents()
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	public func subscribeForItemEvents(
		channel: std.string
	) throws -> Void {
		let res = api.subscribeForEntryEvents(channel)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	public func unsubscribeFromItemEvents(
		channel: std.string
	) throws -> Void {
		let res = api.unsubscribeFromEntryEvents(channel)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
}
