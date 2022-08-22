//
//  CollectionListView.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import UIKit

public typealias CollectionsListDataSourceSnapshot =
NSDiffableDataSourceSnapshot<CollectionListViewItem.Section, CollectionListViewItem>

/// Describes states which can be received from view model and displayed on the screen.
public protocol CollectionListViewOutput {
    var outputSnapshot: CollectionsListDataSourceSnapshot? { get set }
    var outputLoading: Bool { get set }
    var outputError: ErrorViewItem? { get set }
}

/// Describes a list of actios which can be occured on view and should be passed to application (e.g. viewModel).
public protocol CollectionListViewInput {
    var inputItemSelected: AnyPublisher<CollectionListViewItem, Never> { get }
    var inputEndOfListReached: AnyPublisher<Void, Never> { get }
    var inputReloadInitiated: AnyPublisher<Void, Never> { get }
}

public typealias CollectionListView = (
    CollectionListViewOutput &
    CollectionListViewInput
)
