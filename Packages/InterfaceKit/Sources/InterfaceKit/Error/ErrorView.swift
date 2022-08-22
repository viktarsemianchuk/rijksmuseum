//
//  ErrorView.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import UIKit

/// Describes states which can be received from view model and displayed on the screen.
public protocol ErrorViewOutput {
    var outputState: ErrorViewItem? { get set }
}

/// Describes a list of actios which can be occured on view and should be passed to application (e.g. viewModel).
public protocol ErrorViewInput {
    var inputActionInitiated: AnyPublisher<Void, Never> { get }
}

public typealias ErrorView = (
    ErrorViewOutput &
    ErrorViewInput
)
