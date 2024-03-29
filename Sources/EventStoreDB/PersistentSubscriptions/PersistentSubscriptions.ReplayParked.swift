//
//  PersistentSubscriptions.ReplayParked.swift
//
//
//  Created by Grady Zhuo on 2023/12/11.
//

import Foundation
import GRPCSupport

extension PersistentSubscriptionsClient {
    public struct ReplayParked: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_PersistentSubscriptions_ReplayParkedReq>
        public typealias Response = DiscardedResponse<EventStore_Client_PersistentSubscriptions_ReplayParkedResp>

        let streamSelection: Selector<Stream.Identifier>
        let groupName: String
        let options: Options

        public func build() throws -> EventStore_Client_PersistentSubscriptions_ReplayParkedReq {
            try .with {
                $0.options = options.build()
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

extension PersistentSubscriptionsClient.ReplayParked {
    public final class Options: EventStoreOptions {
        public enum StopAtOption {
            case position(position: Int64)
            case noLimit
        }

        public typealias UnderlyingMessage = Request.UnderlyingMessage.Options
        var message: UnderlyingMessage

        init() {
            message = .init()
            stop(at: .noLimit)
        }

        @discardableResult
        public func stop(at option: StopAtOption) -> Self {
            switch option {
            case let .position(position):
                message.stopAt = position
            case .noLimit:
                message.noLimit = .init()
            }
            return self
        }

        public func build() -> PersistentSubscriptionsClient.ReplayParked.Request.UnderlyingMessage.Options {
            message
        }
    }
}
