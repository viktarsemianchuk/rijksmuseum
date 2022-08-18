//
//  CollectionDetailsSpecCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit

private extension CollectionDetailsSpecCell {

    // MARK: - Constants

    enum Constants {
        static var hMargin: CGFloat { 20.0 }
        static var vMargin: CGFloat { 5.0 }
        static var hSpacing: CGFloat { 5.0 }
    }
}

// MARK: - Definition

final class CollectionDetailsSpecCell: UICollectionViewCell {

    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldSubhead)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primarySubhead)
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

extension CollectionDetailsSpecCell {

    func configure(with item: CollectionDetailsViewItem.SpecItem) {
        keyLabel.text = item.key
        valueLabel.text = item.value
    }
}

// MARK: - Setup views

private extension CollectionDetailsSpecCell {

    func setupViews() {
        setupLabels()
    }

    func setupLabels() {
        let stackView = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.hSpacing
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
