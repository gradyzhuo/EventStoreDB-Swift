//
//  ResponseHandlable.swift
//
//
//  Created by Grady Zhuo on 2023/12/7.
//

import Foundation
import GRPC

public protocol ResponseHandlable {}

public protocol UnaryResponseHandlable: ResponseHandlable where Self: GRPCCallable {
    func handle(response: Response.UnderlyingMessage) throws -> Response
}

extension UnaryResponseHandlable {
    @discardableResult
    public func handle(response: Response.UnderlyingMessage) throws -> Response {
        try .init(from: response)
    }
}

public protocol StreamResponseHandlable: UnaryResponseHandlable where Self: GRPCCallable {
    func handle(responses: GRPCAsyncResponseStream<Response.UnderlyingMessage>) throws -> AsyncStream<Response>
}

extension StreamResponseHandlable {
    public typealias Responses = AsyncStream<Self.Response>

    @discardableResult
    public func handle(responses: GRPCAsyncResponseStream<Response.UnderlyingMessage>) throws -> Responses {
        .init { continuation in
            Task {
                for try await message in responses {
                    let response = try self.handle(response: message)
                    continuation.yield(response)
                }
                continuation.finish()
            }
        }
    }
}
