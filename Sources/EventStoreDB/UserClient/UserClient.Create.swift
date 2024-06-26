//
//  UserClient.Create.swift
//
//
//  Created by Grady Zhuo on 2023/12/20.
//

import Foundation
import GRPCEncapsulates

extension UserClient {
    public struct Create: UnaryUnary {
        public typealias Request = GenericGRPCRequest<EventStore_Client_Users_CreateReq>

        public typealias Response = DiscardedResponse<EventStore_Client_Users_CreateResp>

        let loginName: String
        let password: String
        let fullName: String

        let groups: [String]

        package func build() throws -> GRPCEncapsulates.EventStore_Client_Users_CreateReq {
            .with {
                $0.options.loginName = loginName
                $0.options.password = password
                $0.options.fullName = fullName
                $0.options.groups = groups
            }
        }

        public init(loginName: String, password: String, fullName: String, groups: [String] = []) {
            self.loginName = loginName
            self.password = password
            self.fullName = fullName
            self.groups = groups
        }
    }
}
