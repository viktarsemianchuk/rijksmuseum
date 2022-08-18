//
//  CollectionListViewImpl.swift
//
//
//  Created by Viktar Semianchuk on 18.08.22.
//

import Combine
import UIKit

private extension CollectionListViewImpl {

    // MARK: - Constants

    enum Constants {
        static var collectionArtCellId: String { "CollectionArtCell" }
        static var collectionLoadingCellId: String { "CollectionLoadingCell" }
        static var collectionArtsSectionId: String {
            "CollectionsListArtSectionHeaderView"
        }
        static var loadingCellHeight: CGFloat { 100.0 }
    }

    // MARK: - Private typealiases

    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionListViewItem.Section, CollectionListViewItem>
}

// MARK: - Definition

final public class CollectionListViewImpl: UIView, CollectionListViewOutput {

    // MARK: - CollectionListViewOutput implementation

    public var outputSnapshot: CollectionsListDataSourceSnapshot? {
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
            CollectionListArtCell.self,
            forCellWithReuseIdentifier: Constants.collectionArtCellId
        )
        collectionView.register(
            CollectionListLoadingCell.self,
            forCellWithReuseIdentifier: Constants.collectionLoadingCellId
        )
        collectionView.register(
            CollectionListArtSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.collectionArtsSectionId
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

    private let inputItemSelectedSubject =
    PassthroughSubject<CollectionListViewItem, Never>()
    private let inputEndOfListReachedSubject = PassthroughSubject<Void, Never>()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionListViewInput implementation

extension CollectionListViewImpl: CollectionListViewInput {

    public var inputItemSelected: AnyPublisher<CollectionListViewItem, Never> {
        inputItemSelectedSubject.eraseToAnyPublisher()
    }

    public var inputEndOfListReached: AnyPublisher<Void, Never> {
        inputEndOfListReachedSubject.eraseToAnyPublisher()
    }

    public var inputReloadInitiated: AnyPublisher<Void, Never> {
        errorView.inputActionInitiated
    }
}

// MARK: - UICollectionViewDelegateFlowLayout implementation

extension CollectionListViewImpl: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else { return .zero }

        switch item {
        case .art(let artItem):
            let cell = CollectionListArtCell(frame: .zero)
            cell.configure(with: artItem)
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
        case .loading:
            return .init(
                width: collectionView.safeAreaLayoutGuide.layoutFrame.width,
                height: Constants.loadingCellHeight
            )
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let section = dataSource.sectionIdentifier(for: section)
        else { return .zero }

        switch section {
        case .arts(let item):
            let headerView = CollectionListArtSectionHeaderView(frame: .zero)
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
        default:
            return .zero
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else { return }
        inputItemSelectedSubject.send(item)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let item = dataSource.itemIdentifier(for: indexPath)
        else { return }

        switch item {
        case .loading:
            (cell as? CollectionListLoadingCell)?.startLoading()
            inputEndOfListReachedSubject.send(())
        default:
            break
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        (cell as? CollectionListLoadingCell)?.stopLoading()
    }
}

// MARK: - Setup views

private extension CollectionListViewImpl {

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
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
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

private extension CollectionListViewImpl {

    func provideCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: CollectionListViewItem
    ) -> UICollectionViewCell? {
        switch item {
        case .art(let artItem):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionArtCellId,
                for: indexPath
            ) as? CollectionListArtCell else {
                return nil
            }
            cell.configure(with: artItem)
            return cell
        case .loading:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.collectionLoadingCellId,
                for: indexPath
            ) as? CollectionListLoadingCell else {
                return nil
            }
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
            case .arts(let item):
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: Constants.collectionArtsSectionId,
                    for: indexPath
                ) as? CollectionListArtSectionHeaderView else { return nil }
                headerView.configure(with: item)
                return headerView
            default:
                return nil
            }
        default:
            return nil
        }
    }
}
