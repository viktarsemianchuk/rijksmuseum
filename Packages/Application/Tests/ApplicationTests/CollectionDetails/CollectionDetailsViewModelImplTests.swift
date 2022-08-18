// System
import Combine
import XCTest
@testable import Application

// SDK
import InterfaceKit

final class CollectionDetailsViewModelImplTests: XCTestCase {

    var viewModel: CollectionDetailsViewModel!
    var mockModel: MockCollectionDetailsModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        mockModel = MockCollectionDetailsModel()
        viewModel = CollectionDetailsViewModelImpl(
            model: mockModel,
            configuration: .init(objectNumber: "")
        )
        cancellables = []
    }

    override func tearDown() {
        mockModel = nil
        viewModel = nil
        cancellables = nil
    }
}

// MARK: - Loading

extension CollectionDetailsViewModelImplTests {

    func testLoadWithSetupSuccess() {
        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: nil,
                dimensions: nil,
                author: nil
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 2)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.setup()
        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithSetupWithLabelSuccess() {
        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: .init(description: "Test"),
                dimensions: nil,
                author: nil
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 3)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.setup()
        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithSetupWithLabelAndDimensionsSuccess() {
        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: .init(description: "Test"),
                dimensions: [.init(unit: "m", type: "width", value: "45")],
                author: nil
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 4)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.setup()
        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithSetupWithLabelAndDimensionAndAuthorSuccess() {
        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: .init(description: "Test"),
                dimensions: [.init(unit: "m", type: "width", value: "45")],
                author: "Author"
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 5)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.setup()
        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithoutSetupSuccess() {
        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: nil,
                dimensions: nil,
                author: nil
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithSetupFailure() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .failure(.genericError)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNotNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNil(snapshotState)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.setup()
        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }

    func testLoadWithoutSetupFailure() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .failure(.genericError)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.load()

        waitForExpectations(timeout: 0.01)
    }
}

// MARK: - Reload

extension CollectionDetailsViewModelImplTests {

    func testReloadSuccess() {

        let mockModelItem = CollectionDetailsModelItem(
            art: .init(
                id: "123",
                objectNumber: "rewrnj",
                title: "Title",
                subtitle: "Subtitle",
                image: .init(
                    width: 100.0,
                    height: 100.0,
                    url: "https://test.com"
                ),
                label: nil,
                dimensions: nil,
                author: nil
            )
        )

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        viewModel.setup()

        mockModel.mockLoadResult = {
            .success(mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 2)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.reload()

        waitForExpectations(timeout: 0.01)
    }

    func testReloadFailure() {

        let expectation = self.expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionDetailsDataSourceSnapshot?

        viewModel.setup()

        mockModel.mockLoadResult = {
            .failure(.serverError(reason: ""))
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNil(snapshotState)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNotNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNil(snapshotState)
            expectation.fulfill()
        }

        viewModel.stateError
            .sink { state in
                errorState = state
            }
            .store(in: &cancellables)
        viewModel.stateLoading
            .sink { state in
                loadingState = state
            }
            .store(in: &cancellables)
        viewModel.stateSnapshot
            .sink { snapshot in
                snapshotState = snapshot
            }
            .store(in: &cancellables)

        viewModel.reload()

        waitForExpectations(timeout: 0.01)
    }
}
