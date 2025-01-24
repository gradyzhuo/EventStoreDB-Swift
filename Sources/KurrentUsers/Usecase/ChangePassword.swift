//
//  ChangePassword.swift
//  KurrentDB
//
//  Created by 卓俊諺 on 2025/1/16.
//

import Foundation
import GRPCCore
import GRPCEncapsulates

extension Users {
    public struct ChangePassword: UnaryUnary {
        public typealias ServiceClient = Client
        public typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.ChangePassword.Input
        public typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.ChangePassword.Output
        public typealias Response = DiscardedResponse<UnderlyingResponse>

        public let loginName: String
        private let currentPassword: String
        private let newPassword: String
        
        public init(loginName: String, currentPassword: String, newPassword: String) {
            self.loginName = loginName
            self.currentPassword = currentPassword
            self.newPassword = newPassword
        }
        
        package func requestMessage() throws -> UnderlyingRequest {
            return .with {
                $0.options.loginName = loginName
                $0.options.currentPassword = currentPassword
                $0.options.newPassword = newPassword
            }
        }
        
        public func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Response {
            return try await client.changePassword(request: request, options: callOptions){
                try handle(response: $0)
            }
        }
    }
}

