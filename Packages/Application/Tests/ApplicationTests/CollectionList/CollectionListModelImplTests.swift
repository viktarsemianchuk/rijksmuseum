// System
import Combine
import XCTest
@testable import Application

// SDK
import ServiceKit
import LocalizationKit

final class CollectionListModelImplTests: XCTestCase {

    var model: CollectionListModel!
    var mockNetworkSession: MockNetworkSession!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        mockNetworkSession = MockNetworkSession()
        model = CollectionListModelImpl(
            networkSession: mockNetworkSession,
            networkRequestFactory: NetworkRequestFactory(
                baseUrl: "", language: .english, apiKey: ""
            )
        )
        cancellables = []
    }

    override func tearDown() {
        model = nil
        mockNetworkSession = nil
        cancellables = nil
    }
}

// MARK: - Load

extension CollectionListModelImplTests {

    func testLoadSucceed() {
        let expectedObject = CollectionListLoadSuccessResult(
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

        mockNetworkSession.mockRequestResult = {
            .success(try! JSONEncoder().encode(expectedObject))
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .success(let actualObject):
                    XCTAssertEqual(actualObject, expectedObject)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }

    func testLoadFailedDueInvalidRequest() {
        mockNetworkSession.mockRequestResult = {
            .failure(NetworkSessionError.invalidRequestError)
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .genericError)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }

    func testLoadFailedDueTransportError() {
        mockNetworkSession.mockRequestResult = {
            .failure(NetworkSessionError.transportError(
                URLError(.networkConnectionLost)
            ))
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .genericError)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }

    func testLoadFailedDueInvalidResponse() {
        mockNetworkSession.mockRequestResult = {
            .failure(NetworkSessionError.invalidResponse)
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .genericError)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }

    func testLoadFailedDueServerError() {
        let reason = "Not Found"

        mockNetworkSession.mockRequestResult = {
            .failure(NetworkSessionError.serverError(
                statusCode: 404,
                message: reason
            ))
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .serverError(reason: reason))
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }

    func testLoadFailedDueDecodingError() {
        mockNetworkSession.mockRequestResult = {
            .failure(NetworkSessionError.decodingError(
                DecodingError.dataCorrupted(
                    .init(codingPath: [], debugDescription: "")
                )
            ))
        }

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .failure(let error):
                    XCTAssertEqual(error, .genericError)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.load()

        waitForExpectations(timeout: 0.001)
    }
}

// MARK: - Reset

extension CollectionListModelImplTests {

    func testResetSucceed() {
        let expectedObject = CollectionListLoadSuccessResult(
            artObjects: [], count: 0
        )

        let expectation = expectation(
            description: "didLoad should emit result"
        )

        model.didLoad
            .sink { result in
                switch result {
                case .success(let actualObject):
                    XCTAssertEqual(actualObject, expectedObject)
                default:
                    XCTFail()
                }
                expectation.fulfill()
            }
            .store(in: &cancellables)
        model.reset()

        waitForExpectations(timeout: 0.001)
    }
}
