//
//  CollectionDetailsTextCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDk
import StyleKit

private extension CollectionDetailsTextCell {

    // MARK: - Constants

    enum Constants {
        static var hMargin: CGFloat { 20.0 }
        static var vMargin: CGFloat { 5.0 }
    }
}

// MARK: - Definition

final class CollectionDetailsTextCell: UICollectionViewCell {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primarySubhead)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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

extension CollectionDetailsTextCell {

    func configure(with item: CollectionDetailsViewItem.TextItem) {
        textLabel.text = item.text
    }
}

// MARK: - Setup views

private extension CollectionDetailsTextCell {

    func setupViews() {
        setupTextLabel()
    }

    func setupTextLabel() {

        contentView.addSubview(textLabel)

        let trailingConstraint = textLabel.trailingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.hMargin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = textLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.vMargin
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.hMargin
            ),
            textLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.vMargin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }
}
