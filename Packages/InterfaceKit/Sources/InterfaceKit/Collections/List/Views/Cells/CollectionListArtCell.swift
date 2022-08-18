//
//  CollectionListArtCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import StyleKit
import Kingfisher

private extension CollectionListArtCell {

    // MARK: - Constants

    enum Constants {
        static var margin: CGFloat { 20.0 }
        static var vSpacing: CGFloat { 15.0 }
    }
}

// MARK: - Definition

final class CollectionListArtCell: UICollectionViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: style.labels.primaryBoldBody)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.apply(style: style.labels.secondaryBody)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private var imageViewHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension CollectionListArtCell {

    func configure(with item: CollectionListViewItem.Art) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        if let image = item.image {
            imageViewHeightConstraint.flatMap {
                photoImageView.removeConstraint($0)
            }
            imageViewHeightConstraint = photoImageView.heightAnchor.constraint(
                equalTo: photoImageView.widthAnchor,
                multiplier: image.height / image.width
            )
            imageViewHeightConstraint?.isActive = true

            photoImageView.kf.setImage(with: URL(string: image.url))
        }
    }
}

// MARK: - Setup views

private extension CollectionListArtCell {

    func setupViews() {
        setupContainerView()
        setupPhotoImageView()
        setupLabels()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)

        let trailingConstraint = containerView.trailingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.margin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = containerView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.margin / 4.0
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.margin
            ),
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.margin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }

    func setupPhotoImageView() {
        containerView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            photoImageView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            photoImageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            )
        ])
    }

    func setupLabels() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.vSpacing / 2.0

        containerView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            stackView.topAnchor.constraint(
                equalTo: photoImageView.bottomAnchor,
                constant: Constants.vSpacing
            )
        ])
    }
}
