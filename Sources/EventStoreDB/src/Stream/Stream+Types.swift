//
//  File.swift
//  
//
//  Created by Ospark.org on 2023/11/23.
//

import Foundation
import GRPC
import GRPCSupport

public protocol ExpectedStreamRevisionProtocol{
    static func any(_ value: EventStore_Client_Empty)->Self
    static func noStream(_ value: EventStore_Client_Empty)->Self
    static func streamExists(_ value: EventStore_Client_Empty)->Self
    static func revision(_ value: UInt64)->Self
}

extension EventStore_Client_Streams_AppendReq.Options.OneOf_ExpectedStreamRevision : ExpectedStreamRevisionProtocol {}
extension EventStore_Client_Streams_DeleteReq.Options.OneOf_ExpectedStreamRevision : ExpectedStreamRevisionProtocol {}
extension EventStore_Client_Streams_TombstoneReq.Options.OneOf_ExpectedStreamRevision : ExpectedStreamRevisionProtocol {}


@available(macOS 13.0, *)
extension StreamClient {
    public struct Identifier {
        typealias UnderlyingMessage = EventStore_Client_StreamIdentifier
        
        public let name: String
        public let encoding: String.Encoding = .utf8
    }
    
    public struct Position{
        public let commit: UInt64
        public let prepare: UInt64?
        
        public init(commit: UInt64, prepare: UInt64? = nil) {
            self.commit = commit
            self.prepare = prepare
        }
    }
    
    public enum Revision {
        case any
        case noStream
        case streamExists
        case revision(UInt64)
    }
    
}



@available(macOS 13.0, *)
extension StreamClient.Identifier: ExpressibleByStringLiteral{
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(name: value)
    }
    
}

@available(macOS 13.0, *)
extension StreamClient.Identifier {
    
    internal func build() throws -> UnderlyingMessage {
        guard let streamName = self.name.data(using: self.encoding) else {
            throw ClientError.streamNameError(message: "name: \(self.name), encoding: \(self.encoding)")
        }
        
        return .with{
            $0.streamName = streamName
        }
    }
}

@available(macOS 13.0, *)
extension StreamClient.Position {
    public enum Option {
        case noPosition
        case position(StreamClient.Position)
    }
    
}


