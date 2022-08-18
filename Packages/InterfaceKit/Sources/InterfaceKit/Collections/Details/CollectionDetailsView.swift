//
//  CollectionDetailsViewItem.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import UIKit

public typealias CollectionDetailsDataSourceSnapshot =
NSDiffableDataSourceSnapshot<CollectionDetailsViewItem.Section, CollectionDetailsViewItem>

/// Describes states which can be received from view model and displayed on the screen.
public protocol CollectionDetailsViewOutput {
    var outputSnapshot: CollectionDetailsDataSourceSnapshot? { get set }
    var outputLoading: Bool { get set }
    var outputError: ErrorViewItem? { get set }
}

/// Describes a list of actios which can be occured on view and should be passed to application (e.g. viewModel).
public protocol CollectionDetailsViewInput {
    var inputReloadInitiated: AnyPublisher<Void, Never> { get }
}

public typealias CollectionDetailsView = (
    CollectionDetailsViewOutput &
    CollectionDetailsViewInput
)
