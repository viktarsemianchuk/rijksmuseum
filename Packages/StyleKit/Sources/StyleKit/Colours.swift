//
//  Colours.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

/// A set of predefined common colours to use them in styling process.
public protocol Colours {
    var primaryLabel: UIColor { get }
    var secondaryLabel: UIColor { get }
    var gray: UIColor { get }
    var tint: UIColor { get }
}
