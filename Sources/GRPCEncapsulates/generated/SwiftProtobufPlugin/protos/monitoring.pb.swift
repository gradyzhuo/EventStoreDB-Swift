// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/monitoring.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
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

public struct EventStore_Client_Monitoring_StatsReq {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var useMetadata: Bool = false

    public var refreshTimePeriodInMs: UInt64 = 0

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
}

public struct EventStore_Client_Monitoring_StatsResp {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var stats: [String: String] = [:]

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
    extension EventStore_Client_Monitoring_StatsReq: @unchecked Sendable {}
    extension EventStore_Client_Monitoring_StatsResp: @unchecked Sendable {}
#endif // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

private let _protobuf_package = "event_store.client.monitoring"

extension EventStore_Client_Monitoring_StatsReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    public static let protoMessageName: String = _protobuf_package + ".StatsReq"
    public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .standard(proto: "use_metadata"),
        4: .standard(proto: "refresh_time_period_in_ms"),
    ]

    public mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularBoolField(value: &useMetadata)
            case 4: try decoder.decodeSingularUInt64Field(value: &refreshTimePeriodInMs)
            default: break
            }
        }
    }

    public func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if useMetadata != false {
            try visitor.visitSingularBoolField(value: useMetadata, fieldNumber: 1)
        }
        if refreshTimePeriodInMs != 0 {
            try visitor.visitSingularUInt64Field(value: refreshTimePeriodInMs, fieldNumber: 4)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    public static func == (lhs: EventStore_Client_Monitoring_StatsReq, rhs: EventStore_Client_Monitoring_StatsReq) -> Bool {
        if lhs.useMetadata != rhs.useMetadata { return false }
        if lhs.refreshTimePeriodInMs != rhs.refreshTimePeriodInMs { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Monitoring_StatsResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    public static let protoMessageName: String = _protobuf_package + ".StatsResp"
    public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "stats"),
    ]

    public mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString, SwiftProtobuf.ProtobufString>.self, value: &stats)
            default: break
            }
        }
    }

    public func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if !stats.isEmpty {
            try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufString, SwiftProtobuf.ProtobufString>.self, value: stats, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    public static func == (lhs: EventStore_Client_Monitoring_StatsResp, rhs: EventStore_Client_Monitoring_StatsResp) -> Bool {
        if lhs.stats != rhs.stats { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}
