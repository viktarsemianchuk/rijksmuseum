//
//  CollectionListModelImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import ServiceKit

private extension CollectionListModelImpl {

    // MARK: - Constants

    enum Constants {
        static var pageSise: Int { 10 }
    }
}

// MARK: - Definition

final class CollectionListModelImpl {

    private let networkSession: NetworkSession
    private let networkRequestFactory: NetworkRequestFactory

    private let didLoadSubject = PassthroughSubject<CollectionListLoadResult, Never>()

    private var loadResults = CollectionListLoadSuccessResult(
        artObjects: [],
        count: 0
    ) {
        didSet {
            didLoadSubject.send(.success(loadResults))
        }
    }
    private var currentPage = 0
    private var loadTransaction: AnyCancellable?

    init(
        networkSession: NetworkSession,
        networkRequestFactory: NetworkRequestFactory
    ) {
        self.networkSession = networkSession
        self.networkRequestFactory = networkRequestFactory
    }
}

// MARK: - CollectionListModelRequest implementation

extension CollectionListModelImpl: CollectionListModelRequest {

    func load() {
        guard loadTransaction == nil else { return }
        let request = networkRequestFactory.makeCollection()
            .withPageNumber(currentPage + 1)
            .withItemsCount(Constants.pageSise)
            .withImageOnly(true)
            .build()
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
                self?.handleResult(result)
                self?.currentPage += 1
                self?.loadTransaction = nil
            }
    }

    func reset() {
        loadResults = CollectionListLoadSuccessResult(artObjects: [], count: 0)
        currentPage = 0
        loadTransaction = nil
    }
}

// MARK: - CollectionListModelResponse implementation

extension CollectionListModelImpl: CollectionListModelResponse {

    var didLoad: AnyPublisher<CollectionListLoadResult, Never> {
        didLoadSubject.eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension CollectionListModelImpl {

    func handleResult(_ result: CollectionListLoadSuccessResult) {
        loadResults = .init(
            artObjects: loadResults.artObjects + result.artObjects,
            count: result.count
        )
    }
}
