//
//  Operations.StopScavenge.swift
//
//
//  Created by Grady Zhuo on 2023/12/12.
//

import Foundation
import GRPCSupport

extension OperationsClient {
    public struct StopScavenge: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_Operations_StopScavengeReq>
        public typealias Response = OperationsClient.ScavengeResponse

        let scavengeId: String

        public func build() throws -> Request.UnderlyingMessage {
            .with {
                $0.options = .with {
                    $0.scavengeID = scavengeId
                }
            }
        }
    }
}
