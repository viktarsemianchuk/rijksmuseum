//
//  CollectionLoadingCell.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import UIKit

// MARK: - Definition

final class CollectionListLoadingCell: UICollectionViewCell {

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
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

extension CollectionListLoadingCell {

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - Setup views

private extension CollectionListLoadingCell {

    func setupViews() {
        setupActivityIndicator()
    }

    func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
    }
}
