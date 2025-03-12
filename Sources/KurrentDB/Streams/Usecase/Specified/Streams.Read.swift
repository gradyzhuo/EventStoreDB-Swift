//
//  Streams.Read.swift
//  KurrentStreams
//
//  Created by Grady Zhuo on 2023/10/21.
//

import GRPCCore
import GRPCEncapsulates

extension Streams{
    public struct Read: UnaryStream {
        package typealias ServiceClient = UnderlyingClient
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.Read.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.Read.Output
        public typealias Response = ReadResponse
        public typealias Responses = AsyncThrowingStream<Response, Error>

        public let streamIdentifier: StreamIdentifier
        public let cursor: Cursor<CursorPointer>
        public let options: Options

        init(from streamIdentifier: StreamIdentifier, cursor: Cursor<CursorPointer>, options: Options) {
            self.streamIdentifier = streamIdentifier
            self.cursor = cursor
            self.options = options
        }

        package func requestMessage() throws -> UnderlyingRequest {
            try .with {
                $0.options = options.build()
                $0.options.stream.streamIdentifier = try streamIdentifier.build()

                switch cursor {
                case .start:
                    $0.options.stream.start = .init()
                    $0.options.readDirection = .forwards
                case .end:
                    $0.options.stream.end = .init()
                    $0.options.readDirection = .backwards
                case let .specified(pointer):
                    $0.options.stream.revision = pointer.revision

                    if case .forward = pointer.direction {
                        $0.options.readDirection = .forwards
                    } else {
                        $0.options.readDirection = .backwards
                    }
                }
            }
        }

        package func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Responses {
            try await withThrowingTaskGroup(of: Void.self) { _ in
                let (stream, continuation) = AsyncThrowingStream.makeStream(of: Response.self)
                try await client.read(request: request, options: callOptions) {
                    for try await message in $0.messages {
                        try continuation.yield(handle(message: message))
                    }
                }
                continuation.finish()
                return stream
            }
        }
    }
}

extension Streams.Read {
    public struct Options: EventStoreOptions {
        package typealias UnderlyingMessage = UnderlyingRequest.Options

        public private(set) var resolveLinks: Bool
        public private(set) var limit: UInt64
        public private(set) var uuidOption: UUIDOption
        public private(set) var compatibility: UInt32

        public init(resolveLinks: Bool = false, limit: UInt64 = .max, uuidOption: UUIDOption = .string, compatibility: UInt32 = 0) {
            self.resolveLinks = resolveLinks
            self.limit = limit
            self.uuidOption = uuidOption
            self.compatibility = compatibility
        }

        package func build() -> UnderlyingMessage {
            .with {
                $0.noFilter = .init()

                switch uuidOption {
                case .structured:
                    $0.uuidOption.structured = .init()
                case .string:
                    $0.uuidOption.string = .init()
                }

                $0.controlOption = .with {
                    $0.compatibility = compatibility
                }
                $0.resolveLinks = resolveLinks
                $0.count = limit
            }
        }

        @discardableResult
        public func set(resolveLinks: Bool) -> Self {
            withCopy { options in
                options.resolveLinks = resolveLinks
            }
        }

        @discardableResult
        public func set(limit: UInt64) -> Self {
            withCopy { options in
                options.limit = limit
            }
        }

        @discardableResult
        public func set(uuidOption: UUIDOption) -> Self {
            withCopy { options in
                options.uuidOption = uuidOption
            }
        }

        @discardableResult
        public func set(compatibility: UInt32) -> Self {
            withCopy { options in
                options.compatibility = compatibility
            }
        }
    }
}
