//
//  DefaultColours.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

public final class DefaultColours: Colours {

    public var primaryLabel: UIColor {
        .label
    }

    public var secondaryLabel: UIColor {
        .systemGray
    }

    public var gray: UIColor {
        .systemGray6
    }

    public var tint: UIColor {
        .init(
            red: 213.0 / 255.0,
            green: 81.0 / 255.0,
            blue: 64.0 / 255.0,
            alpha: 255.0 / 255.0
        )
    }
}
