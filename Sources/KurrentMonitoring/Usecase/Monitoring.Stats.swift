//
//  Monitoring.Stats.swift
//
//
//  Created by Grady Zhuo on 2023/12/11.
//

import GRPCCore
import GRPCEncapsulates

extension Monitoring {
    public struct Stats: UnaryStream {
        package typealias ServiceClient = Client
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.Stats.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.Stats.Output
        package typealias Responses = AsyncThrowingStream<Response, any Error>

        public let useMetadata: Bool
        public let refreshTimePeriodInMs: UInt64
        
        public init(useMetadata: Bool = false, refreshTimePeriodInMs: UInt64 = 10000) {
            self.useMetadata = useMetadata
            self.refreshTimePeriodInMs = refreshTimePeriodInMs
        }

        package func requestMessage() throws -> UnderlyingRequest {
            return .with {
                $0.useMetadata = useMetadata
                $0.refreshTimePeriodInMs = refreshTimePeriodInMs
            }
        }
        
        package func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Responses {
            let (stream, continuation) = AsyncThrowingStream.makeStream(of: Response.self)
            Task{
                try await client.stats(request: request, options: callOptions) {
                    for try await message in $0.messages {
                        try continuation.yield(.init(from: message))
                    }
                }
            }
            return stream
        }
    }
}

extension Monitoring.Stats {
    public struct Response: GRPCResponse {
        package typealias UnderlyingMessage = UnderlyingResponse

        var stats: [String: String]

        package init(from message: UnderlyingMessage) throws {
            stats = message.stats
        }
    }
}
