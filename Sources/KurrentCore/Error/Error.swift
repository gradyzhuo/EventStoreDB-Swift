//
//  Error.swift
//
//
//  Created by Grady Zhuo on 2023/10/17.
//

import Foundation
import GRPCCore
import GRPCEncapsulates

public enum ClientSettingsError: Error {
    case parseError(message: String)
    case optionNotFound(message: String, queryItem: URLQueryItem)
    case encodingError(message: String, encoding: String.Encoding)
}

public enum ClientError: Error {
    case eventDataError(message: String)
    case streamNameError(message: String)
    case streamNotFound(message: String)
    case readResponseError(message: String)
    case projectionNameError(message: String)
}

public enum StreamClientError: Error {
    case streamNotFound(message: String)
}

public enum ReadEventError: Error {
    case GRPCDecodeException(message: String)
}

public enum PersistentSubscriptionsError: Error {
    case ackError(reason: String)
    case nackError(reason: String)
    case readError(reason: String)
}

package enum TestingError: Error {
    case exception(String)
}
