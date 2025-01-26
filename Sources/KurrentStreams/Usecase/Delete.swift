//
//  StreamClient.Delete.swift
//  KurrentDB
//
//  Created by Grady Zhuo on 2023/10/31.
//

import KurrentCore
import GRPCCore
import GRPCEncapsulates

extension Streams {
    public struct Delete: UnaryUnary {
        package typealias ServiceClient = Client
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.Delete.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.Delete.Output

        public let streamIdentifier: StreamIdentifier
        public let options: Options
        
        internal init(streamIdentifier: StreamIdentifier, options: Options) {
            self.streamIdentifier = streamIdentifier
            self.options = options
        }
        
        package func requestMessage() throws -> UnderlyingRequest {
            return try .with {
                $0.options = options.build()
                $0.options.streamIdentifier = try streamIdentifier.build()
            }
        }
        
        package func send(client: ServiceClient, request: GRPCCore.ClientRequest<UnderlyingRequest>, callOptions: GRPCCore.CallOptions) async throws -> Response {
            return try await client.delete(request: request, options: callOptions){
                try handle(response: $0)
            }
        }
        
    }
}

extension Streams.Delete {
    public struct Response: GRPCResponse {
        package typealias UnderlyingMessage = UnderlyingResponse

        public internal(set) var position: StreamPosition?

        package init(from message: UnderlyingMessage) throws {
            self.position = message.positionOption.flatMap{
                return switch $0 {
                case let .position(position):
                        .at(commitPosition: position.commitPosition, preparePosition: position.preparePosition)
                case .noPosition:
                    nil
                }
            }
        }
    }
}

extension Streams.Delete {
    public struct Options: EventStoreOptions {
        package typealias UnderlyingMessage = UnderlyingRequest.Options

        public private(set) var expectedRevision: StreamRevisionRule

        public init() {
            expectedRevision = .streamExists
        }

        package func build() -> UnderlyingMessage {
            .with {
                switch expectedRevision {
                case .any:
                    $0.any = .init()
                case .noStream:
                    $0.noStream = .init()
                case .streamExists:
                    $0.streamExists = .init()
                case let .revision(rev):
                    $0.revision = rev
                }
            }
        }

        @discardableResult
        public func revision(expected: StreamRevisionRule) -> Self {
            withCopy { options in
                options.expectedRevision = expected
            }
        }
    }
}
