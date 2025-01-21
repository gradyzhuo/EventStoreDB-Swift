//
//  GRPCConcreteClient.swift
//
//
//  Created by Grady Zhuo on 2023/12/7.
//

import Foundation
import GRPC
import SwiftProtobuf

package protocol GRPCConcreteClient: Sendable {
    associatedtype UnderlyingClient: UnderlyGRPCClient

    var channel: GRPCChannel { get }
    var callOptions: CallOptions { set get }
}

extension GRPCConcreteClient {
    package var underlyingClient: UnderlyingClient {
        .init(channel: channel, defaultCallOptions: callOptions)
    }
}
