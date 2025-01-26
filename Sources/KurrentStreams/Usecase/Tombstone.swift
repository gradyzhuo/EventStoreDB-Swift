//
//  StreamClient.Tombstone.swift
//
//
//  Created by Grady Zhuo on 2023/11/2.
//
import KurrentCore
import GRPCCore
import GRPCNIOTransportHTTP2Posix
import GRPCEncapsulates

extension Streams {
    public struct Tombstone: UnaryUnary {
        package typealias ServiceClient = Client
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.Tombstone.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.Tombstone.Output

        public let streamIdentifier: StreamIdentifier
        public let options: Options
        
        package func requestMessage() throws -> UnderlyingRequest {
            return try .with {
                var options = options.build()
                options.streamIdentifier = try streamIdentifier.build()
                $0.options = options
            }
        }
        
        package func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Response {
            return try await client.tombstone(request: request, options: callOptions){
                try handle(response: $0)
            }
        }
    }
}

extension Streams.Tombstone {
    public struct Response: GRPCResponse {
        package typealias UnderlyingMessage = UnderlyingResponse

        public internal(set) var position: StreamPosition?

        package init(from message: UnderlyingMessage) throws {
            self.position  = message.positionOption.flatMap{
                switch $0 {
                case let .position(position):
                        .at(commitPosition: position.commitPosition, preparePosition: position.preparePosition)
                case .noPosition:
                    nil
                }
            }
        }
    }
}

extension Streams.Tombstone {
    public struct Options: EventStoreOptions {
        package typealias UnderlyingMessage = UnderlyingRequest.Options

        public private(set) var expectedRevision: StreamRevisionRule

        public init(expectedRevision: StreamRevisionRule = .streamExists) {
            self.expectedRevision = expectedRevision
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
        public func revision(expected expectedRevision: StreamRevisionRule) -> Self {
            withCopy { options in
                options.expectedRevision = expectedRevision
            }
        }
    }
}
