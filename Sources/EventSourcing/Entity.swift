//
//  File.swift
//  
//
//  Created by 卓俊諺 on 2024/3/31.
//

import Foundation
import EventStoreDB

public protocol Entity: Identifiable {
    init(id: ID)
}

public protocol Aggregate: Entity {
    associatedtype EventType: Event
    
    static var category: String { get }
    
    var events: [EventType] { get }
    var revision: UInt64? { set get }
    
    mutating func add(event: EventType) throws
}


extension Aggregate {
    public static func getStreamName(id: ID) -> String{
        return "\(Self.category)-\(id)"
    }
    
    public var streamName: String {
        return Self.getStreamName(id: id)
    }
}
