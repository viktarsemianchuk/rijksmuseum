//
//  CollectionDetailsViewModelImpl.swift
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

extension CollectionDetailsViewModelImpl {

    // MARK: - Configuration

    struct Configuration {
        let objectNumber: String
    }
}

// MARK: - Definition

final class CollectionDetailsViewModelImpl {

    private let stateSnapshotSubject =
    CurrentValueSubject<CollectionDetailsDataSourceSnapshot?, Never>(nil)
    private let stateLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let stateErrorSubject = CurrentValueSubject<ErrorViewItem?, Never>(nil)

    private var cancellables = Set<AnyCancellable>()

    private let model: CollectionDetailsModel
    private let configuration: Configuration

    init(model: CollectionDetailsModel, configuration: Configuration) {
        self.model = model
        self.configuration = configuration
    }
}

// MARK: - CollectionDetailsViewModelDependency implementation

extension CollectionDetailsViewModelImpl: CollectionDetailsViewModelDependency {}

// MARK: - CollectionDetailsViewModelState implementation

extension CollectionDetailsViewModelImpl: CollectionDetailsViewModelState {

    var stateSnapshot: AnyPublisher<CollectionDetailsDataSourceSnapshot?, Never> {
        stateSnapshotSubject.eraseToAnyPublisher()
    }

    var stateLoading: AnyPublisher<Bool, Never> {
        stateLoadingSubject.eraseToAnyPublisher()
    }

    var stateError: AnyPublisher<ErrorViewItem?, Never> {
        stateErrorSubject.eraseToAnyPublisher()
    }
}

// MARK: - CollectionDetailsViewModelLifecycle implementation

extension CollectionDetailsViewModelImpl: CollectionDetailsViewModelLifecycle {

    func setup() {
        model.didLoad
            .sink { [weak self] result in
                guard let self = self else { return }
                self.stateLoadingSubject.send(false)
                switch result {
                case .failure(let error):
                    self.stateErrorSubject.send(
                        .init(
                            title: L10n.sorry,
                            subtitle: error.errorDescription,
                            buttonTitle: L10n.tryAgain
                        )
                    )
                case .success(let item):
                    self.stateErrorSubject.send(nil)
                    self.stateSnapshotSubject.send(self.convert(modelItem: item))
                }
            }
            .store(in: &cancellables)
    }

    func load() {
        stateErrorSubject.send(nil)
        stateLoadingSubject.send(true)
        model.load(objectNumber: configuration.objectNumber)
    }

    func reload() {
        model.reset()
        load()
    }
}

// MARK: - Helpers

private extension CollectionDetailsViewModelImpl {

    func convert(
        modelItem: CollectionDetailsModelItem
    ) -> CollectionDetailsDataSourceSnapshot {
        var snapshot = CollectionDetailsDataSourceSnapshot()
        let art = modelItem.art

        /// Add image item.
        let image = art.image
        snapshot.appendSections([.image])
        snapshot.appendItems([
            .image(.init(
                imageUrl: image.url,
                width: image.width,
                height: image.height
            ))
        ], toSection: .image)

        /// Add general info item.
        snapshot.appendSections([.general])
        snapshot.appendItems([
            .general(.init(
                title: art.title,
                subtitle: art.subtitle
            ))
        ], toSection: .general)

        /// Add author info item.
        if let author = art.author {
            let authorSection = CollectionDetailsViewItem.Section.author(
                .init(title: L10n.author)
            )
            snapshot.appendSections([authorSection])
            snapshot.appendItems([
                .spec(.init(key: L10n.name, value: author))
            ], toSection: authorSection)
        }

        /// Add dimensions info item.
        if let dimensions = art.dimensions {
            let dimensionsSection = CollectionDetailsViewItem.Section.dimensions(
                .init(title: L10n.dimensions)
            )
            snapshot.appendSections([dimensionsSection])
            snapshot.appendItems(
                dimensions.map {
                    .spec(.init(key: $0.type, value: "\($0.value) \($0.unit)"))
                }, toSection: dimensionsSection)
        }

        /// Add description info item.
        if let description = art.label?.description {
            let descriptionSection = CollectionDetailsViewItem.Section.description(
                .init(title: L10n.description)
            )
            snapshot.appendSections([descriptionSection])
            snapshot.appendItems([
                .text(.init(text: description))
            ], toSection: descriptionSection)
        }

        return snapshot
    }
}
