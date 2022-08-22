//
//  CollectionDetailsModelImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import ServiceKit

// MARK: - Definition

final class CollectionDetailsModelImpl {

    private let networkSession: NetworkSession
    private let networkRequestFactory: NetworkRequestFactory

    private let didLoadSubject = PassthroughSubject<CollectionDetailsLoadResult, Never>()

    private var loadTransaction: AnyCancellable?

    init(
        networkSession: NetworkSession,
        networkRequestFactory: NetworkRequestFactory
    ) {
        self.networkSession = networkSession
        self.networkRequestFactory = networkRequestFactory
    }
}

// MARK: - CollectionDetailsModelRequest implementation

extension CollectionDetailsModelImpl: CollectionDetailsModelRequest {

    func load(objectNumber: String) {
        guard loadTransaction == nil else { return }
        let request = networkRequestFactory.makeCollectionDetails(
            objectNumber: objectNumber
        )
        loadTransaction = networkSession.perform(request)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    switch error {
                    case NetworkSessionError.serverError(_, let message):
                        self?.didLoadSubject.send(.failure(.serverError(
                            reason: message
                        )))
                    default:
                        self?.didLoadSubject.send(.failure(.genericError))
                    }
                default:
                    break
                }
                self?.loadTransaction = nil
            } receiveValue: { [weak self] result in
                self?.didLoadSubject.send(.success(result))
                self?.loadTransaction = nil
            }
    }

    func reset() {
        loadTransaction = nil
    }
}

// MARK: - CollectionDetailsModelResponse implementation

extension CollectionDetailsModelImpl: CollectionDetailsModelResponse {

    var didLoad: AnyPublisher<CollectionDetailsLoadResult, Never> {
        didLoadSubject.eraseToAnyPublisher()
    }
}
