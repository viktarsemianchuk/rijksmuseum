//
//  MockCollectionDetailsModel.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
@testable import Application

final class MockCollectionDetailsModel: CollectionDetailsModel {

    var mockLoadResult: (() -> CollectionDetailsLoadResult)?
    var mockLoadingStarted: (() -> Void)?
    var mockLoadingFinished: (() -> Void)?

    private let didLoadSubject =
    PassthroughSubject<CollectionDetailsLoadResult, Never>()
    var didLoad: AnyPublisher<CollectionDetailsLoadResult, Never> {
        didLoadSubject.eraseToAnyPublisher()
    }

    func load() {
        mockLoadingStarted?()
        if let mockLoadResult = mockLoadResult {
            didLoadSubject.send(mockLoadResult())
        }
        mockLoadingFinished?()
    }

    func load(objectNumber: String) {
        mockLoadingStarted?()
        if let mockLoadResult = mockLoadResult {
            didLoadSubject.send(mockLoadResult())
        }
        mockLoadingFinished?()
    }

    func reset() {}
}
