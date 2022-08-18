//
//  CoordinatorImpl.swift
//  rijksmuseum
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit

private extension CoordinatorImpl {

    // MARK: - Constants

    enum Constants {
        static var baseUrl: String { "https://www.rijksmuseum.nl/api" }
        static var apiKey: String { "0fiuZFh4" }
    }
}

// MARK: - Definition

final public class CoordinatorImpl: Coordinator {

    public var rootViewController: UIViewController {
        navigationController
    }
    private let navigationController: UINavigationController

    private let networkSession = URLSession.shared
    private let networkRequestFactory = NetworkRequestFactory(
        baseUrl: Constants.baseUrl,
        language: .init(languageCode: Locale.preferredLanguageCode),
        apiKey: Constants.apiKey
    )

    public init(navigationController: UINavigationController) {
        navigationController.navigationBar.tintColor =
        navigationController.style.colours.tint
        self.navigationController = navigationController
    }

    public func start(route: AppRoute) {
        switch route {
        case .collections:
            let builder = CollectionListBuilder(
                networkSession: networkSession,
                networkRequestFactory: networkRequestFactory,
                coordinator: self
            )
            let viewController = builder.build()
            navigationController.pushViewController(
                viewController,
                animated: true
            )
        case .collectionDetails(let objectNumber):
            let builder = CollectionDetailsBuilder(
                objectNumber: objectNumber,
                networkSession: networkSession,
                networkRequestFactory: networkRequestFactory
            )
            let viewController = builder.build()
            navigationController.pushViewController(
                viewController, animated: true
            )
        }
    }
}
