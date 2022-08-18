//
//  Coordinator.swift
//  rijksmuseum
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

/// Describes Coordinator API.
public protocol Coordinator: AnyObject {
    associatedtype Route
    /// Root or presentation controller for all routes in the scope of the coordinator.
    var rootViewController: UIViewController { get }
    /// Starts a route
    /// - Parameters:
    /// - route: an appripriate route navigate to.
    func start(route: Route)
}
