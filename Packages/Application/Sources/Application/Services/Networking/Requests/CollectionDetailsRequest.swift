//
//  CollectionDetailsRequest.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import ServiceKit

struct CollectionDetailsRequest: NetworkDataRequest {

    typealias Response = CollectionDetailsModelItem

    let url: String
    let method: HTTPMethod
    let queryItems: [String: String]
}
