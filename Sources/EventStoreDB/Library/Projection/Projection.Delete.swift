//
//  File.swift
//  
//
//  Created by 卓俊諺 on 2023/11/26.
//

import Foundation

@available(macOS 13.0, *)
extension Projection {
    public struct Delete: UnaryUnary {
        
        public typealias Response = DiscardedResponse<EventStore_Client_Projections_DeleteResp>
        
        public let name: String
        public let options: Options
        
        init(name: String, options: Options) {
            self.name = name
            self.options = options
        }
        
        public func build() throws -> Request.UnderlyingMessage {
            return .with{
                $0.options.name = name
                $0.options = options.build()
            }
        }
    }
}

@available(macOS 13.0, *)
extension Projection.Delete {
    public struct Request: GRPCRequest {
        public typealias UnderlyingMessage = EventStore_Client_Projections_DeleteReq
        
    }
}

@available(macOS 13.0, *)
extension Projection.Delete {
    public class Options: EventStoreOptions {
        
        public typealias UnderlyingMessage = EventStore_Client_Projections_DeleteReq.Options
        
        public var options: UnderlyingMessage
        
        public init() {
            self.options = .init()
            self.deleteCheckpointStream(enabled: false)
            self.deleteEmittedStreams(enabled: false)
            self.deleteStateStream(enabled: false)
        }
        
        public func build() -> UnderlyingMessage {
            return options
        }
        
        @discardableResult
        public func deleteEmittedStreams(enabled: Bool)->Self{
            self.options.deleteEmittedStreams = enabled
            return self
        }
        
        @discardableResult
        public func deleteStateStream(enabled: Bool)->Self{
            self.options.deleteStateStream = enabled
            return self
        }
        
        @discardableResult
        public func deleteCheckpointStream(enabled: Bool)->Self{
            self.options.deleteCheckpointStream = enabled
            return self
        }
        
    }
}
