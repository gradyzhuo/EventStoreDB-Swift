//
//  ResetPassword.swift
//  KurrentDB
//
//  Created by 卓俊諺 on 2025/1/16.
//

import Foundation
import GRPCCore
import GRPCEncapsulates

extension Users {
    public struct ResetPassword: UnaryUnary {
        package typealias ServiceClient = Client
        package typealias UnderlyingRequest = ServiceClient.UnderlyingService.Method.ResetPassword.Input
        package typealias UnderlyingResponse = ServiceClient.UnderlyingService.Method.ResetPassword.Output
        package typealias Response = DiscardedResponse<UnderlyingResponse>

        public let loginName: String
        private let newPassword: String
        
        public init(loginName: String, newPassword: String) {
            self.loginName = loginName
            self.newPassword = newPassword
        }
        
        package func requestMessage() throws -> UnderlyingRequest {
            return .with {
                $0.options.loginName = loginName
                $0.options.newPassword = newPassword
            }
        }
        
        package func send(client: ServiceClient, request: ClientRequest<UnderlyingRequest>, callOptions: CallOptions) async throws -> Response {
            return try await client.resetPassword(request: request, options: callOptions){
                try handle(response: $0)
            }
        }
    }
}
