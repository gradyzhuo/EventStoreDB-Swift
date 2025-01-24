//
//  UnderlyGRPCClient.swift
//
//
//  Created by Grady Zhuo on 2023/12/19.
//

import Foundation
import GRPCCore
import GRPCNIOTransportHTTP2

public protocol GRPCServiceClient {
    associatedtype UnderlyingService
    associatedtype Transport: ClientTransport
    init(wrapping: GRPCClient<Transport>)
}

extension EventStore_Client_Streams_Streams.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Streams_Streams
}

extension EventStore_Client_Users_Users.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Users_Users
}

extension EventStore_Client_Projections_Projections.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Projections_Projections
}

extension EventStore_Client_PersistentSubscriptions_PersistentSubscriptions.Client: GRPCServiceClient{
    public typealias UnderlyingService = EventStore_Client_PersistentSubscriptions_PersistentSubscriptions
}

extension EventStore_Client_Operations_Operations.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Operations_Operations
}

extension EventStore_Client_Monitoring_Monitoring.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Monitoring_Monitoring
}

extension EventStore_Client_Gossip_Gossip.Client: GRPCServiceClient {
    public typealias UnderlyingService = EventStore_Client_Gossip_Gossip
}
