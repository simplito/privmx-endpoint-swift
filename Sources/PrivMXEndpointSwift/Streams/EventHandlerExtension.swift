//
// PrivMX Endpoint Swift
// Copyright © 2026 Simplito sp. z o.o.
//
// This file is part of PrivMX Platform (https://privmx.dev).
// This software is Licensed under the MIT License.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//

import PrivMXEndpointStreamsLow
import PrivMXEndpointSwiftNative

public extension EventHandler{
	
	public func isStreamRoomCreatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomCreatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamRoomCreatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomCreatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomCreatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public func isStreamRoomUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamRoomUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public func isStreamRoomDeletedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamRoomDeletedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamRoomDeletedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamRoomDeletedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamRoomDeletedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public func isStreamJoinedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamJoinedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamJoinedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamJoinedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamJoinedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public func isStreamUnpublishedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamUnpublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamUnpublishedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamUnpublishedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamUnpublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	public func isStreamPublishedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamPublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamPublishedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamPublishedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamPublishedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public func isStreamLeftEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamLeftEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamLeftEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamLeftEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamLeftEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public func isStreamNewStreamsEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamNewStreamsEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamNewStreamsEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamNewStreamsEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamNewStreamsEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public func isStreamsUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamsUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamsUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamsUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamsUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
	
	public func isStreamUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> Bool {
		let res = privmx.StreamApiLowEventHandler.isStreamUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedQueryingEventHolder(err)
		}
		return result
	}
	public func extractStreamUpdatedEvent(
		in holder: privmx.endpoint.core.EventHolder
	) throws -> privmx.endpoint.stream.StreamUpdatedEvent {
		let res = privmx.StreamApiLowEventHandler.extractStreamUpdatedEvent(holder)
		if let err = res.error.value {
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		
		guard let result = res.result.value else {
			var err = privmx.InternalError()
			err.name = "Value error"
			err.description = "Unexpectedly recived nil result"
			throw PrivMXEndpointError.failedExtractingEventFromHolder(err)
		}
		return result
	}
	
}
