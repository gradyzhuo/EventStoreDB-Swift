//
//  Operations.StartScavenge.swift
//
//
//  Created by Grady Zhuo on 2023/12/12.
//

import Foundation
import GRPCSupport

extension OperationsClient {
    public struct StartScavenge: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_Operations_StartScavengeReq>
        public typealias Response = OperationsClient.ScavengeResponse

        let threadCount: Int32
        let startFromChunk: Int32

        public func build() throws -> Request.UnderlyingMessage {
            .with {
                $0.options = .with {
                    $0.threadCount = threadCount
                    $0.startFromChunk = startFromChunk
                }
            }
        }
    }
}
