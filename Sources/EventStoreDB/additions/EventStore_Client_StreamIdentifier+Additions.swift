//
//  EventStore_Client_StreamIdentifier+Additions.swift
//
//
//  Created by Ospark.org on 2023/10/24.
//

import Foundation
import GRPCSupport

@available(macOS 13.0, *)
extension EventStore_Client_StreamIdentifier {
    func toIdentifier() -> StreamClient.Identifier {
        let name = String(data: streamName, encoding: .utf8)
        return .init(name: name!)
    }
}
