//  ApiNetworkTests.swift

import XCTest
@testable import RxSmartHome

class ApiNetworkTests: XCTestCase {
    var sut: ApiNetwork!
    var mockURLSession: MockURLSession!
    var mockURLSessionDataTask: MockURLSessionDataTask!
    var urlGood = "http://storage42.com/modulotest/data.json"
    var urlBad = ""
    override func setUp() {
        super.setUp()
        sut = ApiNetwork()
        mockURLSession = MockURLSession()
        mockURLSessionDataTask = MockURLSessionDataTask()
    }
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    // instance
    // Url
    func test_GivenInstance_whenInit_thenInstanceNotNil() {
    	XCTAssertNotNil(sut)
    }
    func test_GivenGoodUrl_whenFetch_thenExpectDeviceModelIsNotNil() {
		// A
        mockURLSession.nextDataTask = mockURLSessionDataTask // dataTask
        mockURLSession.nextData = "{}".data(using: .utf8)
        sut.session = mockURLSession // sets Session

        // M
        let exp = expectation(description: "expected : deviceModel should be not nil")
        sut.fetch(url: urlGood) { (result) in
            // B???
            do {
                let objc = try result.get()
                XCTAssertNotNil(objc)
                exp.fulfill()
            } catch { XCTFail("should not fail") }
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenBadUrl_whenFetch_thenExpectErrorUrl() {
		let exp = expectation(description: "must return an error of url")
        sut.fetch(url: urlBad) { (result) in
            do {
                _ = try result.get()
				XCTFail("Must not succeed")
            } catch let error {
                if case ApiNetworkError.url = error {
                    exp.fulfill()
                } else {
                    XCTFail("dit not thrown the right error")
                }
            }
        }
        wait(for: [exp], timeout: 0.05)
    }
	// Session
    func test_GivenSession_whenFetch_thenSessionGetsCall() {
        // session mock used
        sut.session = mockURLSession
        sut.fetch(url: urlGood, completion: { _ in })
        XCTAssertEqual(mockURLSession.getCalled, 1)
    }
    func test_GivenSession_whenFetch_thenResumeGetsCall() {
		// sets
        mockURLSession.nextDataTask = mockURLSessionDataTask
        sut.session = mockURLSession
		// when
        sut.fetch(url: urlGood, completion: { _ in })
		// then
        XCTAssertEqual(mockURLSessionDataTask.getCalled, 1)
    }
    // Parsing
    func test_GivenSpecificData_whenParse_thenGetSameData() {
		// dataParsed
        let brutData =
"""
{
"devices": []
}
""".data(using: .utf8)
        let dataParsed = sut.parse(brutData)

        // dataExpected
        let dataExpected = DeviceModel(devices: [], user: nil)
        // DeviceModel(devices: Optional([]), user: nil)
        XCTAssertEqual(dataParsed, dataExpected)
    }
    func test_GivenSpecificData_whenParse_thenGetSameData2() {
        // dataParsed
        let brutData =
            """
{
"devices":
	[
		{
			"id": 1,
        	"deviceName": "Lampe - Cuisine",
        	"intensity": 50,
        	"mode": "ON",
        	"productType": "Light"
		}
	]
}
""".data(using: .utf8)
        let dataParsed = sut.parse(brutData)

        // dataExpected
        let dataExpected = DeviceModel(
            devices: [
                Device(
                    id: 1,
                    deviceName: "Lampe - Cuisine",
                    productType: .light,
                    intensity: 50, mode: "ON",
                    position: nil,
                    temperature: nil)],
            user: nil)
        // DeviceModel(devices: Optional([]), user: nil)
        XCTAssertEqual(dataParsed, dataExpected)
    }
    func test_GivenSpecificData_whenErrorOfParsing_thenGetNil() {
        let parse = "{AZER}".data(using: .utf8)
        let parseIsNil = sut.parse(parse)
        XCTAssertNil(parseIsNil)
    }

    func test_GivenMockSessionAndMockData_whenFetchWithSuccess_thenReturnSameData() {
		// sets
        mockURLSession.nextDataTask = mockURLSessionDataTask
        mockURLSession.nextData =   """
{
"devices":
    [
        {
            "id": 1,
            "deviceName": "Lampe - Cuisine",
            "intensity": 50,
            "mode": "ON",
            "productType": "Light"
        }
    ]
}
""".data(using: .utf8)

        sut.session = mockURLSession
        let expectedObjc: DeviceModel = DeviceModel(
            devices: [
                Device(id: 1, deviceName: "Lampe - Cuisine", productType: .light, intensity: 50, mode: "ON", position: nil, temperature: nil)
            ], user: nil) // device model expected
        // when
        let exp = expectation(description: "expected : return back same data")
        sut.fetch(url: urlGood) { (result) in
            // B???
            do {
                let objc = try result.get()
                XCTAssertEqual(objc, expectedObjc)
                exp.fulfill()
            } catch {
                XCTFail("should not have failed")
            }
        }
        wait(for: [exp], timeout: 0.05)
    }

}
class MockURLSession: IURLSession {
    var getCalled: Int = 0
    var nextDataTask: MockURLSessionDataTask
    var nextData: Data?
    init() {
        nextDataTask = MockURLSessionDataTask()
    }
    func dataTaskCustom(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> IURLSessionDataTask {
		completionHandler(nextData, nil, nil)
        getCalled += 1
        return nextDataTask
    }

}
class MockURLSessionDataTask: URLSessionDataTask {
    var getCalled: Int = 0
    override func resume() {
        getCalled += 1
    }
}
