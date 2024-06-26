//
//  ProjectionsClient.RestartSubsystem.swift
//
//
//  Created by Grady Zhuo on 2023/12/7.
//

import Foundation
import GRPCEncapsulates

extension ProjectionsClient {
    public struct RestartSubsystem: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_Empty>
        public typealias Response = DiscardedResponse<EventStore_Client_Empty>

        package func build() throws -> Request.UnderlyingMessage {
            .init()
        }
    }
}
