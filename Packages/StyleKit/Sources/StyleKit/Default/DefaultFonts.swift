//
//  DefaultFonts.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

public final class DefaultFonts: Fonts {

    public var boldTitle1: UIFont {
        let font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        return UIFontMetrics(forTextStyle: .title1).scaledFont(for: font)
    }

    public var boldTitle3: UIFont {
        let font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        return UIFontMetrics(forTextStyle: .title3).scaledFont(for: font)
    }

    public var bodyRegular: UIFont {
        let font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }

    public var bodyBold: UIFont {
        let font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }

    public var subheadRegular: UIFont {
        let font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        return UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: font)
    }

    public var subheadBold: UIFont {
        let font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: font)
    }
}
