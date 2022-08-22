//
//  DefaultStyle.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

let defaultStyle = DefaultStyle()

public final class DefaultStyle: Style {
    public let colours: Colours = DefaultColours()
    public let fonts: Fonts = DefaultFonts()
    public let labels: Labels = DefaultLabels(
        colours: DefaultColours(),
        fonts: DefaultFonts()
    )
    public let icons: Icons = DefaultIcons()
}
