//
//  CollectionListModel.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import LocalizationKit

enum CollectionListModelError: Error, Equatable {
    case serverError(reason: String?)
    case genericError

    var errorDescription: String {
        switch self {
        case .serverError(let reason):
            return reason ?? L10n.serverError
        case .genericError:
            return L10n.genericLoadErrorDescription
        }
    }
}

typealias CollectionListLoadResult =
Result<CollectionListLoadSuccessResult, CollectionListModelError>

/// Describes a list APIs which can be used to make a request to a model.
protocol CollectionListModelRequest {
    func load()
    func reset()
}

/// Describes a list publishers which notifies subscribers about result of made requests or about async
/// events occured based on other reasons.
protocol CollectionListModelResponse {
    var didLoad: AnyPublisher<CollectionListLoadResult, Never> { get }
}

typealias CollectionListModel = (
    CollectionListModelRequest &
    CollectionListModelResponse
)
