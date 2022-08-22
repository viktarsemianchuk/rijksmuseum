//
//  ErrorViewImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import Combine
import UIKit

// SDK
import StyleKit

private extension ErrorViewImpl {

    // MARK: - Constants

    enum Constants {
        static var vSpaing: CGFloat { 15.0 }
        static var iconWidth: CGFloat { 50.0 }
        static var contentScreenRatio: CGFloat { 0.75 }
    }
}

// MARK: - Definition

public final class ErrorViewImpl: UIView, ErrorViewOutput {

    // MARK: - ErrorViewOutput implementation

    public var outputState: ErrorViewItem? {
        didSet {
            guard let state = outputState else { return }
            titleLabel.text = state.title
            subtitleLabel.text = state.subtitle
            actionButton.setTitle(state.buttonTitle, for: .normal)
        }
    }

    // MARK: - Private properties

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = style.icons.storm
        imageView.tintColor = style.colours.tint
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldTitle1)
        label.textColor = style.colours.tint
        label.textAlignment = .center
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBody)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(style.colours.tint, for: .normal)
        button.addTarget(
            self,
            action: #selector(handleActionButtonTap),
            for: .touchUpInside
        )
        return button
    }()

    private let inputActionInitiatedSubject = PassthroughSubject<Void, Never>()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ErrorViewInput implementation

extension ErrorViewImpl: ErrorViewInput {

    public var inputActionInitiated: AnyPublisher<Void, Never> {
        inputActionInitiatedSubject.eraseToAnyPublisher()
    }
}

// MARK: - Setup views

private extension ErrorViewImpl {

    func setupViews() {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                titleLabel,
                subtitleLabel, actionButton
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.vSpaing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(
                equalToConstant: Constants.iconWidth
            ),
            iconImageView.heightAnchor.constraint(
                equalTo: iconImageView.widthAnchor
            ),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: Constants.contentScreenRatio
            )
        ])
    }
}

private extension ErrorViewImpl {

    @objc
    func handleActionButtonTap() {
        inputActionInitiatedSubject.send(())
    }
}
