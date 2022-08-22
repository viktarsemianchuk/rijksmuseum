import XCTest
@testable import Application

private extension NetworkRequestFactoryTests {

    enum Constants {
        static var validUrl: String { "https://test.com" }
        static var invalidUrl: String { "test%com&*%$&" }
    }
}

final class NetworkRequestFactoryTests: XCTestCase {

    var requestFactory: NetworkRequestFactory!

    override func tearDown() {
        requestFactory = nil
    }

    func setupFactory(
        url: String,
        language: NetworkRequestFactory.RequestLanguage,
        apiKey: String
    ) {
        requestFactory = NetworkRequestFactory(
            baseUrl: url,
            language: language,
            apiKey: apiKey
        )
    }
}

// MARK: - Collections request

extension NetworkRequestFactoryTests {

    func testCollectionRequestDutch() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "rjekgjerkgjergre"
        let endPoint = NetworkRequestFactory.RequestAPI.collection

        setupFactory(url: url, language: language, apiKey: apiKey)

        let request = requestFactory.makeCollection().build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, ["key": apiKey])
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestDutchInvalidURL() {
        let url = Constants.invalidUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "43895346hjhkjgreg"
        let endPoint = NetworkRequestFactory.RequestAPI.collection

        setupFactory(url: url, language: language, apiKey: apiKey)

        let request = requestFactory.makeCollection().build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, ["key": apiKey])
        XCTAssertEqual(request.method, .get)
        XCTAssertNil(request.urlRequest)
    }

    func testCollectionRequestEnglish() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.english
        let apiKey = "(*tjkrgregi)"
        let endPoint = NetworkRequestFactory.RequestAPI.collection

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection().build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = ["key": apiKey]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestEnglishInvalidURL() {
        let url = Constants.invalidUrl
        let language = NetworkRequestFactory.RequestLanguage.english
        let apiKey = "jnfjkngeri&()545"
        let endPoint = NetworkRequestFactory.RequestAPI.collection

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection().build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = ["key": apiKey]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNil(request.urlRequest)
    }

    func testCollectionRequestWithPage() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "vngjkneitit"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let pageNumber = 2

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection().withPageNumber(2).build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = ["key": apiKey, "p": "\(pageNumber)"]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestWithPageSize() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "fnj"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let pageSize = 12

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection()
            .withItemsCount(pageSize)
            .build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = ["key": apiKey, "ps": "\(pageSize)"]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestWithPageSizeAndPage() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "jngejrrejkgj*43njekn(r45"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let pageSize = 12
        let pageNumber = 5

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection()
            .withItemsCount(pageSize)
            .withPageNumber(pageNumber)
            .build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = [
            "key": apiKey,
            "ps": "\(pageSize)",
            "p": "\(pageNumber)"
        ]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestWithImg() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "njejknjew^735990q"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let onlyWithImage = true

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection()
            .withImageOnly(onlyWithImage)
            .build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = ["key": apiKey, "imgonly": "\(onlyWithImage)"]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestWithImgAndPage() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "nnkfkfy432rewklejk"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let onlyWithImage = false
        let pageNumber = 10

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection()
            .withImageOnly(onlyWithImage)
            .withPageNumber(pageNumber)
            .build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = [
            "key": apiKey,
            "imgonly": "\(onlyWithImage)",
            "p": "\(pageNumber)"
        ]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionRequestWithImgAndPageAndPageSize() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "vfsjfkjsdfkn#4325"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let onlyWithImage = false
        let pageNumber = 10
        let pageSize = 5

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollection()
            .withImageOnly(onlyWithImage)
            .withPageNumber(pageNumber)
            .withItemsCount(pageSize)
            .build()

        let expectedUrl = url + language.rawValue + endPoint.rawValue
        let expectedQueryItems = [
            "key": apiKey,
            "imgonly": "\(onlyWithImage)",
            "p": "\(pageNumber)",
            "ps": "\(pageSize)"
        ]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }
}

// MARK: - Collection details request

extension NetworkRequestFactoryTests {

    func testCollectionDetailsRequestEnglish() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.english
        let apiKey = "fjsdf#$353"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let objectNumber = "123"

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollectionDetails(
            objectNumber: objectNumber
        )

        let expectedUrl =
        url + language.rawValue + endPoint.rawValue + "/\(objectNumber)"
        let expectedQueryItems = ["key": apiKey]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionDetailsRequestDutch() {
        let url = Constants.validUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "kmefk435435jfo335"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let objectNumber = "dgekgerkgerg35kgo435"

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollectionDetails(
            objectNumber: objectNumber
        )

        let expectedUrl =
        url + language.rawValue + endPoint.rawValue + "/\(objectNumber)"
        let expectedQueryItems = ["key": apiKey]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.urlRequest)
    }

    func testCollectionDetailsRequestInvalidURL() {
        let url = Constants.invalidUrl
        let language = NetworkRequestFactory.RequestLanguage.dutch
        let apiKey = "1243u3ndfjhu4t85"
        let endPoint = NetworkRequestFactory.RequestAPI.collection
        let objectNumber = "fk(enjgrelk883jkfd243&9fe"

        setupFactory(url: url, language: language, apiKey: apiKey)
        let request = requestFactory.makeCollectionDetails(
            objectNumber: objectNumber
        )

        let expectedUrl =
        url + language.rawValue + endPoint.rawValue + "/\(objectNumber)"
        let expectedQueryItems = ["key": apiKey]

        XCTAssertEqual(request.url, expectedUrl)
        XCTAssertEqual(request.queryItems, expectedQueryItems)
        XCTAssertEqual(request.method, .get)
        XCTAssertNil(request.urlRequest)
    }
}
