//
//  File.swift
//  
//
//  Created by Ospark.org on 2023/10/31.
//

import Foundation
import GRPC

@available(macOS 10.15, *)
extension Stream {
    
    @available(macOS 13.0, *)
    @discardableResult
    public static func delete(identifier: Stream.Identifier, expected expectedRevision: Stream.Revision<Stream.Delete.Client.UnderlyingRequest.Options.OneOf_ExpectedStreamRevision>) async throws -> Delete.Client.BingingResponse {
        
        let channel = try GRPCChannelPool.with(settings: EventStore.shared.settings)
        let underlyingClient = Stream.UnderlyingClient(channel: channel)
        
        let client = Stream.Delete.Client.init(underlyingClient: underlyingClient)
        
        let options = Stream.Delete.Options()
        options.expected(revision: expectedRevision)
        
        let request = try Delete.Client.buildRequests(streamIdentifier: identifier, options: options)
        
        return try await client.call(request: request)
    }
    
    
}
