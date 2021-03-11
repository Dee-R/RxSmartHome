//  DevicesRepoTest.swift

import XCTest
@testable import RxSmartHome

class DevicesRepoTests: XCTestCase {
    var sut: DevicesRepo!
    override func setUp() {
        super.setUp()
        sut = DevicesRepo()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_GivenInstance_whenInit_thenInstanceNotNil() {
    	XCTAssertNotNil(sut)
    }
    func test_GivenInstanceOfApi_whenInitDeviceRepo_thenApiNetworkIsNotNil() {
        XCTAssertNotNil(sut.apiNetwork)
    }
    func test_GivenUrlForApiNetworksInstance_whenGetData_thenDataReturnIsNotNil() {
        let apiNetwork = StubApiNetwork()
        apiNetwork.nextData = DeviceModel(devices: nil, user: nil)
        sut.apiNetwork = apiNetwork
        let exp = expectation(description: "expected : data must be not nil")
        sut.getDataDevices { (deviceModelO) in
			XCTAssertNotNil(deviceModelO)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenMockApiFetchData_whenGetDataDevices_thenReturnParticularDataGivenInTheMock() {
		// given
        let stubApiNetwork = StubApiNetwork()
        let expectedData: DeviceModel = DeviceModel(devices: [], user: nil)

        let givenData =  DeviceModel(devices: [], user: nil)
        stubApiNetwork.nextData = givenData

        sut.apiNetwork = stubApiNetwork

        let exp = expectation(description: "expected : must return the same data given in the mockApi")
		// when
        sut.getDataDevices { (deviceModelO) in
			// then
            XCTAssertEqual(deviceModelO, expectedData)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenMockApiFetchData_whenFailToGetDataDevices_thenReturnNil() {
        // given
        let stubApiNetwork = StubApiNetwork()
        stubApiNetwork.nextData = nil
        sut.apiNetwork = stubApiNetwork

        let exp = expectation(description: "expected : must return the same data given in the mockApi")
        // when
        sut.getDataDevices { (deviceModelO) in
            // then
            XCTAssertNil(deviceModelO)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }

}
enum StubError: Error {
    case error1
}
class StubApiNetwork: IApiNetwork {
    var nextData: DeviceModel?
    func fetch(url: String, completion: @escaping (Result<DeviceModel, Error>) -> Void) {
        let deviceModelStub = nextData
        guard let unwdeviceModelStub = deviceModelStub else { completion(.failure(StubError.error1)) ; return }
        completion(.success(unwdeviceModelStub))
    }
}
