//
//  MockCollectionListModel.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
@testable import Application

final class MockCollectionListModel: CollectionListModel {

    var mockLoadResult: (() -> CollectionListLoadResult)?
    var mockLoadingStarted: (() -> Void)?
    var mockLoadingFinished: (() -> Void)?

    private let didLoadSubject =
    PassthroughSubject<CollectionListLoadResult, Never>()
    var didLoad: AnyPublisher<CollectionListLoadResult, Never> {
        didLoadSubject.eraseToAnyPublisher()
    }

    func load() {
        mockLoadingStarted?()
        if let mockLoadResult = mockLoadResult {
            didLoadSubject.send(mockLoadResult())
        }
        mockLoadingFinished?()
    }

    func reset() {
        didLoadSubject.send(.success(.init(artObjects: [], count: 0)))
    }
}
