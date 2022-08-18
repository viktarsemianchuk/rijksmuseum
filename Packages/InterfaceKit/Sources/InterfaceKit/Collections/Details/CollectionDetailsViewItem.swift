//
//  CollectionDetailsViewItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

// MARK: - Section

public extension CollectionDetailsViewItem.Section {

    struct SectionItem: Hashable {
        let uuid = UUID()
        let title: String

        public init(title: String) {
            self.title = title
        }
    }
}

public extension CollectionDetailsViewItem {

    enum Section: Hashable {
        case image
        case general
        case author(SectionItem)
        case description(SectionItem)
        case dimensions(SectionItem)
    }
}

// MARK: - Item

public extension CollectionDetailsViewItem {

    struct ImageItem: Hashable {
        let uuid = UUID()
        let imageUrl: String
        let width: Double
        let height: Double

        public init(imageUrl: String, width: Double, height: Double) {
            self.imageUrl = imageUrl
            self.width = width
            self.height = height
        }
    }

    struct GeneralItem: Hashable {
        let uuid = UUID()
        let title: String
        let subtitle: String?

        public init(title: String, subtitle: String?) {
            self.title = title
            self.subtitle = subtitle
        }
    }

    struct TextItem: Hashable {
        let uuid = UUID()
        let text: String

        public init(text: String) {
            self.text = text
        }
    }

    struct SpecItem: Hashable {
        let uuid = UUID()
        let key: String
        let value: String

        public init(key: String, value: String) {
            self.key = key
            self.value = value
        }
    }
}

public enum CollectionDetailsViewItem: Hashable {
    case image(ImageItem)
    case general(GeneralItem)
    case text(TextItem)
    case spec(SpecItem)
}
