//
//  CollectionListViewModelImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import InterfaceKit
import LocalizationKit

// MARK: - Definition

final class CollectionListViewModelImpl {

    private let model: CollectionListModel

    private var cancellables = Set<AnyCancellable>()

    private let stateSnapshotSubject =
    CurrentValueSubject<CollectionsListDataSourceSnapshot?, Never>(nil)
    private let stateLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let stateErrorSubject = CurrentValueSubject<ErrorViewItem?, Never>(nil)
    private let showDetailsSubject = PassthroughSubject<String, Never>()

    init(model: CollectionListModel) {
        self.model = model
    }
}

// MARK: - CollectionListViewModelDependency implementation

extension CollectionListViewModelImpl: CollectionListViewModelDependency {}

// MARK: - CollectionListViewModelState implementation

extension CollectionListViewModelImpl: CollectionListViewModelState {

    var stateSnapshot: AnyPublisher<CollectionsListDataSourceSnapshot?, Never> {
        stateSnapshotSubject.eraseToAnyPublisher()
    }

    var stateLoading: AnyPublisher<Bool, Never> {
        stateLoadingSubject.eraseToAnyPublisher()
    }

    var stateError: AnyPublisher<ErrorViewItem?, Never> {
        stateErrorSubject.eraseToAnyPublisher()
    }
}

// MARK: - CollectionListViewModelCoordination implementation

extension CollectionListViewModelImpl: CollectionListViewModelCoordination {

    var showDetails: AnyPublisher<String, Never> {
        showDetailsSubject.eraseToAnyPublisher()
    }
}

// MARK: - CollectionListViewModelLifecycle implementation

extension CollectionListViewModelImpl: CollectionListViewModelLifecycle {

    func setup() {
        model.didLoad
            .sink { [weak self] result in
                guard let self = self else { return }
                self.stateLoadingSubject.send(false)
                switch result {
                case .failure(let error):
                    guard self.stateSnapshotSubject.value.flatMap({
                        $0.numberOfItems == 0
                    }) ?? true else { return }
                    self.stateErrorSubject.send(
                        .init(
                            title: L10n.sorry,
                            subtitle: error.errorDescription,
                            buttonTitle: L10n.tryAgain
                        )
                    )
                case .success(let result):
                    self.stateErrorSubject.send(nil)
                    self.stateSnapshotSubject.send(
                        self.convert(loadResult: result)
                    )
                }
            }
            .store(in: &cancellables)
    }

    func load() {
        stateErrorSubject.send(nil)
        stateLoadingSubject.send(true)
        model.load()
    }

    func reload() {
        model.reset()
        load()
    }
}

// MARK: - CollectionListViewModelInputHandler implementation

extension CollectionListViewModelImpl: CollectionListViewModelInputHandler {

    func handleItemSelection(_ item: CollectionListViewItem) {
        switch item {
        case .art(let artItem):
            showDetailsSubject.send(artItem.objectNumber)
        default:
            break
        }
    }

    func handleEndOfList() {
        model.load()
    }
}

// MARK: - Helpers

private extension CollectionListViewModelImpl {

    func convert(
        loadResult: CollectionListLoadSuccessResult
    ) -> CollectionsListDataSourceSnapshot {

        let arts: [CollectionListViewItem] = loadResult.artObjects.map {
            .art(.init(
                objectNumber: $0.objectNumber,
                title: $0.title,
                subtitle: $0.author,
                image: .init(
                    url: $0.image.url,
                    width: $0.image.width,
                    height: $0.image.height
                )
            ))
        }

        var snapshot = CollectionsListDataSourceSnapshot()

        if !arts.isEmpty {
            /// Add arts items.
            let artsSection = CollectionListViewItem.Section.arts(
                .init(
                    title: L10n.artObjects,
                    subtitle: L10n.itemsCount(loadResult.count)
                )
            )
            snapshot.appendSections([artsSection])
            snapshot.appendItems(arts, toSection: artsSection)

            /// Add loading items.
            snapshot.appendSections([.loading])
            snapshot.appendItems([.loading], toSection: .loading)
        }

        return snapshot
    }
}
