//
//  SceneDelegate.swift
//  rijksmuseum
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import Application

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: CoordinatorImpl?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene)
        else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = UINavigationController()

        let coordinator = CoordinatorImpl(
            navigationController: navigationController
        )
        coordinator.start(route: .collections)
        self.coordinator = coordinator

        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }
}

