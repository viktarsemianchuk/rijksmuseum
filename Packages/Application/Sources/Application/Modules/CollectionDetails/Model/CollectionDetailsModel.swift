//
//  CollectionDetailsModel.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import Foundation

// SDK
import LocalizationKit

typealias CollectionDetailsLoadResult =
Result<CollectionDetailsModelItem, CollectionDetailsModelError>

enum CollectionDetailsModelError: Error, Equatable {
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

/// Describes a list APIs which can be used to make a request to a model.
protocol CollectionDetailsModelRequest {
    func load(objectNumber: String)
    func reset()
}

/// Describes a list publishers which notifies subscribers about result of made requests or about async
/// events occured based on other reasons.
protocol CollectionDetailsModelResponse {
    var didLoad: AnyPublisher<CollectionDetailsLoadResult, Never> { get }
}

typealias CollectionDetailsModel = (
    CollectionDetailsModelRequest &
    CollectionDetailsModelResponse
)
