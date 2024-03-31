//
//  File.swift
//  
//
//  Created by 卓俊諺 on 2024/3/31.
//

import Foundation

public protocol Repository{
    associatedtype AggregateRoot: Entity
    
    func find(id: UUID) async throws -> AggregateRoot?
    func save(entity: AggregateRoot) async throws
    func delete(id: UUID) async throws
}

extension Repository {
    
    func delete(entity: AggregateRoot) async throws {
        try await delete(id: entity.id)
    }
}
