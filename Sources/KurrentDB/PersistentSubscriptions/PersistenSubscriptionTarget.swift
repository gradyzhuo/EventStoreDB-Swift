//
//  PersistenSubscriptionTarget.swift
//  KurrentDB
//
//  Created by Grady Zhuo on 2025/3/6.
//
import Foundation

/// Represents a stream target that can be sent (`StreamTarget`).
///
/// `StreamTarget` is a protocol that allows concrete types (such as `SpecifiedStream` and `AllStreams`)
/// to be used as stream targets.
///
/// ## Usage
///
/// You can use `specified(_:)` to create a specific stream or use `all` to get a predefined instance
/// representing all available streams:
///
/// ```swift
/// let specificStream = StreamTarget.specified("log.txt") // Specify by name
/// let specificStreamByIdentifier = StreamTarget.specified(StreamIdentifier(name: "log.txt", encoding: .utf8)) // Specify by identifier
///
/// let allStreams = StreamTarget.all // Represents all streams
/// ```
///
/// ### Extensions
/// - `SpecifiedStream`: Represents a specific stream and provides static methods for instantiation.
/// - `AllStreams`: Represents a placeholder for all streams.
/// - `AnyStreamTarget`: A generic stream target used when the type is not specified.
public protocol PersistenSubscriptionTarget: Sendable {}


extension PersistentSubscription {
    /// Represents a generic stream target that conforms to `StreamTarget`.
    ///
    /// `AnyStreamTarget` is used in generic contexts where a specific stream type is not required.
    public struct AnyTarget: PersistenSubscriptionTarget{}
    
    
    //MARK: - Specified Stream

    /// Represents a specific stream that conforms to `StreamTarget`.
    ///
    /// `SpecifiedStream` is identified by a `StreamIdentifier` and can be instantiated using `StreamTarget.specified`.
    public struct Specified: PersistenSubscriptionTarget {
        
        /// The identifier for the stream, represented as a `StreamIdentifier`.
        public private(set) var identifier: StreamIdentifier
        
        /// The group for the PersistenSubscription.
        public private(set) var group: String
        
        /// Initializes a `Specified`PersistenSubscriptionTarget  instance.
        ///
        /// - Parameter identifier: The identifier for the stream.
        /// - Parameter group: The group for the PersistenSubscription.
        public init(identifier: StreamIdentifier, group: String) {
            self.identifier = identifier
            self.group = group
        }
    }
    
    //MARK: - All Streams

    /// Represents a placeholder for all streams that conform to `StreamTarget`.
    ///
    /// `AllStreams` is a type that represents all available stream targets
    /// and can be accessed using `StreamTarget.all`.
    public struct All: PersistenSubscriptionTarget {
        /// The group for the PersistenSubscription.
        public private(set) var group: String
        
        /// Initializes a `All` PersistenSubscriptionTarget  instance.
        ///
        /// - Parameter group: The group for the PersistenSubscription.
        public init(group: String) {
            self.group = group
        }
    }
}





extension PersistenSubscriptionTarget where Self == PersistentSubscription.Specified {
    
    /// Creates a `SpecifiedStream` using a `StreamIdentifier`.
    ///
    /// - Parameter identifier: The identifier for the stream.
    /// - Returns: A `SpecifiedStream` instance.
    public static func specified(_ identifier: StreamIdentifier, group: String)->PersistentSubscription.Specified{
        return .init(identifier: identifier, group: group)
    }

    /// Creates a `SpecifiedStream` identified by a name and encoding.
    ///
    /// - Parameters:
    ///   - name: The name of the stream.
    ///   - encoding: The encoding format of the stream, defaulting to `.utf8`.
    /// - Returns: A `SpecifiedStream` instance.
    public static func specified(_ name: String, encoding: String.Encoding = .utf8, group: String)->PersistentSubscription.Specified{
        return .init(identifier: .init(name: name, encoding: encoding), group: group)
    }
}




extension PersistenSubscriptionTarget where Self == PersistentSubscription.All {
    
    /// Creates a `SpecifiedStream` identified by a name and encoding.
    ///
    /// - Parameters:
    ///   - name: The name of the stream.
    ///   - encoding: The encoding format of the stream, defaulting to `.utf8`.
    /// - Returns: A `SpecifiedStream` instance.
    public static func all(group: String)-> PersistentSubscription.All{
        return .init(group: group)
    }
}
