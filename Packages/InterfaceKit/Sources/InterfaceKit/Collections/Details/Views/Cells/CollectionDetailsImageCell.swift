//
//  CollectionDetailsImageCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

// System
import UIKit

// SDK
import Kingfisher

private extension CollectionDetailsImageCell {

    // MARK: - Constants

    enum Constants {
        static var margin: CGFloat { 20.0 }
    }
}

// MARK: - Definition

final class CollectionDetailsImageCell: UICollectionViewCell {

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var heightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension CollectionDetailsImageCell {

    func configure(with item: CollectionDetailsViewItem.ImageItem) {
        heightConstraint.flatMap { photoImageView.removeConstraint($0) }
        heightConstraint = photoImageView.heightAnchor.constraint(
            equalTo: photoImageView.widthAnchor,
            multiplier: item.height / item.width
        )
        heightConstraint?.isActive = true

        photoImageView.kf.setImage(with: URL(string: item.imageUrl))
    }
}

// MARK: - Setup views

private extension CollectionDetailsImageCell {

    func setupViews() {
        setupPhotoImageView()
    }

    func setupPhotoImageView() {

        contentView.addSubview(photoImageView)

        let trailingConstraint = photoImageView.trailingAnchor.constraint(
            equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
            constant: -Constants.margin
        )
        trailingConstraint.priority = .init(rawValue: 999.0)

        let bottomConstraint = photoImageView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.margin
        )
        bottomConstraint.priority = .init(rawValue: 999.0)

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: Constants.margin
            ),
            photoImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.margin
            ),
            trailingConstraint,
            bottomConstraint
        ])
    }
}
