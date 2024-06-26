//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: protos/streams.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf

/// Usage: instantiate `EventStore_Client_Streams_StreamsClient`, then call methods of this protocol to make API calls.
public protocol EventStore_Client_Streams_StreamsClientProtocol: GRPCClient {
    var serviceName: String { get }
    var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? { get }

    func read(
        _ request: EventStore_Client_Streams_ReadReq,
        callOptions: CallOptions?,
        handler: @escaping (EventStore_Client_Streams_ReadResp) -> Void
    ) -> ServerStreamingCall<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp>

    func append(
        callOptions: CallOptions?
    ) -> ClientStreamingCall<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp>

    func delete(
        _ request: EventStore_Client_Streams_DeleteReq,
        callOptions: CallOptions?
    ) -> UnaryCall<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp>

    func tombstone(
        _ request: EventStore_Client_Streams_TombstoneReq,
        callOptions: CallOptions?
    ) -> UnaryCall<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp>

    func batchAppend(
        callOptions: CallOptions?,
        handler: @escaping (EventStore_Client_Streams_BatchAppendResp) -> Void
    ) -> BidirectionalStreamingCall<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp>
}

extension EventStore_Client_Streams_StreamsClientProtocol {
    public var serviceName: String {
        "event_store.client.streams.Streams"
    }

    /// Server streaming call to Read
    ///
    /// - Parameters:
    ///   - request: Request to send to Read.
    ///   - callOptions: Call options.
    ///   - handler: A closure called when each response is received from the server.
    /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
    public func read(
        _ request: EventStore_Client_Streams_ReadReq,
        callOptions: CallOptions? = nil,
        handler: @escaping (EventStore_Client_Streams_ReadResp) -> Void
    ) -> ServerStreamingCall<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp> {
        makeServerStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.read.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeReadInterceptors() ?? [],
            handler: handler
        )
    }

    /// Client streaming call to Append
    ///
    /// Callers should use the `send` method on the returned object to send messages
    /// to the server. The caller should send an `.end` after the final message has been sent.
    ///
    /// - Parameters:
    ///   - callOptions: Call options.
    /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
    public func append(
        callOptions: CallOptions? = nil
    ) -> ClientStreamingCall<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp> {
        makeClientStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.append.path,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeAppendInterceptors() ?? []
        )
    }

    /// Unary call to Delete
    ///
    /// - Parameters:
    ///   - request: Request to send to Delete.
    ///   - callOptions: Call options.
    /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
    public func delete(
        _ request: EventStore_Client_Streams_DeleteReq,
        callOptions: CallOptions? = nil
    ) -> UnaryCall<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp> {
        makeUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.delete.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeDeleteInterceptors() ?? []
        )
    }

    /// Unary call to Tombstone
    ///
    /// - Parameters:
    ///   - request: Request to send to Tombstone.
    ///   - callOptions: Call options.
    /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
    public func tombstone(
        _ request: EventStore_Client_Streams_TombstoneReq,
        callOptions: CallOptions? = nil
    ) -> UnaryCall<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp> {
        makeUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.tombstone.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeTombstoneInterceptors() ?? []
        )
    }

    /// Bidirectional streaming call to BatchAppend
    ///
    /// Callers should use the `send` method on the returned object to send messages
    /// to the server. The caller should send an `.end` after the final message has been sent.
    ///
    /// - Parameters:
    ///   - callOptions: Call options.
    ///   - handler: A closure called when each response is received from the server.
    /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
    public func batchAppend(
        callOptions: CallOptions? = nil,
        handler: @escaping (EventStore_Client_Streams_BatchAppendResp) -> Void
    ) -> BidirectionalStreamingCall<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp> {
        makeBidirectionalStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.batchAppend.path,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeBatchAppendInterceptors() ?? [],
            handler: handler
        )
    }
}

@available(*, deprecated)
extension EventStore_Client_Streams_StreamsClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "EventStore_Client_Streams_StreamsNIOClient")
public final class EventStore_Client_Streams_StreamsClient: EventStore_Client_Streams_StreamsClientProtocol {
    private let lock = Lock()
    private var _defaultCallOptions: CallOptions
    private var _interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol?
    public let channel: GRPCChannel
    public var defaultCallOptions: CallOptions {
        get { lock.withLock { self._defaultCallOptions } }
        set { lock.withLockVoid { self._defaultCallOptions = newValue } }
    }

    public var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? {
        get { lock.withLock { self._interceptors } }
        set { lock.withLockVoid { self._interceptors = newValue } }
    }

    /// Creates a client for the event_store.client.streams.Streams service.
    ///
    /// - Parameters:
    ///   - channel: `GRPCChannel` to the service host.
    ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
    ///   - interceptors: A factory providing interceptors for each RPC.
    public init(
        channel: GRPCChannel,
        defaultCallOptions: CallOptions = CallOptions(),
        interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? = nil
    ) {
        self.channel = channel
        _defaultCallOptions = defaultCallOptions
        _interceptors = interceptors
    }
}

public struct EventStore_Client_Streams_StreamsNIOClient: EventStore_Client_Streams_StreamsClientProtocol {
    public var channel: GRPCChannel
    public var defaultCallOptions: CallOptions
    public var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol?

    /// Creates a client for the event_store.client.streams.Streams service.
    ///
    /// - Parameters:
    ///   - channel: `GRPCChannel` to the service host.
    ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
    ///   - interceptors: A factory providing interceptors for each RPC.
    public init(
        channel: GRPCChannel,
        defaultCallOptions: CallOptions = CallOptions(),
        interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? = nil
    ) {
        self.channel = channel
        self.defaultCallOptions = defaultCallOptions
        self.interceptors = interceptors
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol EventStore_Client_Streams_StreamsAsyncClientProtocol: GRPCClient {
    static var serviceDescriptor: GRPCServiceDescriptor { get }
    var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? { get }

    func makeReadCall(
        _ request: EventStore_Client_Streams_ReadReq,
        callOptions: CallOptions?
    ) -> GRPCAsyncServerStreamingCall<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp>

    func makeAppendCall(
        callOptions: CallOptions?
    ) -> GRPCAsyncClientStreamingCall<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp>

    func makeDeleteCall(
        _ request: EventStore_Client_Streams_DeleteReq,
        callOptions: CallOptions?
    ) -> GRPCAsyncUnaryCall<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp>

    func makeTombstoneCall(
        _ request: EventStore_Client_Streams_TombstoneReq,
        callOptions: CallOptions?
    ) -> GRPCAsyncUnaryCall<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp>

    func makeBatchAppendCall(
        callOptions: CallOptions?
    ) -> GRPCAsyncBidirectionalStreamingCall<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension EventStore_Client_Streams_StreamsAsyncClientProtocol {
    public static var serviceDescriptor: GRPCServiceDescriptor {
        EventStore_Client_Streams_StreamsClientMetadata.serviceDescriptor
    }

    public var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? {
        nil
    }

    public func makeReadCall(
        _ request: EventStore_Client_Streams_ReadReq,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncServerStreamingCall<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp> {
        makeAsyncServerStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.read.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeReadInterceptors() ?? []
        )
    }

    public func makeAppendCall(
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncClientStreamingCall<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp> {
        makeAsyncClientStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.append.path,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeAppendInterceptors() ?? []
        )
    }

    public func makeDeleteCall(
        _ request: EventStore_Client_Streams_DeleteReq,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncUnaryCall<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp> {
        makeAsyncUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.delete.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeDeleteInterceptors() ?? []
        )
    }

    public func makeTombstoneCall(
        _ request: EventStore_Client_Streams_TombstoneReq,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncUnaryCall<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp> {
        makeAsyncUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.tombstone.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeTombstoneInterceptors() ?? []
        )
    }

    public func makeBatchAppendCall(
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncBidirectionalStreamingCall<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp> {
        makeAsyncBidirectionalStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.batchAppend.path,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeBatchAppendInterceptors() ?? []
        )
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension EventStore_Client_Streams_StreamsAsyncClientProtocol {
    public func read(
        _ request: EventStore_Client_Streams_ReadReq,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncResponseStream<EventStore_Client_Streams_ReadResp> {
        performAsyncServerStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.read.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeReadInterceptors() ?? []
        )
    }

    public func append(
        _ requests: some Sequence<EventStore_Client_Streams_AppendReq>,
        callOptions: CallOptions? = nil
    ) async throws -> EventStore_Client_Streams_AppendResp {
        try await performAsyncClientStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.append.path,
            requests: requests,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeAppendInterceptors() ?? []
        )
    }

    public func append<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) async throws -> EventStore_Client_Streams_AppendResp where RequestStream: AsyncSequence & Sendable, RequestStream.Element == EventStore_Client_Streams_AppendReq {
        try await performAsyncClientStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.append.path,
            requests: requests,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeAppendInterceptors() ?? []
        )
    }

    public func delete(
        _ request: EventStore_Client_Streams_DeleteReq,
        callOptions: CallOptions? = nil
    ) async throws -> EventStore_Client_Streams_DeleteResp {
        try await performAsyncUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.delete.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeDeleteInterceptors() ?? []
        )
    }

    public func tombstone(
        _ request: EventStore_Client_Streams_TombstoneReq,
        callOptions: CallOptions? = nil
    ) async throws -> EventStore_Client_Streams_TombstoneResp {
        try await performAsyncUnaryCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.tombstone.path,
            request: request,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeTombstoneInterceptors() ?? []
        )
    }

    public func batchAppend(
        _ requests: some Sequence<EventStore_Client_Streams_BatchAppendReq>,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncResponseStream<EventStore_Client_Streams_BatchAppendResp> {
        performAsyncBidirectionalStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.batchAppend.path,
            requests: requests,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeBatchAppendInterceptors() ?? []
        )
    }

    public func batchAppend<RequestStream>(
        _ requests: RequestStream,
        callOptions: CallOptions? = nil
    ) -> GRPCAsyncResponseStream<EventStore_Client_Streams_BatchAppendResp> where RequestStream: AsyncSequence & Sendable, RequestStream.Element == EventStore_Client_Streams_BatchAppendReq {
        performAsyncBidirectionalStreamingCall(
            path: EventStore_Client_Streams_StreamsClientMetadata.Methods.batchAppend.path,
            requests: requests,
            callOptions: callOptions ?? defaultCallOptions,
            interceptors: interceptors?.makeBatchAppendInterceptors() ?? []
        )
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct EventStore_Client_Streams_StreamsAsyncClient: EventStore_Client_Streams_StreamsAsyncClientProtocol {
    public var channel: GRPCChannel
    public var defaultCallOptions: CallOptions
    public var interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol?

    public init(
        channel: GRPCChannel,
        defaultCallOptions: CallOptions = CallOptions(),
        interceptors: EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol? = nil
    ) {
        self.channel = channel
        self.defaultCallOptions = defaultCallOptions
        self.interceptors = interceptors
    }
}

public protocol EventStore_Client_Streams_StreamsClientInterceptorFactoryProtocol: Sendable {
    /// - Returns: Interceptors to use when invoking 'read'.
    func makeReadInterceptors() -> [ClientInterceptor<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp>]

    /// - Returns: Interceptors to use when invoking 'append'.
    func makeAppendInterceptors() -> [ClientInterceptor<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp>]

    /// - Returns: Interceptors to use when invoking 'delete'.
    func makeDeleteInterceptors() -> [ClientInterceptor<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp>]

    /// - Returns: Interceptors to use when invoking 'tombstone'.
    func makeTombstoneInterceptors() -> [ClientInterceptor<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp>]

    /// - Returns: Interceptors to use when invoking 'batchAppend'.
    func makeBatchAppendInterceptors() -> [ClientInterceptor<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp>]
}

public enum EventStore_Client_Streams_StreamsClientMetadata {
    public static let serviceDescriptor = GRPCServiceDescriptor(
        name: "Streams",
        fullName: "event_store.client.streams.Streams",
        methods: [
            EventStore_Client_Streams_StreamsClientMetadata.Methods.read,
            EventStore_Client_Streams_StreamsClientMetadata.Methods.append,
            EventStore_Client_Streams_StreamsClientMetadata.Methods.delete,
            EventStore_Client_Streams_StreamsClientMetadata.Methods.tombstone,
            EventStore_Client_Streams_StreamsClientMetadata.Methods.batchAppend,
        ]
    )

    public enum Methods {
        public static let read = GRPCMethodDescriptor(
            name: "Read",
            path: "/event_store.client.streams.Streams/Read",
            type: GRPCCallType.serverStreaming
        )

        public static let append = GRPCMethodDescriptor(
            name: "Append",
            path: "/event_store.client.streams.Streams/Append",
            type: GRPCCallType.clientStreaming
        )

        public static let delete = GRPCMethodDescriptor(
            name: "Delete",
            path: "/event_store.client.streams.Streams/Delete",
            type: GRPCCallType.unary
        )

        public static let tombstone = GRPCMethodDescriptor(
            name: "Tombstone",
            path: "/event_store.client.streams.Streams/Tombstone",
            type: GRPCCallType.unary
        )

        public static let batchAppend = GRPCMethodDescriptor(
            name: "BatchAppend",
            path: "/event_store.client.streams.Streams/BatchAppend",
            type: GRPCCallType.bidirectionalStreaming
        )
    }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol EventStore_Client_Streams_StreamsProvider: CallHandlerProvider {
    var interceptors: EventStore_Client_Streams_StreamsServerInterceptorFactoryProtocol? { get }

    func read(request: EventStore_Client_Streams_ReadReq, context: StreamingResponseCallContext<EventStore_Client_Streams_ReadResp>) -> EventLoopFuture<GRPCStatus>

    func append(context: UnaryResponseCallContext<EventStore_Client_Streams_AppendResp>) -> EventLoopFuture<(StreamEvent<EventStore_Client_Streams_AppendReq>) -> Void>

    func delete(request: EventStore_Client_Streams_DeleteReq, context: StatusOnlyCallContext) -> EventLoopFuture<EventStore_Client_Streams_DeleteResp>

    func tombstone(request: EventStore_Client_Streams_TombstoneReq, context: StatusOnlyCallContext) -> EventLoopFuture<EventStore_Client_Streams_TombstoneResp>

    func batchAppend(context: StreamingResponseCallContext<EventStore_Client_Streams_BatchAppendResp>) -> EventLoopFuture<(StreamEvent<EventStore_Client_Streams_BatchAppendReq>) -> Void>
}

extension EventStore_Client_Streams_StreamsProvider {
    public var serviceName: Substring {
        EventStore_Client_Streams_StreamsServerMetadata.serviceDescriptor.fullName[...]
    }

    /// Determines, calls and returns the appropriate request handler, depending on the request's method.
    /// Returns nil for methods not handled by this service.
    public func handle(
        method name: Substring,
        context: CallHandlerContext
    ) -> GRPCServerHandlerProtocol? {
        switch name {
        case "Read":
            ServerStreamingServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_ReadReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_ReadResp>(),
                interceptors: interceptors?.makeReadInterceptors() ?? [],
                userFunction: read(request:context:)
            )

        case "Append":
            ClientStreamingServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_AppendReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_AppendResp>(),
                interceptors: interceptors?.makeAppendInterceptors() ?? [],
                observerFactory: append(context:)
            )

        case "Delete":
            UnaryServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_DeleteReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_DeleteResp>(),
                interceptors: interceptors?.makeDeleteInterceptors() ?? [],
                userFunction: delete(request:context:)
            )

        case "Tombstone":
            UnaryServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_TombstoneReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_TombstoneResp>(),
                interceptors: interceptors?.makeTombstoneInterceptors() ?? [],
                userFunction: tombstone(request:context:)
            )

        case "BatchAppend":
            BidirectionalStreamingServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_BatchAppendReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_BatchAppendResp>(),
                interceptors: interceptors?.makeBatchAppendInterceptors() ?? [],
                observerFactory: batchAppend(context:)
            )

        default:
            nil
        }
    }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol EventStore_Client_Streams_StreamsAsyncProvider: CallHandlerProvider, Sendable {
    static var serviceDescriptor: GRPCServiceDescriptor { get }
    var interceptors: EventStore_Client_Streams_StreamsServerInterceptorFactoryProtocol? { get }

    func read(
        request: EventStore_Client_Streams_ReadReq,
        responseStream: GRPCAsyncResponseStreamWriter<EventStore_Client_Streams_ReadResp>,
        context: GRPCAsyncServerCallContext
    ) async throws

    func append(
        requestStream: GRPCAsyncRequestStream<EventStore_Client_Streams_AppendReq>,
        context: GRPCAsyncServerCallContext
    ) async throws -> EventStore_Client_Streams_AppendResp

    func delete(
        request: EventStore_Client_Streams_DeleteReq,
        context: GRPCAsyncServerCallContext
    ) async throws -> EventStore_Client_Streams_DeleteResp

    func tombstone(
        request: EventStore_Client_Streams_TombstoneReq,
        context: GRPCAsyncServerCallContext
    ) async throws -> EventStore_Client_Streams_TombstoneResp

    func batchAppend(
        requestStream: GRPCAsyncRequestStream<EventStore_Client_Streams_BatchAppendReq>,
        responseStream: GRPCAsyncResponseStreamWriter<EventStore_Client_Streams_BatchAppendResp>,
        context: GRPCAsyncServerCallContext
    ) async throws
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension EventStore_Client_Streams_StreamsAsyncProvider {
    public static var serviceDescriptor: GRPCServiceDescriptor {
        EventStore_Client_Streams_StreamsServerMetadata.serviceDescriptor
    }

    public var serviceName: Substring {
        EventStore_Client_Streams_StreamsServerMetadata.serviceDescriptor.fullName[...]
    }

    public var interceptors: EventStore_Client_Streams_StreamsServerInterceptorFactoryProtocol? {
        nil
    }

    public func handle(
        method name: Substring,
        context: CallHandlerContext
    ) -> GRPCServerHandlerProtocol? {
        switch name {
        case "Read":
            GRPCAsyncServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_ReadReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_ReadResp>(),
                interceptors: interceptors?.makeReadInterceptors() ?? [],
                wrapping: { try await self.read(request: $0, responseStream: $1, context: $2) }
            )

        case "Append":
            GRPCAsyncServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_AppendReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_AppendResp>(),
                interceptors: interceptors?.makeAppendInterceptors() ?? [],
                wrapping: { try await self.append(requestStream: $0, context: $1) }
            )

        case "Delete":
            GRPCAsyncServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_DeleteReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_DeleteResp>(),
                interceptors: interceptors?.makeDeleteInterceptors() ?? [],
                wrapping: { try await self.delete(request: $0, context: $1) }
            )

        case "Tombstone":
            GRPCAsyncServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_TombstoneReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_TombstoneResp>(),
                interceptors: interceptors?.makeTombstoneInterceptors() ?? [],
                wrapping: { try await self.tombstone(request: $0, context: $1) }
            )

        case "BatchAppend":
            GRPCAsyncServerHandler(
                context: context,
                requestDeserializer: ProtobufDeserializer<EventStore_Client_Streams_BatchAppendReq>(),
                responseSerializer: ProtobufSerializer<EventStore_Client_Streams_BatchAppendResp>(),
                interceptors: interceptors?.makeBatchAppendInterceptors() ?? [],
                wrapping: { try await self.batchAppend(requestStream: $0, responseStream: $1, context: $2) }
            )

        default:
            nil
        }
    }
}

public protocol EventStore_Client_Streams_StreamsServerInterceptorFactoryProtocol: Sendable {
    /// - Returns: Interceptors to use when handling 'read'.
    ///   Defaults to calling `self.makeInterceptors()`.
    func makeReadInterceptors() -> [ServerInterceptor<EventStore_Client_Streams_ReadReq, EventStore_Client_Streams_ReadResp>]

    /// - Returns: Interceptors to use when handling 'append'.
    ///   Defaults to calling `self.makeInterceptors()`.
    func makeAppendInterceptors() -> [ServerInterceptor<EventStore_Client_Streams_AppendReq, EventStore_Client_Streams_AppendResp>]

    /// - Returns: Interceptors to use when handling 'delete'.
    ///   Defaults to calling `self.makeInterceptors()`.
    func makeDeleteInterceptors() -> [ServerInterceptor<EventStore_Client_Streams_DeleteReq, EventStore_Client_Streams_DeleteResp>]

    /// - Returns: Interceptors to use when handling 'tombstone'.
    ///   Defaults to calling `self.makeInterceptors()`.
    func makeTombstoneInterceptors() -> [ServerInterceptor<EventStore_Client_Streams_TombstoneReq, EventStore_Client_Streams_TombstoneResp>]

    /// - Returns: Interceptors to use when handling 'batchAppend'.
    ///   Defaults to calling `self.makeInterceptors()`.
    func makeBatchAppendInterceptors() -> [ServerInterceptor<EventStore_Client_Streams_BatchAppendReq, EventStore_Client_Streams_BatchAppendResp>]
}

public enum EventStore_Client_Streams_StreamsServerMetadata {
    public static let serviceDescriptor = GRPCServiceDescriptor(
        name: "Streams",
        fullName: "event_store.client.streams.Streams",
        methods: [
            EventStore_Client_Streams_StreamsServerMetadata.Methods.read,
            EventStore_Client_Streams_StreamsServerMetadata.Methods.append,
            EventStore_Client_Streams_StreamsServerMetadata.Methods.delete,
            EventStore_Client_Streams_StreamsServerMetadata.Methods.tombstone,
            EventStore_Client_Streams_StreamsServerMetadata.Methods.batchAppend,
        ]
    )

    public enum Methods {
        public static let read = GRPCMethodDescriptor(
            name: "Read",
            path: "/event_store.client.streams.Streams/Read",
            type: GRPCCallType.serverStreaming
        )

        public static let append = GRPCMethodDescriptor(
            name: "Append",
            path: "/event_store.client.streams.Streams/Append",
            type: GRPCCallType.clientStreaming
        )

        public static let delete = GRPCMethodDescriptor(
            name: "Delete",
            path: "/event_store.client.streams.Streams/Delete",
            type: GRPCCallType.unary
        )

        public static let tombstone = GRPCMethodDescriptor(
            name: "Tombstone",
            path: "/event_store.client.streams.Streams/Tombstone",
            type: GRPCCallType.unary
        )

        public static let batchAppend = GRPCMethodDescriptor(
            name: "BatchAppend",
            path: "/event_store.client.streams.Streams/BatchAppend",
            type: GRPCCallType.bidirectionalStreaming
        )
    }
}
