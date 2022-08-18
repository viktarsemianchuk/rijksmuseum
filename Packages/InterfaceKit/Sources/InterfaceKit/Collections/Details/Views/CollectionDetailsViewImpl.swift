//
//  CollectionDetailsViewImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import UIKit

private extension CollectionDetailsViewImpl {

    // MARK: - Constants

    enum Constants {
        static var collectionDetailsImageCellId: String {
            "CollectionDetailsImageCell"
        }
        static var collectionDetailsGeneralCellId: String {
            "CollectionDetailsGeneralCell"
        }
        static var collectionDetailsTextCellId: String {
            "CollectionDetailsTextCell"
        }
        static var collectionDetailsSpecCellId: String {
            "CollectionDetailsSpecCell"
        }
        static var collectionDetailsHeaderId: String {
            "CollectionDetailsSectionHeaderView"
        }
    }

    // MARK: - Typealiases

    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionDetailsViewItem.Section, CollectionDetailsViewItem>
}

// MARK: - Definition

final public class CollectionDetailsViewImpl: UIView, CollectionDetailsViewOutput {

    // MARK: - CollectionDetailsViewOutput implementation

    public var outputSnapshot: CollectionDetailsDataSourceSnapshot? {
        didSet {
            guard let snapshot = outputSnapshot else { return }
            dataSource.apply(snapshot)
        }
    }
    public var outputLoading: Bool = false {
        didSet {
            outputLoading ?
            activityIndicator.startAnimating() :
            activityIndicator.stopAnimating()
        }
    }
    public var outputError: ErrorViewItem? {
        didSet {
            guard let item = outputError else {
                errorView.removeFromSuperview()
                collectionView.backgroundView = nil
                return
            }
            errorView.outputState = item
            collectionView.backgroundView = errorView
        }
    }

    // MARK: - Private properties

    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(
            CollectionDetailsImageCell.self,
            forCellWithReuseIdentifier: Constants.collectionDetailsImageCellId
        )
        collectionView.register(
            CollectionDetailsGeneralCell.self,
            forCellWithReuseIdentifier: Constants.collectionDetailsGeneralCellId
        )
        collectionView.register(
            CollectionDetailsTextCell.self,
            forCellWithReuseIdentifier: Constants.collectionDetailsTextCellId
        )
        collectionView.register(
            CollectionDetailsSpecCell.self,
            forCellWithReuseIdentifier: Constants.collectionDetailsSpecCellId
        )
        collectionView.register(
            CollectionDetailsSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.collectionDetailsHeaderId
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private let errorView = ErrorViewImpl()

    private lazy var dataSource: DataSource = {

        let dataSource = DataSource(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            self?.provideCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: item
            )
        }

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.provideSupplementaryView(
                collectionView: collectionView,
                kind: kind,
                indexPath: indexPath
            )
        }

        return dataSource
    }()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionDetailsViewInput implementation {

extension CollectionDetailsViewImpl: CollectionDetailsViewInput {

    public var inputReloadInitiated: AnyPublisher<Void, Never> {
        errorView.inputActionInitiated
    }
}

// MARK: - UICollectionViewDelegateFlowLayout implementation

extension CollectionDetailsViewImpl: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else { return .zero }

        var cell: UICollectionViewCell

        switch item {
        case .image(let item):
            let imageCell = CollectionDetailsImageCell(frame: .zero)
            imageCell.configure(with: item)
            cell = imageCell
        case .general(let item):
            let generalCell = CollectionDetailsGeneralCell(frame: .zero)
            generalCell.configure(with: item)
            cell = generalCell
        case .text(let item):
            let textCell = CollectionDetailsTextCell(frame: .zero)
            textCell.configure(with: item)
            cell = textCell
        case .spec(let item):
            let specCell = CollectionDetailsSpecCell(frame: .zero)
            specCell.configure(with: item)
            cell = specCell
        }

        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        let targetSize = CGSize(
            width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
            height: UIView.layoutFittingCompressedSize.height
        )

        return cell.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let section = dataSource.sectionIdentifier(for: section)
        else { return .zero }

        switch section {
        case .image, .general:
            return .zero
        case .author(let item), .description(let item), .dimensions(let item):
            let headerView = CollectionDetailsSectionHeaderView(frame: .zero)
            headerView.configure(with: item)
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()

            let targetSize = CGSize(
                width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                height: UIView.layoutFittingCompressedSize.height
            )

            return headerView.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0.0
    }
}

// MARK: - Setup views

private extension CollectionDetailsViewImpl {

    func setupViews() {
        setupCollectionView()
        setupActivityIndicator()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupActivityIndicator() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - Cell providing

private extension CollectionDetailsViewImpl {

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: CollectionDetailsViewItem
    ) -> UICollectionViewCell? {
        switch item {
        case .image(let imageItem):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionDetailsImageCellId,
                for: indexPath
            ) as? CollectionDetailsImageCell else { return nil }
            cell.configure(with: imageItem)
            return cell
        case .general(let generalItem):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionDetailsGeneralCellId,
                for: indexPath
            ) as? CollectionDetailsGeneralCell else { return nil }
            cell.configure(with: generalItem)
            return cell
        case .text(let textItem):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionDetailsTextCellId,
                for: indexPath
            ) as? CollectionDetailsTextCell else { return nil }
            cell.configure(with: textItem)
            return cell
        case .spec(let specItem):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionDetailsSpecCellId,
                for: indexPath
            ) as? CollectionDetailsSpecCell else { return nil }
            cell.configure(with: specItem)
            return cell
        }
    }

    func provideSupplementaryView(
        collectionView: UICollectionView,
        kind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let section = dataSource.sectionIdentifier(for: indexPath.section)
            else { return nil }
            switch section {
            case .image, .general:
                return nil
            case .author(let item), .description(let item), .dimensions(let item):
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Constants.collectionDetailsHeaderId,
                    for: indexPath
                ) as? CollectionDetailsSectionHeaderView else { return nil }
                headerView.configure(with: item)
                return headerView
            }
        default:
            return nil
        }
    }
}
