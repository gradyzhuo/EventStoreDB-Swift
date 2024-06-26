//
//  PersistentSubscriptionsClient.Delete.swift
//
//
//  Created by Grady Zhuo on 2023/12/7.
//

import Foundation
import GRPCEncapsulates

extension PersistentSubscriptionsClient {
    public struct Delete: UnaryUnary {
        public typealias Response = DiscardedResponse<EventStore_Client_PersistentSubscriptions_DeleteResp>

        let streamSelection: Selector<Stream.Identifier>
        let groupName: String

        public func build() throws -> Request.UnderlyingMessage {
            try .with {
                $0.options.groupName = groupName
                switch streamSelection {
                case .all:
                    $0.options.all = .init()
                case let .specified(streamIdentifier):
                    $0.options.streamIdentifier = try streamIdentifier.build()
                }
            }
        }
    }
}

extension PersistentSubscriptionsClient.Delete {
    public struct Request: GRPCRequest {
        public typealias UnderlyingMessage = EventStore_Client_PersistentSubscriptions_DeleteReq
    }
}
