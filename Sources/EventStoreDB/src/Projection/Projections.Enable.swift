//
//  File.swift
//
//
//  Created by Ospark.org on 2023/11/27.
//

import Foundation
import GRPCSupport

@available(macOS 13.0, *)
extension ProjectionsClient {
    
    public struct Enable: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_Projections_EnableReq>
        public typealias Response = DiscardedResponse<EventStore_Client_Projections_EnableResp>
        
        public let name: String
        public let options: Options
        
        init(name: String, options: Options) {
            self.name = name
            self.options = options
        }
        
        public func build() throws -> Request.UnderlyingMessage {
            return .with{
                $0.options = options.build()
                $0.options.name = name
            }
        }
        
    }
    
}

@available(macOS 13.0, *)
extension ProjectionsClient.Enable{
    public final class Options: EventStoreOptions {
        
        public typealias UnderlyingMessage = EventStore_Client_Projections_EnableReq.Options
        
        var options: UnderlyingMessage
        
        public init() {
            self.options = .init()
        }
        
        
        public func build() -> UnderlyingMessage {
            return options
        }
        
    }
}
