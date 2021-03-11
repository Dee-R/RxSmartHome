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
//    func test_GivenInstance_whenInit_thenInstanceNotNil() {
//    	XCTAssertNotNil(sut)
//    }
//    func test_GivenInstanceOfApi_whenInitDeviceRepo_thenApiNetworkIsNotNil() {
//        XCTAssertNotNil(sut.apiNetwork)
//    }
//    func test_GivenUrlForApiNetworksInstance_whenGetData_thenDataReturnIsNotNil() {
//        var deviceObjc: DeviceModel?
//
//        let stupApi: StubApiNetwork = StubApiNetwork()
//        stupApi.nextData = DeviceModel(devices: [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil)
//        sut.apiNetwork = stupApi
//
//        let exp = expectation(description: "expected : DeviceObjc not nil")
//        sut.getData { deviceObjcB in
//			deviceObjc = deviceObjcB
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 0.05)
//		XCTAssertNotNil(deviceObjc)
//    }
//    func test_GivenApiNetworkInstance_whenGetData_thenClosureReturnDataFromApiNetwork() {
//        var dataDeviceObjc: DeviceModel?
//
//        let stupApi: StubApiNetwork = StubApiNetwork()
//        stupApi.nextData = DeviceModel(devices: [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil)
//        sut.apiNetwork = stupApi
//
//        let exp = expectation(description: "expected : get back data from api")
//        sut.getData { (dataDeviceObjcB) in
//			dataDeviceObjc = dataDeviceObjcB
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 0.05)
//
//        XCTAssertNotNil(dataDeviceObjc)
//    }
//    func test_GivenApiNetwokr_whenGetData_thenDevice2() {
//		// doit set data in stub api
//        let stupApi: StubApiNetwork = StubApiNetwork()
//        stupApi.nextData = DeviceModel(devices: [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil)
//        sut.apiNetwork = stupApi
//
//        var dataFromApi: DeviceModel?
//        let exp = expectation(description: "expected : data is not nil from api")
//        sut.getData { (data) in
//			dataFromApi = data
//            // test the validity of this data from api
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 0.05)
//        XCTAssertEqual(dataFromApi, DeviceModel(devices: [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil))
//    }
}
//class StubApiNetwork: IApiNetwork {
//    var nextData: DeviceModel?
//    func fetch(url: String, completion: @escaping (DeviceModel?, NSError?) -> Void) {
//		let deviceModelStub = nextData
//        completion(deviceModelStub, nil)
//    }
//}
