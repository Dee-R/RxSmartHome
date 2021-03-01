//  ApiNetworkTests.swift

import XCTest
@testable import RxSmartHome

class ApiNetworkTests: XCTestCase {
    var sut: ApiNetwork!
    let urlValid: String = "http://storage42.com/modulotest/data.json"
    let urlNil: String? = nil
    let urlInvalid: String = ""

    override func setUp() {
        super.setUp()
        sut = ApiNetwork()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    // url
    func test_fetchFromUrl_getUrlNil_given_errorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")

        sut.fetchFromURL(urlString: urlNil, success: { _ in
            // do nothing
        }, failure: { (error) in
            if error.code == 101 {
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 0.1)
    }
    func test_fetchFromUrl_getUrlInvalid_given_errorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        sut.fetchFromURL(urlString: urlInvalid, success: { (_) in
            // do nothing
        }, failure: { (error) in
            if error.code == 101 {
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 0.1)
    }

    // session
    func test_fetchFromUrl_withInvalidSession_given_ErrorCode100() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 100")
        sut.session = nil
        sut.fetchFromURL(urlString: urlValid, success: { (_) in }, failure: { (error) in
            if error.code == 100 {
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 1.0)
    }
    func test_fetchFromUrl_withvalidSession_given_NoError() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 100")
        sut.fetchFromURL(urlString: urlValid, success: { (_) in
            expectation.fulfill()
        }, failure: { (_) in })
        self.wait(for: [expectation], timeout: 1.0)
    }

    // data
    func test_fetchFromUrl_callDataTaskOnUrlSession_given_sameUrlString() {
        let exp = expectation(description: "expected called and get url")
        guard let expURL = URL(string: urlValid) else { return }

        // session
        let mockURLSession = MockURLSession()
        mockURLSession.expectation = exp
        mockURLSession.expURL = expURL

        sut.session = mockURLSession
        sut.fetchFromURL(urlString: urlValid) { (_) in } failure: { (_) in }
        wait(for: [exp], timeout: 1.0)
    }
    func test_fetch_dataTaskGetCallOnSession_given_resumeGetCall() {
        let expAssert = expectation(description: "expectation resume called on DataTask")

        let mockURLSession: MockURLSession = MockURLSession()
        mockURLSession.dataTaskToReturn?.resumeExpectation = expAssert

        sut.session = mockURLSession
        sut.fetchFromURL(urlString: urlValid, success: { _ in }, failure: { _ in })
        wait(for: [expAssert], timeout: 1.0)
    }
}

class MockURLSession: IURLSession {
    var expectation: XCTestExpectation?
    var expURL: URL?
    var dataTaskToReturn: MockURLSessionDataTask?

    init() {
        dataTaskToReturn = MockURLSessionDataTask()
    }
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        print("coucou")
        if let unwExpurl = expURL, let exp = expectation {
            if unwExpurl.absoluteString.compare(url.absoluteString) == .orderedSame {
                exp.fulfill()
            }
        }
        self.dataTaskToReturn?.completionHandler = completionHandler
        return dataTaskToReturn!
    }
}
class MockURLSessionDataTask: URLSessionDataTask {
    var resumeExpectation: XCTestExpectation?
    var completionHandler: ((Data?, URLResponse?, Error?) -> Swift.Void)?

    var returnData: Data?
    var returnURLResponse: URLResponse?
    var returnError: Error?

    override func resume() {
        self.resumeExpectation?.fulfill()
        if let completionHandler = completionHandler {
            completionHandler(self.returnData, self.returnURLResponse, returnError)
        }
    }
}
