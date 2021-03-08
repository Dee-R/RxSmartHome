//  ApiNetworkTests.swift

import XCTest
@testable import RxSmartHome

class ApiNetworkTests: XCTestCase {
    var sut: ApiNetwork!
    var mockSession: MockSession!
    let urlValid: String = "http://storage42.com/modulotest/data.json"
    let badUrl: String = ""
    let goodUrl: String = "goodUrl"

    override func setUp() {
        super.setUp()
        sut = ApiNetwork()
        mockSession = MockSession()
    }
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }

    // url
    func test_GivenBadUrl_whenFetch_thenGetErrorNotNil() {
        var expError: NSError?

        let exp = expectation(description: "expected : error not nil")
        sut.fetch(url: badUrl) { _, errorB  in
            expError = errorB
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.01)

        XCTAssertNotNil(expError)
    }
    func test_GivenBadUrl_whenFetch_thenGetDataNil() {
        var expData: DeviceModel?

        let exp = expectation(description: "expected : data is nil")
        sut.fetch(url: badUrl) { data, _ in
            expData = data
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.01)
        XCTAssertNil(expData)
    }


    func test_GivenGoodUrl_whenFetch_thenErrorIsNil() {
        var expError: NSError?
        let exp = expectation(description: "expected : error is nil")
        mockSession.nextData = "{}".data(using: .utf8)
        sut.session = mockSession
        sut.fetch(url: goodUrl) { (_, error) in
			expError = error
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
        XCTAssertNil(expError)
    }
    func test_GivenGoodUrl_whenFetch_thenDataNotNil() {
        var expData: DeviceModel?
        mockSession.nextData = "{}".data(using: .utf8)
        sut.session = mockSession

        let exp = expectation(description: "expected : data not nil")

        sut.fetch(url: goodUrl) { (data, _) in
			expData = data
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.01)

        XCTAssertNotNil(expData)
    }

    // integration test for difficult injection dependance
    func test_GivenSession_whenFetch_thenSessionGetCalled() {
        sut.session = mockSession
        sut.fetch(url: goodUrl) { (_, _) in }
        XCTAssertEqual(mockSession.getCalled, 1)
    }
    func test_GivenSession_whenFetch_thenResumeGetCalled() {
		// session
        // dataTask
        let mockDataTask: MockDataTask = MockDataTask()
        mockSession.dataTask = mockDataTask

        // set session
        sut.session = mockSession
        sut.fetch(url: goodUrl, completion: { _, _ in })
        XCTAssertEqual(mockDataTask.getCalled, 1)
    }

	// decode
    func test_GivenDataNil_whenParse_thenGetNil() {
		// given
        let dataBrut: Data? = nil
        let expData: DeviceModel? = nil

        // when
        let actualData =  sut.parseData(dataBrut)

        // then
        XCTAssertEqual(actualData, expData)
    }
    func test_GivenDataNotNil_whenParse_thenGetData() {
        // given
        let dataBrut: Data? =
		"""
		{
			"devices":
			[
				{
					"id":0,
					"deviceName": "-",
					"productType": "Light",
					"intensity": 0,
					"mode": "OFF",
					"position": 0,
					"temperature": 0
				}
			],
			"user": {
				"firstName": "-",
				"lastName": ""
			}

		}
		""".data(using: .utf8)

        let expData: DeviceModel? = DeviceModel(
            devices: [
                Device(
                    id: 0,
                    deviceName: "-",
                    productType: .light,
                    intensity: 0,
                    mode: "OFF",
                    position: 0,
                    temperature: 0
                )
            ],
            user: User(
                firstName: "-",
                lastName: "",
                address: nil,
                birthDate: nil
            )
        )

        // when
        let actualData =  sut.parseData(dataBrut)

        // then
        XCTAssertEqual(actualData, expData)
    }
}
class MockSession: IURLSession {
	var getCalled: Int = 0
    var dataTask: URLSessionDataTask
    var nextData: Data?
    init() {
        dataTask = MockDataTask()
    }
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        getCalled += 1
        completionHandler(nextData, nil, nil)
        return dataTask
    }
}
class MockDataTask: URLSessionDataTask {
    var getCalled: Int = 0
    override func resume() {
		getCalled += 1
    }
}

