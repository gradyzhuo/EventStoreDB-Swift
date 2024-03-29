//
//  GRPCTesting.swift
//
//
//  Created by Grady Zhuo on 2023/12/9.
//

import EventStoreDB
import Foundation
import GRPC
import GRPCSupport
import NIOSSL

@main
enum GRPCTesting {
    public static func main() async throws {
//        var settings: ClientSettings = "esdb://admin:changeit@localhost:2111,localhost:2112,localhost:2113?keepAliveTimeout=10000&keepAliveInterval=10000"
//
//        settings.configuration.trustRoots = .file("/Users/gradyzhuo/Library/CloudStorage/Dropbox/Work/jw/mendesky/EventStore/samples/server/certs/ca/ca.crt")

        try EventStoreDB.using(settings: .localhost(userCredentials: .init(username: "admin", password: "changeit"), trustRoots: .file("/Users/gradyzhuo/Library/CloudStorage/Dropbox/Work/jw/mendesky/EventStore/samples/server/certs/ca/ca.crt")))

        let client2 = try await ProjectionsClient.create(name: "my_projection3", query: "fromAll().outputState()") { options in
            options.emit(enabled: false).trackEmittedStreams(false)
        }

        print(client2)

        try await client2.update(query: """
        fromStream("account").outputState()
        """) {
            $0.emit(option: .noEmit)
        }

//        var configuration = TLSConfiguration.clientDefault
//        configuration.certificateChain = [
//            .certificate(try .init(file: "/Users/gradyzhuo/Library/CloudStorage/Dropbox/Work/jw/mendesky/EventStore/samples/server/certs/ca/ca.pem", format: .pem))
//        ]
//        configuration.trustRoots = .file("/Users/gradyzhuo/Library/CloudStorage/Dropbox/Work/jw/mendesky/EventStore/samples/server/certs/ca/ca.crt")
//        configuration.certificateVerification = .noHostnameVerification

//        if EventStoreDB.shared.settings.tls {
//            EventStoreDB.shared.settings.transportSecurity = .tls(.makeClientConfigurationBackedByNIOSSL(configuration: configuration))
//        }
//

        let client1 = try UserClient()
//        let user = try await  client1.create(loginName: "gradyzhuo", password: "1234", fullName: "Grady Zhuo")
//
        for await user in try client1.details(loginName: "gradyzhuo") {
            print("user:", user)
        }

        let members = try await GossipClient.read()
        
        let client = try PersistentSubscriptionsClient(selection: .specified(streamIdentifier: "testing"), groupName: "subscription-group")

        try await print("info:", client.getInfo())
        print("======================")

        let results = try await PersistentSubscriptionsClient.list { options in
            options.listAllScriptions()
        }
        print("list:", results)
        print("======================")

        let m = try MonitoringClient()
        let x = try await m.stats(useMetadata: true, refreshTimePeriodInMs: 60000)
        Task {
            for try await y in x {
                print("monitor:", y)
            }
        }

        let responses = try await client.read(options: .init())

        for try await result in responses {
            print("ooooooooooooooooooooooooo")
            print("response:", result.event)
        }

//            do{
        ////                try await response.ack()
//                try await client.ack(eventIds: [response.event.event.id], subscriptionId: response.subscriptionId)
//            }catch{
//                print("error:", error)
//            }

//        for await response in responses {
//            print("response:", response.event)
//
//            do{
        ////                try await response.ack()
//                try await client.ack(subscriptionId: response.subscriptionId, readEventIds: [response.event.event.id])
//            }catch{
//                print("error:", error)
//            }
//
//        }
//        let channel = try GRPCChannelPool.with(settings: .localhost())
//
//        let client = EventStore_Client_PersistentSubscriptions_PersistentSubscriptionsAsyncClient(channel: channel)
//
//        let request = EventStore_Client_PersistentSubscriptions_ReadReq.with{
//            $0.options = .with{
//                $0.streamIdentifier = .with{
//                    $0.streamName = "testing".data(using: .utf8)!
//                }
//                $0.groupName = "subscription-group"
//                $0.bufferSize = 500
//                $0.uuidOption = .with{
//                    $0.string = .init()
//                }
//            }
//        }
//        let responses = client.read([request])
//        for try await response in responses{
//            print("response:", response)
//
//            let ackRequest = EventStore_Client_PersistentSubscriptions_ReadReq.with{
//                $0.ack = .with{
//                    $0.ids = [ .with{
//                        $0.string = response.event.event.id.string
//                    }]
//                }
//            }
//            let r = client.read([ackRequest])
//            print("r:", r)
//        }
    }
}
