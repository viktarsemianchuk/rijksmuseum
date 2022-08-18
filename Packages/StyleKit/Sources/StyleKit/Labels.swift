//
//  Labels.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

/// An interface which describes style of label.
public protocol LabelStyle {
    var font: UIFont { get }
    var color: UIColor { get }
}

/// A set of predefined styles to use them in labels styling process.
public protocol Labels {
    var primaryBoldTitle1: LabelStyle { get }
    var primaryBoldTitle3: LabelStyle { get }
    var primaryBody: LabelStyle { get }
    var primaryBoldBody: LabelStyle { get }
    var secondaryBody: LabelStyle { get }
    var primaryBoldSubhead: LabelStyle { get }
    var secondaryBoldSubhead: LabelStyle { get }
    var primarySubhead: LabelStyle { get }
    var secondarySubhead: LabelStyle { get }
}
