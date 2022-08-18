//
//  CollectionDetailsGeneralCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit

private extension CollectionDetailsGeneralCell {

    // MARK: - Constants

    enum Constants {
        static var hMargin: CGFloat { 20.0 }
        static var vMargin: CGFloat { 5.0 }
        static var vSpacing: CGFloat { 5.0 }
    }
}

// MARK: - Definition

final class CollectionDetailsGeneralCell: UICollectionViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldTitle1)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.secondaryBody)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension CollectionDetailsGeneralCell {

    func configure(with item: CollectionDetailsViewItem.GeneralItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}

// MARK: - Setup views

private extension CollectionDetailsGeneralCell {

    func setupViews() {
        setupLabels()
    }

    func setupLabels() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.vSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        let trailingConstraint = stackView.trailingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.hMargin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = stackView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.vMargin
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.hMargin
            ),
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.vMargin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }
}
