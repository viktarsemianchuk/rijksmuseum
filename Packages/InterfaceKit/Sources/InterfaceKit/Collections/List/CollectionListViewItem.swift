//
//  CollectionListViewItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

// MARK: - Section

public extension CollectionListViewItem.Section {

    struct ArtSectionItem: Hashable {
        let title: String
        let subtitle: String

        public init(title: String, subtitle: String) {
            self.title = title
            self.subtitle = subtitle
        }
    }
}

public extension CollectionListViewItem {

    enum Section: Hashable {
        case arts(ArtSectionItem)
        case loading
    }
}

// MARK: - Item

public extension CollectionListViewItem.Art {

    struct Image: Hashable {
        let url: String
        let width: Double
        let height: Double

        public init(url: String, width: Double, height: Double) {
            self.url = url
            self.width = width
            self.height = height
        }
    }
}

public extension CollectionListViewItem {

    struct Art: Hashable {
        public let objectNumber: String
        public let title: String
        public let subtitle: String
        public let image: Image?

        public init(
            objectNumber: String,
            title: String,
            subtitle: String,
            image: Image?
        ) {
            self.objectNumber = objectNumber
            self.title = title
            self.subtitle = subtitle
            self.image = image
        }
    }
}

public enum CollectionListViewItem: Hashable {
    case art(Art)
    case loading
}
