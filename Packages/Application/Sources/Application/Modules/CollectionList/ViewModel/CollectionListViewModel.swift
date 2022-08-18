//
//  CollectionListViewModel.swift
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
protocol CollectionListViewModelLifecycle {
    func setup()
    func load()
    func reload()
}

/// Describes a list of states which can be passed to view.
protocol CollectionListViewModelState {
    var stateSnapshot: AnyPublisher<CollectionsListDataSourceSnapshot?, Never> { get }
    var stateLoading: AnyPublisher<Bool, Never> { get }
    var stateError: AnyPublisher<ErrorViewItem?, Never> { get }
}

/// Describes a list of handlers for external events (e.g. from view).
protocol CollectionListViewModelInputHandler {
    func handleItemSelection(_ item: CollectionListViewItem)
    func handleEndOfList()
}

/// Describes a list of events to coordinates to other modules.
protocol CollectionListViewModelCoordination {
    var showDetails: AnyPublisher<String, Never> { get }
}

/// Interface to use a view model just a dependecy (to keep the view model alive).
protocol CollectionListViewModelDependency: AnyObject {}

typealias CollectionListViewModel = (
    CollectionListViewModelLifecycle &
    CollectionListViewModelState &
    CollectionListViewModelInputHandler &
    CollectionListViewModelCoordination &
    CollectionListViewModelDependency
)
