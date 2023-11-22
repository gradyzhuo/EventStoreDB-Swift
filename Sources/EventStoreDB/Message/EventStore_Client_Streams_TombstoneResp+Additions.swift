//
//  File.swift
//  
//
//  Created by Ospark.org on 2023/11/2.
//

import Foundation

@available(macOS 10.15, *)
extension EventStore_Client_Streams_TombstoneResp.OneOf_PositionOption {
    
    internal typealias Represented = Stream.Position.Option
    
    internal func represented() -> Represented {
        switch self {
        case .position(let position):
            return .position(.init(commit: position.commitPosition, prepare: position.preparePosition))
        case .noPosition(_):
            return .noPosition
        }
    }
    
}
