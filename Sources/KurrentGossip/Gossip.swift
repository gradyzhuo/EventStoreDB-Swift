//
//  GossipClient.swift
//
//
//  Created by Grady Zhuo on 2023/10/17.
//
@_exported
import KurrentCore

import Foundation
import NIO
import Logging
import GRPCCore
import GRPCEncapsulates
import GRPCNIOTransportHTTP2Posix


public struct Gossip: GRPCConcreteService {
    package typealias Client = EventStore_Client_Gossip_Gossip.Client<HTTP2ClientTransport.Posix>
    
    public private(set) var settings: ClientSettings
    public var callOptions: CallOptions
    public let eventLoopGroup: EventLoopGroup
    
    public init(settings: ClientSettings, callOptions: CallOptions = .defaults, eventLoopGroup: EventLoopGroup = .singletonMultiThreadedEventLoopGroup){
        self.settings = settings
        self.callOptions = callOptions
        self.eventLoopGroup = eventLoopGroup
    }
}


extension Gossip {
    public func read() async throws -> Read.Response {
        let usecase = Read()
        return try await usecase.perform(settings: settings, callOptions: callOptions)
    }
}
