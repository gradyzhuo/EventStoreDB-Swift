// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: operations.proto
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

package struct EventStore_Client_Operations_StartScavengeReq: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var options: EventStore_Client_Operations_StartScavengeReq.Options {
        get { _options ?? EventStore_Client_Operations_StartScavengeReq.Options() }
        set { _options = newValue }
    }

    /// Returns true if `options` has been explicitly set.
    package var hasOptions: Bool { _options != nil }
    /// Clears the value of `options`. Subsequent reads from it will return its default value.
    package mutating func clearOptions() { _options = nil }

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package struct Options: Sendable {
        // SwiftProtobuf.Message conformance is added in an extension below. See the
        // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
        // methods supported on all messages.

        package var threadCount: Int32 = 0

        package var startFromChunk: Int32 = 0

        package var unknownFields = SwiftProtobuf.UnknownStorage()

        package init() {}
    }

    package init() {}

    fileprivate var _options: EventStore_Client_Operations_StartScavengeReq.Options? = nil
}

package struct EventStore_Client_Operations_StopScavengeReq: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var options: EventStore_Client_Operations_StopScavengeReq.Options {
        get { _options ?? EventStore_Client_Operations_StopScavengeReq.Options() }
        set { _options = newValue }
    }

    /// Returns true if `options` has been explicitly set.
    package var hasOptions: Bool { _options != nil }
    /// Clears the value of `options`. Subsequent reads from it will return its default value.
    package mutating func clearOptions() { _options = nil }

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package struct Options: Sendable {
        // SwiftProtobuf.Message conformance is added in an extension below. See the
        // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
        // methods supported on all messages.

        package var scavengeID: String = .init()

        package var unknownFields = SwiftProtobuf.UnknownStorage()

        package init() {}
    }

    package init() {}

    fileprivate var _options: EventStore_Client_Operations_StopScavengeReq.Options? = nil
}

package struct EventStore_Client_Operations_ScavengeResp: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var scavengeID: String = .init()

    package var scavengeResult: EventStore_Client_Operations_ScavengeResp.ScavengeResult = .started

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package enum ScavengeResult: SwiftProtobuf.Enum, Swift.CaseIterable {
        package typealias RawValue = Int
        case started // = 0
        case inProgress // = 1
        case stopped // = 2
        case UNRECOGNIZED(Int)

        package init() {
            self = .started
        }

        package init?(rawValue: Int) {
            switch rawValue {
            case 0: self = .started
            case 1: self = .inProgress
            case 2: self = .stopped
            default: self = .UNRECOGNIZED(rawValue)
            }
        }

        package var rawValue: Int {
            switch self {
            case .started: 0
            case .inProgress: 1
            case .stopped: 2
            case let .UNRECOGNIZED(i): i
            }
        }

        // The compiler won't synthesize support with the UNRECOGNIZED case.
        package static let allCases: [EventStore_Client_Operations_ScavengeResp.ScavengeResult] = [
            .started,
            .inProgress,
            .stopped,
        ]
    }

    package init() {}
}

package struct EventStore_Client_Operations_SetNodePriorityReq: Sendable {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    package var priority: Int32 = 0

    package var unknownFields = SwiftProtobuf.UnknownStorage()

    package init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

private let _protobuf_package = "event_store.client.operations"

extension EventStore_Client_Operations_StartScavengeReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".StartScavengeReq"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "options"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_options)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if let v = _options {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_StartScavengeReq, rhs: EventStore_Client_Operations_StartScavengeReq) -> Bool {
        if lhs._options != rhs._options { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Operations_StartScavengeReq.Options: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = EventStore_Client_Operations_StartScavengeReq.protoMessageName + ".Options"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .standard(proto: "thread_count"),
        2: .standard(proto: "start_from_chunk"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularInt32Field(value: &threadCount)
            case 2: try decoder.decodeSingularInt32Field(value: &startFromChunk)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if threadCount != 0 {
            try visitor.visitSingularInt32Field(value: threadCount, fieldNumber: 1)
        }
        if startFromChunk != 0 {
            try visitor.visitSingularInt32Field(value: startFromChunk, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_StartScavengeReq.Options, rhs: EventStore_Client_Operations_StartScavengeReq.Options) -> Bool {
        if lhs.threadCount != rhs.threadCount { return false }
        if lhs.startFromChunk != rhs.startFromChunk { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Operations_StopScavengeReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".StopScavengeReq"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "options"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularMessageField(value: &_options)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if let v = _options {
            try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_StopScavengeReq, rhs: EventStore_Client_Operations_StopScavengeReq) -> Bool {
        if lhs._options != rhs._options { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Operations_StopScavengeReq.Options: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = EventStore_Client_Operations_StopScavengeReq.protoMessageName + ".Options"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .standard(proto: "scavenge_id"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &scavengeID)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if !scavengeID.isEmpty {
            try visitor.visitSingularStringField(value: scavengeID, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_StopScavengeReq.Options, rhs: EventStore_Client_Operations_StopScavengeReq.Options) -> Bool {
        if lhs.scavengeID != rhs.scavengeID { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Operations_ScavengeResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".ScavengeResp"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .standard(proto: "scavenge_id"),
        2: .standard(proto: "scavenge_result"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &scavengeID)
            case 2: try decoder.decodeSingularEnumField(value: &scavengeResult)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if !scavengeID.isEmpty {
            try visitor.visitSingularStringField(value: scavengeID, fieldNumber: 1)
        }
        if scavengeResult != .started {
            try visitor.visitSingularEnumField(value: scavengeResult, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_ScavengeResp, rhs: EventStore_Client_Operations_ScavengeResp) -> Bool {
        if lhs.scavengeID != rhs.scavengeID { return false }
        if lhs.scavengeResult != rhs.scavengeResult { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}

extension EventStore_Client_Operations_ScavengeResp.ScavengeResult: SwiftProtobuf._ProtoNameProviding {
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        0: .same(proto: "Started"),
        1: .same(proto: "InProgress"),
        2: .same(proto: "Stopped"),
    ]
}

extension EventStore_Client_Operations_SetNodePriorityReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    package static let protoMessageName: String = _protobuf_package + ".SetNodePriorityReq"
    package static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "priority"),
    ]

    package mutating func decodeMessage(decoder: inout some SwiftProtobuf.Decoder) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try decoder.decodeSingularInt32Field(value: &priority)
            default: break
            }
        }
    }

    package func traverse(visitor: inout some SwiftProtobuf.Visitor) throws {
        if priority != 0 {
            try visitor.visitSingularInt32Field(value: priority, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }

    package static func == (lhs: EventStore_Client_Operations_SetNodePriorityReq, rhs: EventStore_Client_Operations_SetNodePriorityReq) -> Bool {
        if lhs.priority != rhs.priority { return false }
        if lhs.unknownFields != rhs.unknownFields { return false }
        return true
    }
}
