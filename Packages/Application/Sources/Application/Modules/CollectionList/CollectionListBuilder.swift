//
//  CollectionListBuilder.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import UIKit

// SDK
import InterfaceKit
import ServiceKit

final class CollectionListBuilder {

    private let networkSession: NetworkSession
    private let networkRequestFactory: NetworkRequestFactory
    private weak var coordinator: CoordinatorImpl?

    init(
        networkSession: NetworkSession,
        networkRequestFactory: NetworkRequestFactory,
        coordinator: CoordinatorImpl
    ) {
        self.networkSession = networkSession
        self.networkRequestFactory = networkRequestFactory
        self.coordinator = coordinator
    }
}

extension CollectionListBuilder: Builder {

    func build() -> UIViewController {
        buildModule()
    }
}

private extension CollectionListBuilder {

    func buildModule() -> UIViewController {
        let viewModel = buildViewModel()
        let viewController = buildView(viewModel: viewModel)
        viewController.viewModel = viewModel
        return viewController
    }

    func buildViewModel() -> CollectionListViewModel {
        let viewModel = CollectionListViewModelImpl(
            model: CollectionListModelImpl(
                networkSession: networkSession,
                networkRequestFactory: networkRequestFactory
            )
        )
        viewModel.setup()
        viewModel.load()
        return viewModel
    }

    func buildView(
        viewModel: CollectionListViewModel
    ) -> CollectionListViewController {
        let viewController = CollectionListViewController()

        viewModel.stateSnapshot
            .receive(on: DispatchQueue.main)
            .sink { [weak viewController] snapshot in
                viewController?.contentView.outputSnapshot = snapshot
            }
            .store(in: &viewController.cancellables)
        viewModel.stateLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak viewController] loading in
                viewController?.contentView.outputLoading = loading
            }
            .store(in: &viewController.cancellables)
        viewModel.showDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak coordinator] objectNumber in
                coordinator?.start(route: .collectionDetails(
                    objectNumber: objectNumber)
                )
            }
            .store(in: &viewController.cancellables)
        viewModel.stateError
            .receive(on: DispatchQueue.main)
            .sink { [weak viewController] errorItem in
                viewController?.contentView.outputError = errorItem
            }
            .store(in: &viewController.cancellables)

        viewController.contentView.inputItemSelected
            .sink { [weak viewModel] item in
                viewModel?.handleItemSelection(item)
            }
            .store(in: &viewController.cancellables)
        viewController.contentView.inputEndOfListReached
            .sink { [weak viewModel] _ in
                viewModel?.handleEndOfList()
            }
            .store(in: &viewController.cancellables)
        viewController.contentView.inputReloadInitiated
            .sink { [weak viewModel] _ in
                viewModel?.reload()
            }
            .store(in: &viewController.cancellables)

        return viewController
    }
}
