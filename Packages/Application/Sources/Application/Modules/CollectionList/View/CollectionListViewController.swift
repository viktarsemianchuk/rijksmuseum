//
//  CollectionListViewController.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// Sytem
import Combine
import UIKit

// SDK
import InterfaceKit
import LocalizationKit

final class CollectionListViewController: UIViewController {

    let contentView = CollectionListViewImpl()
    var cancellables = Set<AnyCancellable>()
    var viewModel: CollectionListViewModelDependency?

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Set title.
        title = L10n.collections
    }
}
