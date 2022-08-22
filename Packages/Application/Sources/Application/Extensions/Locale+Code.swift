//
//  Locale+Code.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Foundation

extension Locale {

    static var preferredLanguageCode: String {
        guard let preferredLanguage = preferredLanguages.first,
              let code = Locale(identifier: preferredLanguage).languageCode
        else { return "en" }
        return code
    }
}
