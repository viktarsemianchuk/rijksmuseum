//
//  UILabel+Style.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

public extension UILabel {

    func apply(style: LabelStyle) {
        textColor = style.color
        font = style.font
    }
}
