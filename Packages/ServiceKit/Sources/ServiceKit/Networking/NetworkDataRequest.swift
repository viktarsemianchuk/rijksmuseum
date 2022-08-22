//
//  NetworkDataRequest.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

/// Describes an API which should be confirmed by any request which will be passed to NetworkSession.
public protocol NetworkDataRequest {
    associatedtype Response: Decodable

    var url: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }

    var urlRequest: URLRequest? { get }
}

public extension NetworkDataRequest {

    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: url)
        else { return nil }

        urlComponents.queryItems = queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let url = urlComponents.url
        else { return nil}

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .returnCacheDataElseLoad

        return urlRequest
    }
}
