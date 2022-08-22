// System
import Combine
import XCTest
@testable import Application

// SDK
import ServiceKit
import LocalizationKit

final class CollectionDetailsModelImplTests: XCTestCase {

    var model: CollectionDetailsModel!
    var mockNetworkSession: MockNetworkSession!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        mockNetworkSession = MockNetworkSession()
        model = CollectionDetailsModelImpl(
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

extension CollectionDetailsModelImplTests {

    func testLoadSucceed() {
        let objectNumber = "wefewf"
        let expectedObject = CollectionDetailsModelItem(
            art: .init(
                id: "1234",
                objectNumber: objectNumber,
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
        model.load(objectNumber: objectNumber)

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
        model.load(objectNumber: "1242424")

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
        model.load(objectNumber: "ewefj43553")

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
        model.load(objectNumber: "fnj353tbbr")

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
        model.load(objectNumber: "fwkjf342orfen")

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
        model.load(objectNumber: "fwknfno2rvnkdw")

        waitForExpectations(timeout: 0.001)
    }
}

