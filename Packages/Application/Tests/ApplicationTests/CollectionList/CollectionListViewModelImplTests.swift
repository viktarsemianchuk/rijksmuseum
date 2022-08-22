// System
import Combine
import XCTest
@testable import Application

// SDK
import InterfaceKit

final class CollectionListViewModelImplTests: XCTestCase {

    var viewModel: CollectionListViewModel!
    var mockModel: MockCollectionListModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        mockModel = MockCollectionListModel()
        viewModel = CollectionListViewModelImpl(model: mockModel)
        cancellables = []
    }

    override func tearDown() {
        mockModel = nil
        viewModel = nil
        cancellables = nil
    }
}

// MARK: - Loading

extension CollectionListViewModelImplTests {

    func testLoadWithSetupSuccess() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(self.mockModelItem)
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
            XCTAssertEqual(
                snapshotState?.numberOfItems,
                self.mockModelItem.artObjects.count + 1
            )
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

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        mockModel.mockLoadResult = {
            .success(self.mockModelItem)
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
        var snapshotState: CollectionsListDataSourceSnapshot?

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
        var snapshotState: CollectionsListDataSourceSnapshot?

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

extension CollectionListViewModelImplTests {

    func testReloadAfterLoadingSuccess() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        viewModel.setup()
        viewModel.load()

        mockModel.mockLoadResult = {
            .success(self.mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(
                snapshotState?.numberOfItems,
                self.mockModelItem.artObjects.count + 1
            )
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

    func testReloadAfterLoadingFailure() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        viewModel.setup()
        viewModel.load()

        mockModel.mockLoadResult = {
            .failure(.serverError(reason: ""))
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNotNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
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

    func testReloadWithoutLoadingSuccess() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        viewModel.setup()

        mockModel.mockLoadResult = {
            .success(self.mockModelItem)
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(
                snapshotState?.numberOfItems,
                self.mockModelItem.artObjects.count + 1
            )
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

    func testReloadWithoutLoadingFailure() {

        let expectation = expectation(
            description: "Waiting for result"
        )

        var errorState: ErrorViewItem?
        var loadingState: Bool = false
        var snapshotState: CollectionsListDataSourceSnapshot?

        viewModel.setup()

        mockModel.mockLoadResult = {
            .failure(.serverError(reason: ""))
        }
        mockModel.mockLoadingStarted = {
            XCTAssertNil(errorState)
            XCTAssertTrue(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
        }
        mockModel.mockLoadingFinished = {
            XCTAssertNotNil(errorState)
            XCTAssertFalse(loadingState)
            XCTAssertNotNil(snapshotState)
            XCTAssertEqual(snapshotState?.numberOfItems, 0)
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

// MARK: - Handle item selection

extension CollectionListViewModelImplTests {

    func testHandleValidSelecton() {

        let viewModelItem = CollectionListViewItem.Art(
            objectNumber: "31242",
            title: "Title",
            subtitle: "Subtitle",
            image: nil
        )

        let expectation = expectation(
            description: "Waiting for showDetails event"
        )

        viewModel.showDetails
            .sink { objectNumber in
                XCTAssertEqual(
                    viewModelItem.objectNumber,
                    objectNumber
                )
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.handleItemSelection(.art(viewModelItem))

        waitForExpectations(timeout: 0.01)
    }

    func testHandleInvalidSelecton() {

        let expectation = expectation(
            description: "Waiting for showDetails event"
        )
        expectation.isInverted = true

        viewModel.showDetails
            .sink { objectNumber in
                XCTFail()
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.handleItemSelection(.loading)

        waitForExpectations(timeout: 0.01)
    }
}

// MARK: - Helper

private extension CollectionListViewModelImplTests {

    var mockModelItem: CollectionListLoadSuccessResult {
        .init(
            artObjects: [
                .init(
                    id: "123",
                    objectNumber: "456",
                    title: "Test title",
                    author: "Test Author",
                    image: .init(
                        width: 100.0,
                        height: 100.0,
                        url: "https://test.com"
                    )
                )
            ],
            count: 2
        )
    }
}
