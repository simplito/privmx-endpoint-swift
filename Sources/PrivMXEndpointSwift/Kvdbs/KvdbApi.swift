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

/// 'KvdbApi' is a class representing Endpoint's API for Kvdbs and their messages.
public class KvdbApi: @unchecked Sendable{
	var api:privmx.NativeKvdbApiWrapper
	
	init(
		api:privmx.NativeKvdbApiWrapper
	){
		self.api = api
	}
	
	/// Creates an instance of 'KvdbApi'.
	///
	/// - Parameter connection: instance of 'Connection'
	///
	/// - Returns: `KvdbApi` object.
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
	
	/// Creates a new KVDB in given Context.
	///
	/// - Parameter contextId: ID of the Context to create the KVDB in
	/// - Parameter users: array of UserWithPubKey structs which indicates who will have access to the created KVDB
	/// - Parameter managers: array of UserWithPubKey structs which indicates who will have access (and management rights) to the created KVDB
	/// - Parameter publicMeta: public (unencrypted) metadata
	/// - Parameter privateMeta: private (encrypted) metadata
	/// - Parameter policies: KVDB's policies
	/// - Parameter contextId: ID of the Context to create the KVDB in
	///
	/// - Returns: Id of the created KVDB
	///
	/// - Throws: `PrivMXEndpointError.failedCreatingKvdb` if creating a Kvdb fails.
	public func createKvdb(
		contextId: std.string,
		users: privmx.UserWithPubKeyVector,
		managers: privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		policies: privmx.endpoint.core.ContainerPolicy? = nil
	) throws -> std.string {
		
		var optPolicies = privmx.OptionalContainerPolicy()
		if let policies{
			optPolicies = privmx.makeOptional(policies)
		}
		
		let res = api.createKvdb(
			contextId,
			users,
			managers,
			publicMeta,
			privateMeta,
			optPolicies)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCreatingKvdb(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCreatingKvdb(err)
		}
		return result
	}
	
	/// Updates an existing KVDB.
	///
	/// - Parameter kvdbId: ID of the KVDB to update
	/// - Parameter users: array of UserWithPubKey structs which indicates who will have access to the created KVDB
	/// - Parameter managers: array of UserWithPubKey structs which indicates who will have access (and management rights) to the created KVDB
	/// - Parameter publicMeta: public (unencrypted) metadata
	/// - Parameter privateMeta: private (encrypted) metadata
	/// - Parameter version: current version of the updated KVDB
	/// - Parameter force: force update (without checking version)
	/// - Parameter forceGenerateNewKey: force to regenerate a key for the KVDB
	/// - Parameter policies: KVDB's policies
	/// - Parameter kvdbId: ID of the KVDB to update
	///
	/// - Throws: `PrivMXEndpointError.failedUpdatingKvdb` when the operation fails.
	public func updateKvdb(
		kvdbId: std.string,
		users:privmx.UserWithPubKeyVector,
		managers:privmx.UserWithPubKeyVector,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		version: Int64,
		force:Bool,
		forceGenerateNewKey:Bool,
		policies:privmx.endpoint.core.ContainerPolicy? = nil
	) throws -> Void {
		
		var op = privmx.OptionalContainerPolicy()
		if let policies{
			op = privmx.makeOptional(policies)
		}
		
		let res = api.updateKvdb(
			kvdbId,
			users,
			managers,
			publicMeta,
			privateMeta,
			version,
			force,
			forceGenerateNewKey,
			op)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUpdatingKvdb(res.error.value!)
		}
	}
	
	/// Deletes a KVDB by given KVDB ID.
	///
	/// - Parameter kvdbId: ID of the KVDB to delete
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingKvdb` if deleting the KVDB fails.
	public func deleteKvdb(
		kvdbId: std.string
	) throws -> Void {
		let res = api.deleteKvdb(kvdbId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingKvdb(res.error.value!)
		}
	}
	
	
	///Check whether the KVDB entry exists.
	///
	/// - Parameter kvdbId: KVDB ID of the KVDB entry to check
	/// - Parameter key: key of the KVDB entry to check
	///
	/// - Returns: 'true' if the KVDB has an entry with given key, 'false' otherwise
	public func hasEntry(
		kvdbId: std.string,
		key: std.string
	) throws -> Bool {
		let res = api.hasEntry(kvdbId, key)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedCheckingIfEntryExists(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedCheckingIfEntryExists(err)
		}
		return result
	}
	
	///Gets a KVDB by given KVDB ID.
	///
	/// - Parameter kvdbId:ID of KVDB to get
	///
	/// - Returns: struct containing info about the KVDB
	///
	/// - Throws: `PrivMXEndpointError.failedGettingKvdb` if the operation fails.
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
	
	/// Gets a list of Kvdbs in given Context.
	///
	/// - Parameter contextId: ID of the Context to get the Kvdbs from
	/// - Parameter pagingQuery: with list query parameters
	///
	/// - Returns: struct containing a list of Kvdbs
	///
	/// - Throws: `PrivMXEndpointError.failedListingKvdbs` if the operation fails.
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
	
	/// Gets a KVDB entry by given KVDB entry key and KVDB ID.
	///
	/// - Parameter kvdbId: KVDB ID of the KVDB entry to get
	/// - Parameter key: key of the KVDB entry to get
	///
	/// - Returns: struct containing the KVDB entry
	///
	/// - Throws: `PrivMXEndpointError.failedGettingKvdbEntry` if the operation fails.
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
	
	/// Gets a list of KVDB entries keys from a KVDB.
	///
	/// - Parameter kvdbId: ID of the KVDB to list KVDB entries from
	/// - Parameter pagingQuery: with list query parameters
	///
	/// - Returns: struct containing a list of KVDB entries
	///
	/// - Throws: `PrivMXEndpointError.failedListingKvdbEntriesKeys` if the operation fails.
	public func listEntriesKeys(
		kvdbId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
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
	
	/// Gets a list of KVDB entries from a KVDB.
	///
	/// - Parameter kvdbId: ID of the KVDB to list KVDB entries from
	/// - Parameter pagingQuery:  with list query parameters
	///
	/// - Returns: struct containing a list of KVDB entries
	///
	/// - Throws: `PrivMXEndpointError.failedListingKvdbEntries` if the operation fails.
	public func listEntries(
		kvdbId: std.string,
		pagingQuery: privmx.endpoint.core.PagingQuery
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
	
	/// Sets a KVDB entry in the given KVDB.
	///
	/// - Parameter kvdbId: ID of the KVDB to set the entry to
	/// - Parameter key: KVDB entry key
	/// - Parameter publicMeta: public KVDB entry metadata
	/// - Parameter privateMeta: private KVDB entry metadata
	/// - Parameter data: content of the KVDB entry
	///
	/// - Returns: ID of the new KVDB entry
	///
	/// - Throws: PrivMXEndpointError.failedSettingKvdbEntry.
	public func setEntry(
		kvdbId: std.string,
		key: std.string,
		publicMeta: privmx.endpoint.core.Buffer,
		privateMeta: privmx.endpoint.core.Buffer,
		data: privmx.endpoint.core.Buffer,
		version: Int64 = 0
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
	
	/// Deletes a KVDB entry by given KVDB entry ID.
	///
	/// - Parameter kvdbId: KVDB ID of the KVDB entry to delete
	/// - Parameter key: key of the KVDB entry to delete
	///
	/// - Throws: `PrivMXEndpointError.failedDeletingKvdbEntry` if the operation fails.
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
	
	/// Deletes KVDB entries by given KVDB IDs and the list of entry keys.
	///
	/// - Parameter kvdbId: ID of the KVDB database to delete from
	/// - Parameter keys: vector of the keys of the KVDB entries to delete
	///
	/// - Returns: map with the statuses of deletion for every key
	public func deleteEntries(
		kvdbId: std.string,
		keys: privmx.StringVector
	) throws -> privmx.StringBoolMap {
		let res = api.deleteEntries(kvdbId,
								  keys)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedDeletingKvdbEntries(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedDeletingKvdbEntries(err)
		}
		return result
	}
	
	/// Subscribe for the Kvdb events on the given subscription query.
	///
	/// - Parameter subscriptionQueries: list of queries
	///
	/// - Throws: When subscribing for events fails.
	///
	/// - Returns: list of subscriptionIds in maching order to subscriptionQueries.
	public func subscribeFor(
		subscriptionQueries: privmx.SubscriptionQueryVector
	) throws -> privmx.SubscriptionIdVector {
		let res = api.subscribeFor(subscriptionQueries)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedSubscribingForEvents(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedSubscribingForEvents(err)
		}
		return result
	}
	
	/// Unsubscribe from events for the given subscriptionId.
	///
	/// - Parameter subscriptionIds: list of subscriptionId
	///
	/// - Throws: When unsubscribing fails.
	public func unsubscribeFrom(
		subscriptionId: privmx.SubscriptionIdVector
	) throws -> Void {
		let res = api.unsubscribeFrom(subscriptionId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedUnsubscribingFromEvents(res.error.value!)
		}
	}
	
	/// Generate subscription Query for the Kvdb events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter selectorType: scope on which you listen for events
	/// - Parameter selectorId: ID of the selector
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQuery(
	eventType: privmx.endpoint.kvdb.EventType,
	selectorType: privmx.endpoint.kvdb.EventSelectorType,
	selectorId: std.string
	) throws -> privmx.SubscriptionQuery {
		let res = api.buildSubscriptionQuery(eventType, selectorType, selectorId)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(err)
		}
		return result
	}

	/// Generate subscription Query for the KvdbEntry events.
	///
	/// - Parameter eventType: type of event which you listen for
	/// - Parameter kvdbId: ID of the KVDB
	/// - Parameter kvdbEntryKey: key of the KVDB Entry
	///
	/// - Throws: When building the subscription Query fails.
	///
	/// - Returns: a properly formatted event subscription request.
	public func buildSubscriptionQueryForSelectedEntry(
	eventType: privmx.endpoint.kvdb.EventType,
	kvdbId: std.string,
	kvdbEntryKey: std.string
	) throws -> privmx.SubscriptionQuery {
		let res = api.buildSubscriptionQueryForSelectedEntry(eventType, kvdbId, kvdbEntryKey)
		guard res.error.value == nil else {
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(res.error.value!)
		}
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedBuildingSubscriptionQuery(err)
		}
		return result
	}
}
