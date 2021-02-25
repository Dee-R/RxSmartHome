//  ApiNetworkTests.swift

import XCTest
@testable import RxSmartHome

class ApiNetworkTests: XCTestCase {
    var sut: ApiNetwork!
    override func setUp() {
        super.setUp()
        sut = ApiNetwork()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    let urlValid: String = "http://storage42.com/modulotest/data.json"
    let urlNil:String? = nil
    let urlInvalid:String = ""
    
    // session
    func test_fetchFromUrl_withInvalidSession_given_ErrorCode100() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 100")
        
        sut.session = nil
        sut.fetchFromURL(urlString: urlValid, success: { (data) in
            // do nothing
        }, failure: { (error) in
            if error.code == 100 {
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    // url
    func test_fetchFromUrl_getUrlNil_given_errorCode101() {
        let expectation = self.expectation(description: "Expected failure block to be called with error code = 101")
        
        sut.fetchFromURL(urlString: urlNil, success: { (data) in
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
        sut.fetchFromURL(urlString: urlInvalid, success: { (data) in
            // do nothing
        }, failure: { (error) in
            if error.code == 101 {
                expectation.fulfill()
            }
        })
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    // data
    func test_fetchFromUrl_callDataTaskOnUrlSession_given_sameUrlString() {
        let exp = expectation(description: "expected called and get url")
        guard let expUrl = URL(string: urlValid) else { return }
        
        // session
        let m = MockURLSession()
        m.expectation = exp
        m.expURL = expUrl
        let st = ApiNetwork()
        st.session = m
        st.fetchFromURL(urlString: urlValid) { (da) in
            
        } failure: { (e) in
            
        }
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}

class MockURLSession: IURLSession {
    
    var expectation:XCTestExpectation?
    var expURL: URL?
    var dataTaskToReturn: MockURLSessionDataTask?
    
    init(){
        dataTaskToReturn = MockURLSessionDataTask()
    }
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        print("coucou")
        
        self.dataTaskToReturn?.expect = expectation
        self.dataTaskToReturn?.completionHandler = completionHandler
        
        return dataTaskToReturn!
    }
}
class MockURLSessionDataTask: URLSessionDataTask {
    var expect: XCTestExpectation?
    var completionHandler:((Data?, URLResponse?, Error?) -> Swift.Void)?
    
    override func resume() {
        self.expect?.fulfill()
        if let completionHandler = completionHandler {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completionHandler(nil, nil, nil)
            }
        }
    }
}
