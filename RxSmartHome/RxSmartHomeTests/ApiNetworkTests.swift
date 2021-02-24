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
        self.wait(for: [expectation], timeout: 1)
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
        self.wait(for: [expectation], timeout: 1)
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
    
    //
}
