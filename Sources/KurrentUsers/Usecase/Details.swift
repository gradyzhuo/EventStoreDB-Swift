//
//  UserClient.Details.swift
//
//
//  Created by Grady Zhuo on 2023/12/20.
//

import Foundation
import GRPCCore
import GRPCNIOTransportHTTP2Posix
import GRPCEncapsulates

extension Users {
    public struct Details: UnaryStream {
        package typealias ServiceClient = Client
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.Details.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.Details.Output
        package typealias Responses = AsyncThrowingStream<UserDetails, any Error>

        public let loginName: String

        public init(loginName: String) {
            self.loginName = loginName
        }
        
        package func requestMessage() throws -> UnderlyingRequest {
            return .with {
                $0.options.loginName = loginName
            }
        }
        
        package func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Responses {
            return try await withThrowingDiscardingTaskGroup { group in
                let (stream, continuation) = AsyncThrowingStream.makeStream(of: UserDetails.self)
                try await client.details(request: request, options: callOptions) {
                    for try await message in $0.messages {
                        let response = try handle(message: message)
                        continuation.yield(response.userDetails)
                    }
                }
                continuation.finish()
                return stream
            }
        }
    }
}

extension Users.Details {
    public struct Response: GRPCResponse {
        package typealias UnderlyingMessage = UnderlyingResponse

        let userDetails: UserDetails

        package init(from message: UnderlyingMessage) throws {
            userDetails = try .init(from: message.userDetails)
        }
    }
}
