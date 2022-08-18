//
//  CollectionDetailsModelItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

extension CollectionDetailsModelItem.Art {

    struct Dimension: Codable, Equatable {
        let unit: String
        let type: String
        let value: String
    }
}

extension CollectionDetailsModelItem.Art {

    struct Label: Codable, Equatable {
        let description: String?
    }
}

extension CollectionDetailsModelItem.Art {

    struct Image: Codable, Equatable {
        let width: Double
        let height: Double
        let url: String
    }
}

extension CollectionDetailsModelItem {

    struct Art: Codable, Equatable {
        let id: String
        let objectNumber: String
        let title: String
        let subtitle: String?
        let image: Image
        let label: Label?
        let dimensions: [Dimension]?
        let author: String?

        enum CodingKeys: String, CodingKey {
            case id
            case objectNumber
            case title = "longTitle"
            case subtitle = "scLabelLine"
            case image = "webImage"
            case label
            case dimensions
            case author = "principalMaker"
        }
    }
}

struct CollectionDetailsModelItem: Codable, Equatable {
    let art: Art

    enum CodingKeys: String, CodingKey {
        case art = "artObject"
    }
}
