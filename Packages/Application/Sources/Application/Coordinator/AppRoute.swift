//
//  AppRoute.swift
//  rijksmuseum
//
//  Created by Viktar Semianchuk on 18.08.22.
//

/// A predefined list of app routes.
public enum AppRoute {
    /// List of collections.
    case collections
    /// Collection details.
    /// - Parameters:
    ///   - objectNumber: number of an appropriate collection.
    case collectionDetails(objectNumber: String)
}
