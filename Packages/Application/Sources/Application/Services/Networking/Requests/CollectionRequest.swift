//
//  CollectionRequest.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import ServiceKit

struct CollectionRequest: NetworkDataRequest {

    typealias Response = CollectionListLoadSuccessResult

    let url: String
    let method: HTTPMethod
    let queryItems: [String: String]
}

extension CollectionRequest {

    /// Builder to easily constrcut collection request with a dynamic list query items.
    struct Builder {
        let url: String
        let method: HTTPMethod
        var queryItems: [String: String]
    }
}

extension CollectionRequest.Builder {

    /// Adds a page number to a result list of query items.
    /// - Parameters:
    ///   - pageNumber: number of page.
    /// - Returns: An instance of builder with updated list of query items.
    @discardableResult
    func withPageNumber(_ pageNumber: Int) -> Self {
        with(value: "\(pageNumber)", for: .page)
    }

    /// Adds an items count  to a result list of query items.
    /// - Parameters:
    ///   - count: count of items per page.
    /// - Returns: An instance of builder with updated list of query items.
    @discardableResult
    func withItemsCount(_ count: Int) -> Self {
        with(value: "\(count)", for: .numberOfItems)
    }

    /// Adds an item  to a result list of query items which specifies either returned items should contain.
    /// image or not.
    /// - Parameters:
    ///   - withImage: should or shouldn't returned items countain image.
    /// - Returns: An instance of builder with updated list of query items.
    @discardableResult
    func withImageOnly(_ withImage: Bool) -> Self {
        with(value: "\(withImage)", for: .withImageOnly)
    }

    /// Builds a result request with a finilized list of query items.
    /// - Returns: Builded request.
    @discardableResult
    func build() -> CollectionRequest {
        .init(url: url, method: method, queryItems: queryItems)
    }
}

private extension CollectionRequest.Builder {

    func with(value: String, for key: QueryItem) -> Self {
        var builder = self
        builder.queryItems[key.rawValue] = value
        return builder
    }
}

private extension CollectionRequest.Builder {

    /// A list of predefenied keys for request query items.
    enum QueryItem: String {
        case page = "p"
        case numberOfItems = "ps"
        case withImageOnly = "imgonly"
    }
}
