//
//  CollectionListArtSectionHeaderView.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit

private extension CollectionListArtSectionHeaderView {

    // MARK: - Constants

    enum Constants {
        static var hMargin: CGFloat { 20.0 }
        static var vMargin: CGFloat { 30.0 }
        static var bottomMagin: CGFloat { 0.0 }
    }
}

// MARK: - Definition

final class CollectionListArtSectionHeaderView: UICollectionReusableView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldTitle1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.secondarySubhead)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
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

extension CollectionListArtSectionHeaderView {

    func configure(with item: CollectionListViewItem.Section.ArtSectionItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}

// MARK: - Setup views

private extension CollectionListArtSectionHeaderView {

    func setupViews() {
        setupLabels()
    }

    func setupLabels() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        let trailingConstraint = stackView.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.hMargin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = stackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: Constants.bottomMagin
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.hMargin
            ),
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.vMargin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }
}

