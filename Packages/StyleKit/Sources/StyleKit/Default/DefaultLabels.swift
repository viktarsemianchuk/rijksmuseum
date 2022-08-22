//
//  DefaultLabels.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

private extension DefaultLabels {

    struct PrimaryBoldTitle1: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.boldTitle1
            color = colours.primaryLabel
        }
    }

    struct PrimaryBoldTitle3: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.boldTitle3
            color = colours.primaryLabel
        }
    }

    struct PrimaryBody: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.bodyRegular
            color = colours.primaryLabel
        }
    }

    struct PrimaryBoldBody: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.bodyBold
            color = colours.primaryLabel
        }
    }

    struct SecondaryBody: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.bodyRegular
            color = colours.secondaryLabel
        }
    }

    struct PrimaryBoldSubhead: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.subheadBold
            color = colours.primaryLabel
        }
    }

    struct SecondaryBoldSubhead: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.subheadBold
            color = colours.secondaryLabel
        }
    }

    struct PrimarySubhead: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.subheadRegular
            color = colours.primaryLabel
        }
    }

    struct SecondarySubhead: LabelStyle {
        let font: UIFont
        let color: UIColor

        init(colours: Colours, fonts: Fonts) {
            font = fonts.subheadRegular
            color = colours.secondaryLabel
        }
    }
}

public final class DefaultLabels: Labels {

    private let colours: Colours
    private let fonts: Fonts

    init(colours: Colours, fonts: Fonts) {
        self.colours = colours
        self.fonts = fonts
    }

    public var primaryBoldTitle1: LabelStyle {
        PrimaryBoldTitle1(colours: colours, fonts: fonts)
    }

    public var primaryBoldTitle3: LabelStyle {
        PrimaryBoldTitle3(colours: colours, fonts: fonts)
    }

    public var primaryBody: LabelStyle {
        PrimaryBody(colours: colours, fonts: fonts)
    }

    public var primaryBoldBody: LabelStyle {
        PrimaryBoldBody(colours: colours, fonts: fonts)
    }

    public var secondaryBody: LabelStyle {
        SecondaryBody(colours: colours, fonts: fonts)
    }

    public var primaryBoldSubhead: LabelStyle {
        PrimaryBoldSubhead(colours: colours, fonts: fonts)
    }

    public var secondaryBoldSubhead: LabelStyle {
        SecondaryBoldSubhead(colours: colours, fonts: fonts)
    }

    public var primarySubhead: LabelStyle {
        PrimarySubhead(colours: colours, fonts: fonts)
    }

    public var secondarySubhead: LabelStyle {
        SecondarySubhead(colours: colours, fonts: fonts)
    }
}
