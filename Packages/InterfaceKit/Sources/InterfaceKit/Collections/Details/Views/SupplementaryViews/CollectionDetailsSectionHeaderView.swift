//
//  CollectionDetailsSectionHeaderView.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit

private extension CollectionDetailsSectionHeaderView {

    // MARK: - Constants

    enum Constants {
        static var hMargin: CGFloat { 20.0 }
        static var vMargin: CGFloat { 30.0 }
        static var separatorHeight: CGFloat { 1.0 }
    }
}

// MARK: - Definition

final class CollectionDetailsSectionHeaderView: UICollectionReusableView {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldTitle3)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = style.colours.gray
        return view
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

extension CollectionDetailsSectionHeaderView {

    func configure(with item: CollectionDetailsViewItem.Section.SectionItem) {
        titleLabel.text = item.title
    }
}

// MARK: - Setup views

private extension CollectionDetailsSectionHeaderView {

    func setupViews() {
        setupContainerView()
        setupSeparator()
        setupTitleLabel()
    }

    func setupContainerView() {
        addSubview(containerView)

        let trailingConstraint = containerView.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.hMargin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = containerView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.vMargin / 3.0
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.hMargin
            ),
            containerView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.vMargin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }

    func setupTitleLabel() {
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            titleLabel.topAnchor.constraint(
                equalTo: separatorView.bottomAnchor,
                constant: Constants.vMargin / 2.0
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            )
        ])
    }

    func setupSeparator() {
        containerView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            separatorView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: Constants.separatorHeight
            )
        ])
    }
}
