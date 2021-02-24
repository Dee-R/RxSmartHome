//  MockURLSession.swift

import Foundation
import XCTest

//225
class MockURLSession: URLSessionProtocol {
    var dataTaskExpectation: (XCTestExpectation, expectedURL:URL)?
    var dataTaskToReturn: MockURLSessionDataTask?
    
    init(){
        self.dataTaskToReturn = MockURLSessionDataTask()
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if let (expectation, expectedValue) = self.dataTaskExpectation {
            if expectedValue.absoluteString.compare(url.absoluteString) == .orderedSame {
                expectation.fulfill()
            }
        }
        
        dataTaskToReturn?.completionHandler = completionHandler
        
        return self.dataTaskToReturn!
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeExpectetation:XCTestExpectation?
    var completionHandler: ((Data?, URLResponse?, Error?) -> Swift.Void)?
    var dataToReturn:Data?
    var responseToReturn: URLResponse?
    var errorTotReturn: Error?
    
    override func resume() {
        resumeExpectetation?.fulfill()
        
        if let completionHandler = completionHandler {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completionHandler( self.dataToReturn, self.responseToReturn, self.errorTotReturn )
            }
        }
    }
    
}
