//
//  EventStore_Client_Streams_DeleteResp+Additions.swift
//
//
//  Created by Grady Zhuo on 2023/10/31.
//

import Foundation
import GRPCSupport

extension EventStore_Client_Streams_DeleteResp.OneOf_PositionOption {
    typealias Represented = Stream.Position.Option

    func represented() -> Represented {
        switch self {
        case let .position(position):
            .position(.init(commit: position.commitPosition, prepare: position.preparePosition))
        case .noPosition:
            .noPosition
        }
    }
}
