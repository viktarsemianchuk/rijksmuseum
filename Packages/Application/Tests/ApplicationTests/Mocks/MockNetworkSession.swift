//
//  MockNetworkSession.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import ServiceKit

final class MockNetworkSession: NetworkSession {

    var mockRequestResult: (() -> Result<Data, Error>)!

    func perform<Request: NetworkDataRequest>(
        _ request: Request
    ) -> AnyPublisher<Request.Response, Error> {
        switch mockRequestResult() {
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(
                    Request.Response.self,
                    from: data
                )
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
    }
}
