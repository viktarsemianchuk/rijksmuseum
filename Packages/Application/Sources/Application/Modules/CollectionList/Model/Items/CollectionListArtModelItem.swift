//
//  CollectionListArtModelItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

extension CollectionListArtModelItem {

    struct Image: Codable, Equatable {
        let width: Double
        let height: Double
        let url: String
    }
}

struct CollectionListArtModelItem: Codable, Equatable {
    let id: String
    let objectNumber: String
    let title: String
    let author: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id
        case objectNumber
        case title
        case author = "principalOrFirstMaker"
        case image = "webImage"
    }
}

struct CollectionListLoadSuccessResult: Codable, Equatable {
    let artObjects: [CollectionListArtModelItem]
    let count: Int
}
