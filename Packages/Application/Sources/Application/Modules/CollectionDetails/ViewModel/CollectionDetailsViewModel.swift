//
//  CollectionDetailsViewModel.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import InterfaceKit

/// Describes a lifecycle of view model.
protocol CollectionDetailsViewModelLifecycle {
    func setup()
    func load()
    func reload()
}

/// Describes a list of states which can be passed to view.
protocol CollectionDetailsViewModelState {
    var stateSnapshot: AnyPublisher<CollectionDetailsDataSourceSnapshot?, Never> { get }
    var stateLoading: AnyPublisher<Bool, Never> { get }
    var stateError: AnyPublisher<ErrorViewItem?, Never> { get }
}

/// Interface to use a view model just a dependecy (to keep the view model alive).
protocol CollectionDetailsViewModelDependency: AnyObject {}

typealias CollectionDetailsViewModel = (
    CollectionDetailsViewModelLifecycle &
    CollectionDetailsViewModelState &
    CollectionDetailsViewModelDependency
)
