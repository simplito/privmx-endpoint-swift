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
			throw PrivMXEndpointError.FailedInstantiatingKvdbApi(res.error.value!)
		}
		guard let result = res.result.value
		else{
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly received nil value"
			throw PrivMXEndpointError.FailedInstantiatingKvdbApi(err)
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
			throw PrivMXEndpointError.FailedCreatingKvdb(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedGettingKvdb(err)
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
			throw PrivMXEndpointError.FailedUpdatingKvdb(res.error.value!)
		}
	}
	
	
	public func deleteKvdb(
		kvdbId: std.__1.string
	) throws -> Void {
		let res = api.deleteKvdb(kvdbId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedDeletingKvdb(res.error.value!)
		}
	}
	
	
	public func getKvdb(
		kvdbId:std.string
	) throws -> privmx.endpoint.kvdb.Kvdb {
		let res = api.getKvdb(kvdbId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedGettingKvdb(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedGettingKvdb(err)
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
			throw PrivMXEndpointError.FailedListingKvdbs(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedListingKvdbs(err)
		}
		return result
	}
	
	
	public func getItem(
		kvdbId: std.string,
		key: std.string
	) throws -> privmx.endpoint.kvdb.Item {
		let res = api.getItem(kvdbId,
							  key)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedGettingItem(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedGettingItem(err)
		}
		return result
	}
	
	
	public func listItemKeys(
		kvdbId: std.string,
		pagingQuery: privmx.endpoint.kvdb.KeysPagingQuery
	) throws -> privmx.StringList {
		let res = api.listItemKeys(kvdbId,
								   pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedListingItemKeys(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedListingItemKeys(err)
		}
		return result
	}
	
	
	public func listItems(
		kvdbId: std.__1.string,
		pagingQuery: privmx.endpoint.kvdb.ItemsPagingQuery
	) throws -> privmx.ItemList {
		let res = api.listItems(kvdbId,
								pagingQuery)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedListingItems(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.FailedListingItems(err)
		}
		return result
	}
	
	
	public func setItem(
		kvdbId: std.string,
		key: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer,
		version: Int64
	) throws -> Void {
		let res = api.setItem(kvdbId,
							  key,
							  publicMeta,
							  privateMeta,
							  data,
							  version)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedSettingItem(res.error.value!)
		}
	}
	
	
	public func deleteItem(
		kvdbId: std.string,
		key: std.string
	) throws -> Void {
		let res = api.deleteItem(kvdbId,
								 key)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedDeletingItem(res.error.value!)
		}
	}
	
	public func deleteItems(
		kvdbId: std.string,
		keys: privmx.StringVector
	) throws -> Void {
		let res = api.deleteItems(kvdbId,
								  keys)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.FailedDeletingItems(res.error.value!)
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
		let res = api.subscribeForItemEvents(channel)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
	}
	
	public func unsubscribeFromItemEvents(
		channel: std.string
	) throws -> Void {
		let res = api.unsubscribeFromItemEvents(channel)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
}
