//
//  NetworkRequestFactory.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

extension NetworkRequestFactory {

    /// A list of language segments to use them for requests.
    enum RequestLanguage: String {
        case english = "/en"
        case dutch = "/nl"

        public init(languageCode: String) {
            switch languageCode {
            case "nl":
                self = .dutch
            default:
                self = .english
            }
        }
    }
}

extension NetworkRequestFactory {

    /// A list of endpoints
    enum RequestAPI: String {
        case collection = "/collection"
    }
}

private extension NetworkRequestFactory {

    /// A predefined list of keys for query items
    enum ConstantQueryKey {
        static var apiKey: String { "key" }
    }
}

/// A factory to easily create network request for Network Session
final class NetworkRequestFactory {

    private let baseUrl: String
    private let language: RequestLanguage
    private let apiKey: String

    /// Creates an instance of the Network Request Factory.
    /// - Parameters:
    ///   - baseUrl: A url to API host which is a base for all requests.
    ///   - language: An appropriate language which will be used for all requests.
    ///   - apiKey: An APIKey to use end service.
    init(baseUrl: String, language: RequestLanguage, apiKey: String) {
        self.baseUrl = baseUrl
        self.language = language
        self.apiKey = apiKey
    }
}

private extension NetworkRequestFactory {

    func prepareUrl(api: RequestAPI) -> String {
        baseUrl + language.rawValue + api.rawValue
    }
}
