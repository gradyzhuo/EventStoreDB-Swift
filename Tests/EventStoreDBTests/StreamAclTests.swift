//
//  StreamAclTests.swift
//
//
//  Created by Grady Zhuo on 2024/5/3.
//

@testable import EventStoreDB
import XCTest

final class StreamAclTests: XCTestCase {
    func testSystemStreamAclEncodeAndDecode() throws {
        let acl = Stream.Metadata.Acl.systemStream
        let encoder = JSONEncoder()
        XCTAssertEqual(try acl.rawValue, try encoder.encode("$systemStreamAcl"))

        let decoder = JSONDecoder()
        let deserializedAcl = try decoder.decode(Stream.Metadata.Acl, from: acl.rawValue)
        XCTAssertEqual(deserializedAcl, acl)
    }

    func testUserStreamAclEncodeAndDecode() throws {
        let acl = Stream.Metadata.Acl.userStream
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(acl)

        XCTAssertEqual(jsonData, try encoder.encode("$userStreamAcl"))

        let decoder = JSONDecoder()
        let deserializedAcl = try decoder.decode(Stream.Metadata.Acl, from: jsonData)
        XCTAssertEqual(deserializedAcl, acl)
    }
}
