//
//  URLSession+NetworkSession.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import Foundation

extension URLSession: NetworkSession {

    public func perform<Request: NetworkDataRequest>(
        _ request: Request
    ) -> AnyPublisher<Request.Response, Error> {

        guard let urlRequest = request.urlRequest else {
            return Fail(error: NetworkSessionError.invalidRequestError)
                .eraseToAnyPublisher()
        }

        return dataTaskPublisher(for: urlRequest)
            .mapError { error in
                NetworkSessionError.transportError(error)
            }
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkSessionError.invalidResponse
                }
                guard (200..<300).contains(response.statusCode) else {
                    throw NetworkSessionError.serverError(
                        statusCode: response.statusCode,
                        message: HTTPURLResponse.localizedString(
                            forStatusCode: response.statusCode
                        )
                    )
                }
                return output.data
            }
            .tryMap { data in
                do {
                    return try JSONDecoder().decode(
                        Request.Response.self,
                        from: data
                    )
                } catch {
                    throw NetworkSessionError.decodingError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
