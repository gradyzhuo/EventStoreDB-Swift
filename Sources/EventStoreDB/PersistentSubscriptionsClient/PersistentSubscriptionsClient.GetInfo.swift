//
//  PersistentSubscriptionsClient.GetInfo.swift
//
//
//  Created by Grady Zhuo on 2023/12/10.
//

import Foundation
import GRPCEncapsulates

extension PersistentSubscriptionsClient {
    public struct GetInfo: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_PersistentSubscriptions_GetInfoReq>

        let streamSelection: Selector<Stream.Identifier>
        let groupName: String

        package func build() throws -> Request.UnderlyingMessage {
            try .with {
                switch streamSelection {
                case let .specified(streamIdentifier):
                    $0.options.streamIdentifier = try streamIdentifier.build()
                case .all:
                    $0.options.all = .init()
                }
                $0.options.groupName = groupName
            }
        }
    }
}

extension PersistentSubscriptionsClient.GetInfo {
    public struct Response: GRPCResponse {
        public typealias UnderlyingMessage = EventStore_Client_PersistentSubscriptions_GetInfoResp

        public let subscriptionInfo: SubscriptionInfo

        public init(from message: UnderlyingMessage) throws {
            subscriptionInfo = .init(from: message.subscriptionInfo)
        }
    }
}
