//
//  NetworkSession.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import Foundation

/// A set of errors which can be thrown by network session.
public enum NetworkSessionError: Error {
    /// Passed requests is invalid and it can't be used for networking (e.g. invalid URL).
    case invalidRequestError
    /// Transport error occured (e.g. there's no Internet connection, can't connect to the server).
    case transportError(Error)
    /// Invalid response received (e.g there's non-HTTP result)
    case invalidResponse
    /// Something went wrong on server side (e.g. unauthorized, not found, etc.).
    case serverError(statusCode: Int, message: String?)
    /// Received data doesn't match on expected data models
    case decodingError(Error)
}

/// Describes API which should be implemented by any Network session to proccess passed request
/// and return async result.
/// - Parameters:
///   - request: An instance which contains all necessary information to pass to backend.
/// - Returns: Publisher which returns either response or error.
public protocol NetworkSession {
    func perform<Request: NetworkDataRequest>(
        _ request: Request
    ) -> AnyPublisher<Request.Response, Error>
}
