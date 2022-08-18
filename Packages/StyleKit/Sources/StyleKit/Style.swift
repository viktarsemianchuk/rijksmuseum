//
//  Style.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

/// A set of predefined common style staff to use them in view styling process.
public protocol Style {
    var colours: Colours { get }
    var fonts: Fonts { get }
    var labels: Labels { get }
    var icons: Icons { get }
}
