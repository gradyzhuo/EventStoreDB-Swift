// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: gossip.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
private struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
    struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
    typealias Version = _2
}

package struct EventStore_Client_Gossip_ClusterInfo: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var members: [EventStore_Client_Gossip_MemberInfo] = []

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package init() {}
}

package struct EventStore_Client_Gossip_EndPoint: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var address: String = .init()

    package var port: UInt32 = 0

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package init() {}
}

package struct EventStore_Client_Gossip_MemberInfo: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var instanceID: EventStore_Client_UUID {
        get { _instanceID ?? EventStore_Client_UUID() }
        set { _instanceID = newValue }
    }

    /// Returns true if `instanceID` has been explicitly set.
    package var hasInstanceID: Bool { _instanceID != nil }
    /// Clears the value of `instanceID`. Subsequent reads from it will return its default value.
    package mutating func clearInstanceID() { _instanceID = nil }

    package var timeStamp: Int64 = 0

    package var state: EventStore_Client_Gossip_MemberInfo.VNodeState = .initializing

    package var isAlive: Bool = false

    package var httpEndPoint: EventStore_Client_Gossip_EndPoint {
        get { _httpEndPoint ?? EventStore_Client_Gossip_EndPoint() }
        set { _httpEndPoint = newValue }
    }

    /// Returns true if `httpEndPoint` has been explicitly set.
    package var hasHTTPEndPoint: Bool { _httpEndPoint != nil }
    /// Clears the value of `httpEndPoint`. Subsequent reads from it will return its default value.
    package mutating func clearHTTPEndPoint() { _httpEndPoint = nil }

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package enum VNodeState: SwiftProtobuf.Enum, Swift.CaseIterable {
        package typealias RawValue = Int
        case initializing // = 0
        case discoverLeader // = 1
        case unknown // = 2
        case preReplica // = 3
        case catchingUp // = 4
        case clone // = 5
        case follower // = 6
        case preLeader // = 7
        case leader // = 8
        case manager // = 9
        case shuttingDown // = 10
        case shutdown // = 11
        case readOnlyLeaderless // = 12
        case preReadOnlyReplica // = 13
        case readOnlyReplica // = 14
        case resigningLeader // = 15
        case UNRECOGNIZED(Int)

        package init() {
            self = .initializing
        }

        package init?(rawValue: Int) {
            switch rawValue {
            case 0: self = .initializing
            case 1: self = .discoverLeader
            case 2: self = .unknown
            case 3: self = .preReplica
            case 4: self = .catchingUp
            case 5: self = .clone
            case 6: self = .follower
            case 7: self = .preLeader
            case 8: self = .leader
            case 9: self = .manager
            case 10: self = .shuttingDown
            case 11: self = .shutdown
            case 12: self = .readOnlyLeaderless
            case 13: self = .preReadOnlyReplica
            case 14: self = .readOnlyReplica
            case 15: self = .resigningLeader
            default: self = .UNRECOGNIZED(rawValue)
            }
        }

        package var rawValue: Int {
            switch self {
            case .initializing: 0
            case .discoverLeader: 1
            case .unknown: 2
            case .preReplica: 3
            case .catchingUp: 4
            case .clone: 5
            case .follower: 6
            case .preLeader: 7
            case .leader: 8
            case .manager: 9
            case .shuttingDown: 10
            case .shutdown: 11
            case .readOnlyLeaderless: 12
            case .preReadOnlyReplica: 13
            case .readOnlyReplica: 14
            case .resigningLeader: 15
            case let .UNRECOGNIZED(i): i
            }
        }

        // The compiler won't synthesize support with the UNRECOGNIZED case.
        package static let allCases: [EventStore_Client_Gossip_MemberInfo.VNodeState] = [
            .initializing,
            .discoverLeader,
            .unknown,
            .preReplica,
            .catchingUp,
            .clone,
            .follower,
            .preLeader,
            .leader,
            .manager,
            .shuttingDown,
            .shutdown,
            .readOnlyLeaderless,
            .preReadOnlyReplica,
            .readOnlyReplica,
            .resigningLeader,
        ]
    }

    package init() {}

    fileprivate var _instanceID: EventStore_Client_UUID? = nil
    fileprivate var _httpEndPoint: EventStore_Client_Gossip_EndPoint? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

private let _protobuf_package = "event_store.client.gossip"

extension EventStore_Client_Gossip_ClusterInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".ClusterInfo"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "members"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeRepeatedMessageField(value: &members)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if !members.isEmpty {
            try visitor.visitRepeatedMessageField(value: members, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Gossip_ClusterInfo, rhs: EventStore_Client_Gossip_ClusterInfo) -> Bool {
        if lhs.members != rhs.members { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Gossip_EndPoint: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".EndPoint"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "address"),
        2: .same(proto: "port"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &address)
            case 2: try decoder.decodeSingularUInt32Field(value: &port)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if !address.isEmpty {
            try visitor.visitSingularStringField(value: address, fieldNumber: 1)
        }
        if port != 0 {
            try visitor.visitSingularUInt32Field(value: port, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Gossip_EndPoint, rhs: EventStore_Client_Gossip_EndPoint) -> Bool {
        if lhs.address != rhs.address { return false }
        if lhs.port != rhs.port { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Gossip_MemberInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".MemberInfo"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .standard(proto: "instance_id"),
        2: .standard(proto: "time_stamp"),
        3: .same(proto: "state"),
        4: .standard(proto: "is_alive"),
        5: .standard(proto: "http_end_point"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_instanceID)
            case 2: try decoder.decodeSingularInt64Field(value: &timeStamp)
            case 3: try decoder.decodeSingularEnumField(value: &state)
            case 4: try decoder.decodeSingularBoolField(value: &isAlive)
            case 5: try decoder.decodeSingularMessageField(value: &_httpEndPoint)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if let v = _instanceID {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        }
        if timeStamp != 0 {
            try visitor.visitSingularInt64Field(value: timeStamp, fieldNumber: 2)
        }
        if state != .initializing {
            try visitor.visitSingularEnumField(value: state, fieldNumber: 3)
        }
        if isAlive != false {
            try visitor.visitSingularBoolField(value: isAlive, fieldNumber: 4)
        }
        try { if let v = self._httpEndPoint {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
        } }()
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Gossip_MemberInfo, rhs: EventStore_Client_Gossip_MemberInfo) -> Bool {
        if lhs._instanceID != rhs._instanceID { return false }
        if lhs.timeStamp != rhs.timeStamp { return false }
        if lhs.state != rhs.state { return false }
        if lhs.isAlive != rhs.isAlive { return false }
        if lhs._httpEndPoint != rhs._httpEndPoint { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Gossip_MemberInfo.VNodeState: SwiftProtobuf._ProtoNameProviding {
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        0: .same(proto: "Initializing"),
        1: .same(proto: "DiscoverLeader"),
        2: .same(proto: "Unknown"),
        3: .same(proto: "PreReplica"),
        4: .same(proto: "CatchingUp"),
        5: .same(proto: "Clone"),
        6: .same(proto: "Follower"),
        7: .same(proto: "PreLeader"),
        8: .same(proto: "Leader"),
        9: .same(proto: "Manager"),
        10: .same(proto: "ShuttingDown"),
        11: .same(proto: "Shutdown"),
        12: .same(proto: "ReadOnlyLeaderless"),
        13: .same(proto: "PreReadOnlyReplica"),
        14: .same(proto: "ReadOnlyReplica"),
        15: .same(proto: "ResigningLeader"),
    ]
}
