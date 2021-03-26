//  DevicesRepoTest.swift
// dummy : object passed but never used
// Fake : work on implementation but not suitable for production code

import XCTest
@testable import RxSmartHome

class DataManagerRepositoryTests: XCTestCase {
    var objcDevice01 = Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
    var sut: DataManagerRepository!
    override func setUp() {
        super.setUp()
        sut = DataManagerRepository()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_GivenInstance_whenInit_thenInstanceNotNil() {
    	XCTAssertNotNil(sut)
    }
	// DataM return -> [Device]
    func test_whenGetDataDevicesWithSuccess_thenGetArrayOfDevices() {
        let exp = expectation(description: "expected : array of device")
        sut.getDataDevices {[weak self] (deviceArray) in
            XCTAssertEqual(deviceArray, [self?.objcDevice01])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }

    // Call webRepo
    func test_GivenWebDataRepo_whenFetchWithUrlWithSuccess_thenGetDataNotNil() {
        sut.webDataRepository = MockWebDataRepository()
        let exp = expectation(description: "expected : data not nil")
        sut.webDataRepository.fetch(url: "test") { result in
            let objc = try? result.get()
            XCTAssertNotNil(objc)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenWebDataRepo_whenFetchWithUrlWithSuccess_thenGetError() {
        let mockWeb: MockWebDataRepository = MockWebDataRepository()
        mockWeb.isSuccess = false
        sut.webDataRepository = mockWeb
        let exp = expectation(description: "expected : data not nil")
        sut.webDataRepository.fetch(url: "test") { result in
            do {
                _ = try result.get()
                XCTFail("should not succed")
            } catch let error as NSError {
                XCTAssertNotNil(error)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 0.05)
    }

    // parsing
    func test_GivenObjectModel_whenParseObjcModel_thenGetArrayOfDevice() {
        let objcDevice01 = Device(id: 0, deviceName: "Light", productType: .heater, intensity: nil, mode: nil, position: nil, temperature: nil)
    	let objcDeviceModel = DeviceModel(devices: [objcDevice01], user: nil)
        let actual = sut.parseObjcModel(objcDeviceModel)
        let expected = [Device(id: 0, deviceName: "Light", productType: .heater, intensity: nil, mode: nil, position: nil, temperature: nil)]
        XCTAssertEqual(actual, expected)
    }
    func test_GivenObjectModelNil_whenParseObjcModel_thenGetEmptyArray() {
        let objcDeviceModel: DeviceModel = DeviceModel(devices: nil, user: nil)
        let actual = sut.parseObjcModel(objcDeviceModel)
        XCTAssertEqual(actual, [])
    }
    func test_GivenObjectModelEmpty_whenParseObjcModel_thenGetEmptyArray() {
        let objcDeviceModel: DeviceModel = DeviceModel(devices: [], user: nil)
        let actual = sut.parseObjcModel(objcDeviceModel)
        XCTAssertEqual(actual, [])
    }
}

class MockWebDataRepository: IWebDataRepository {
    var isSuccess = true
    func fetch(url: String, completion: @escaping (Result<DeviceModel, Error>) -> Void) {
        if isSuccess {
            completion(.success(DeviceModel(devices: nil, user: nil)))
        } else {
            completion(.failure(ApiNetworkError.fetching))
        }
    }
}
