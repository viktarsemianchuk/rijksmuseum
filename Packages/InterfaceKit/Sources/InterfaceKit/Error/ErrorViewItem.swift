//
//  ErrorViewItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

public struct ErrorViewItem {
    let title: String
    let subtitle: String
    let buttonTitle: String

    public init(title: String, subtitle: String, buttonTitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}
