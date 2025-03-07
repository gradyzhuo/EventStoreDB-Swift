//
//  ClientSettings.swift
//  KurrentCore
//
//  Created by Grady Zhuo on 2023/10/17.
//

import Foundation
import GRPCCore
import GRPCNIOTransportHTTP2
import Logging
import NIOCore
import NIOPosix
import NIOSSL
import RegexBuilder
import GRPCEncapsulates

public let DEFAULT_PORT_NUMBER: UInt32 = 2113
public let DEFAULT_GOSSIP_TIMEOUT: TimeInterval = 3.0

/// `ClientSettings` encapsulates various configuration settings for a client.
///
/// - Properties:
///   - `configuration`: TLS configuration.
///   - `clusterMode`: The cluster topology mode.
///   - `tls`: Indicates if TLS is enabled (default is false).
///   - `tlsVerifyCert`: Indicates if TLS certificate verification is enabled (default is false).
///   - `defaultDeadline`: Default deadline for operations (default is `.max`).
///   - `connectionName`: Optional connection name.
///   - `keepAlive`: Keep-alive settings.
///   - `defaultUserCredentials`: Optional user credentials.
///
/// - Initializers:
///   - `init(clusterMode:configuration:numberOfThreads)`: Initializes with specified cluster mode, TLS configuration, and number of threads.
///   - `init(clusterMode:numberOfThreads:configure)`: Initializes with specified cluster mode, number of threads, and TLS configuration using a configuration closure.
///
/// - Methods:
///   - `makeCallOptions()`: Creates call options for making requests, optionally including user credentials.
///
/// - Static Methods:
///   - `localhost(port:numberOfThreads:userCredentials:trustRoots)`: Returns settings configured for localhost with optional port, number of threads, user credentials, and trust roots.
///   - `parse(connectionString)`: Parses a connection string into `ClientSettings`.
///
/// - Nested Types:
///   - `TopologyClusterMode`: Defines the cluster topology modes.
///   - `Endpoint`: Represents a network endpoint with a host and port.
///
/// - Conformance:
///   - `ExpressibleByStringLiteral`: Allows initialization from a string literal.
///
/// - Example:
///   - single node mode, initiating gRPC communication on the specified port on localhost and using 2 threads.
///
///   ```swift
///   let clientSettingsSingleNode = ClientSettings(
///       clusterMode: .singleNode(at: .init(host: "localhost", port: 50051)),
///       configuration: .clientDefault,
///       numberOfThreads: 2
///   )
///   ```
///   - Gossip cluster mode, specifying multiple nodes' hosts and ports, as well as node preference and timeout, using 3 threads.
///   ```swift
///   let clientSettingsGossipCluster = ClientSettings(
///       clusterMode: .gossipCluster(
///           endpoints: [.init(host: "node1.example.com", port: 50051), .init(host: "node2.example.com", port: 50052)],
///           nodePreference: .leader,
///           timeout: 5.0
///       ),
///       configuration: .clientDefault,
///       numberOfThreads: 3
///   )
///   ```

public struct ClientSettings: Sendable {
    public var configuration: TLSConfiguration
    public private(set) var clusterMode: TopologyClusterMode

    public var trustRoots: TLSConfig.TrustRootsSource?

    public private(set) var tls: Bool = false
    public private(set) var tlsVerifyCert: Bool = false

    public private(set) var defaultDeadline: Int = .max
    public private(set) var connectionName: String?

    public var keepAlive: KeepAlive = .default
    public var defaultUserCredentials: UserCredentials?

    public init(clusterMode: TopologyClusterMode, configuration: TLSConfiguration) {
        self.clusterMode = clusterMode
        self.configuration = configuration
    }

    public init(clusterMode: TopologyClusterMode, configure: () -> TLSConfiguration = { .clientDefault }) {
        self.init(clusterMode: clusterMode, configuration: configure())
    }
}

extension ClientSettings {
    public static func localhost(port: UInt32 = DEFAULT_PORT_NUMBER, userCredentials: UserCredentials? = nil, trustRoots: NIOSSLTrustRoots? = nil) -> Self {
        var settings: Self = .init(clusterMode: .singleNode(at: .init(host: "localhost", port: port)))

        if let trustRoots {
            settings.configuration.trustRoots = trustRoots
            settings.tls = true
        } else {
            settings.tls = false
        }

        settings.defaultUserCredentials = userCredentials
        return settings
    }

    public static func parse(connectionString: String) throws -> Self {
        let schemeParser = URLSchemeParser()
        let endpointParser = EndpointParser()
        let queryItemParser = QueryItemParser()
        let userCredentialParser = UserCredentialsParser()

        guard let scheme = try schemeParser.parse(connectionString) else {
            throw ClientSettingsError.parseError(message: "Unknown URL scheme: \(connectionString)")
        }

        guard let endpoints = try endpointParser.parse(connectionString),
              endpoints.count > 0
        else {
            throw ClientSettingsError.parseError(message: "Connection string doesn't have an host")
        }

        let parsedResult = try queryItemParser.parse(connectionString) ?? []

        let queryItems: [String: URLQueryItem] = .init(uniqueKeysWithValues: parsedResult.map {
            ($0.name.lowercased(), $0)
        })

        let clusterMode: TopologyClusterMode
        if endpoints.count > 1 {
            // gossip mode
            let nodePreference = queryItems["nodepreference"]?.value.flatMap {
                TopologyClusterMode.NodePreference(rawValue: $0)
            } ?? .leader
            let gossipTimeout: TimeInterval = queryItems["gossiptimeout"].flatMap { $0.value.flatMap { TimeInterval($0) } } ?? DEFAULT_GOSSIP_TIMEOUT
            clusterMode = .gossipCluster(endpoints: endpoints, nodePreference: nodePreference, timeout: gossipTimeout)
        } else {
            let endpoint = endpoints.first!
            if scheme == .dnsDiscover {
                // dns discovery mode
                let maxDiscoverAttempts = queryItems["maxdiscoverattempts"].flatMap { $0.value.flatMap { Int($0) } } ?? 3
                let discoverInterval = queryItems["discoveryinterval"].flatMap { $0.value.flatMap { TimeInterval($0) } } ?? 0.5
                clusterMode = .dnsDiscovery(from: endpoint, interval: discoverInterval, maxAttempts: maxDiscoverAttempts)
            } else {
                // singleMode
                clusterMode = .singleNode(at: endpoint)
            }
        }

        var settings = Self(clusterMode: clusterMode)
        settings.defaultUserCredentials = try userCredentialParser.parse(connectionString)

        if let keepAliveInterval: TimeInterval = (queryItems["keepaliveinterval"].flatMap { $0.value.flatMap { .init($0) } }),
           let keepAliveTimeout: TimeInterval = (queryItems["keepalivetimeout"].flatMap { $0.value.flatMap { .init($0) } })
        {
            settings.keepAlive = .init(interval: keepAliveInterval, timeout: keepAliveTimeout)
        }

        if let connectionName = queryItems["connectionanme"]?.value {
            settings.connectionName = connectionName
        }

        if let tlsItem = queryItems["tls"], tlsItem.value == "false" {
            settings.tls = false
        } else {
            settings.tls = true
        }
        if let tls: Bool = (queryItems["tls"].flatMap { $0.value.flatMap { .init($0) } }) {
            settings.tls = tls
        }

        if let tlsVerifyCert: Bool = (queryItems["tlsverifycert"].flatMap { $0.value.flatMap { .init($0) } }) {
            settings.tlsVerifyCert = tlsVerifyCert
        }

        if let defaultDeadline: Int = (queryItems["defaultdeadline"].flatMap { $0.value.flatMap { .init($0) }}) {
            settings.defaultDeadline = defaultDeadline
        }

        return settings
    }
}

extension ClientSettings: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String

    public init(stringLiteral value: String) {
        do {
            self = try Self.parse(connectionString: value)
        } catch let ClientSettingsError.parseError(message) {
            logger.error(.init(stringLiteral: message))
            fatalError(message)

        } catch {
            logger.error(.init(stringLiteral: "\(error)"))
            fatalError(error.localizedDescription)
        }
    }
}


extension ClientSettings: Buildable{
    
    
    @discardableResult
    public func configuration(_ configuration: TLSConfiguration)->Self{
        return withCopy {
            $0.configuration = configuration
        }
    }
    
    
    @discardableResult
    public func clusterMode(_ clusterMode: TopologyClusterMode)->Self{
        return withCopy {
            $0.clusterMode = clusterMode
        }
    }

    @discardableResult
    public func trustRoots(_ trustRoots: TLSConfig.TrustRootsSource)->Self{
        return withCopy {
            $0.trustRoots = trustRoots
        }
    }
    
    @discardableResult
    public func tls(_ tls: Bool)->Self{
        return withCopy {
            $0.tls = tls
        }
    }
    
    @discardableResult
    public func tlsVerifyCert(_ tlsVerifyCert: Bool)->Self{
        return withCopy {
            $0.tlsVerifyCert = tlsVerifyCert
        }
    }
    
    @discardableResult
    public func defaultDeadline(_ defaultDeadline: Int)->Self{
        return withCopy {
            $0.defaultDeadline = defaultDeadline
        }
    }
    
    @discardableResult
    public func connectionName(_ connectionName: String)->Self{
        return withCopy {
            $0.connectionName = connectionName
        }
    }
    
    @discardableResult
    public func keepAlive(_ keepAlive: KeepAlive)->Self{
        return withCopy {
            $0.keepAlive = keepAlive
        }
    }
    
    @discardableResult
    public func defaultUserCredentials(_ defaultUserCredentials: UserCredentials)->Self{
        return withCopy {
            $0.defaultUserCredentials = defaultUserCredentials
        }
    }
    
    
}
