//
//  CollectionDetailsBuilder.swift
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

final class CollectionDetailsBuilder {

    private let objectNumber: String
    private let networkSession: NetworkSession
    private let networkRequestFactory: NetworkRequestFactory

    init(
        objectNumber: String,
        networkSession: NetworkSession,
        networkRequestFactory: NetworkRequestFactory
    ) {
        self.objectNumber = objectNumber
        self.networkSession = networkSession
        self.networkRequestFactory = networkRequestFactory
    }
}

extension CollectionDetailsBuilder: Builder {

    func build() -> UIViewController {
        buildModule()
    }
}

private extension CollectionDetailsBuilder {

    func buildModule() -> UIViewController {
        let viewModel = buildViewModel()
        let viewController = buildView(viewModel: viewModel)
        viewController.viewModel = viewModel
        return viewController
    }

    func buildViewModel() -> CollectionDetailsViewModel {
        let viewModel = CollectionDetailsViewModelImpl(
            model: CollectionDetailsModelImpl(
                networkSession: networkSession,
                networkRequestFactory: networkRequestFactory
            ),
            configuration: .init(objectNumber: objectNumber)
        )
        viewModel.setup()
        viewModel.load()
        return viewModel
    }

    func buildView(
        viewModel: CollectionDetailsViewModel
    ) -> CollectionDetailsViewController {
        let viewController = CollectionDetailsViewController()

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
        viewModel.stateError
            .receive(on: DispatchQueue.main)
            .sink { [weak viewController] errorItem in
                viewController?.contentView.outputError = errorItem
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
