//
//  DevicesInteractorTests.swift
//  RxSmartHomeTests
//
//  Created by Eddy R on 25/02/2021.
//

import XCTest
@testable import RxSmartHome

class DevicesInteractorTests: XCTestCase {
    var sut: DevicesInteractor!
    override func setUp() {
        super.setUp()
        sut =  DevicesInteractor()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_GivenInstance_whenInit_thenReturnNotNil() {
    	XCTAssertNotNil(sut)
    }
    func test_GivenRepo_whenInit_thenRepoNotNil() {
        XCTAssertNotNil(sut.devicesRepository)
    }
    func test_GivenRepo_whenGetDevicesWithSuccess_thenDeviceObj() {
        let exp = expectation(description: "expected : data")
        sut.getDevices { devicesList in
            XCTAssertNotNil(devicesList)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenRepo_whenGetDevices_thenReturnAnEmptyArrayOfDevices() {
        let exp = expectation(description: "expected : should return array of device")
        sut.getDevices { deviceList in
            XCTAssertTrue(deviceList.isEmpty)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenRepoWithFakeData_whengetDevice_thenReturnDataWith1ObjcInside() {
		// given
        let expectedDeviceArray = [Device(id: 2, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: 1)]
		let nextDataToPass = DeviceModel(devices: [Device(id: 2, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: 1)], user: nil)
        let stubDevicesRepo = StubDevicesRepo()
        stubDevicesRepo.nextData = nextDataToPass

        sut.devicesRepository = stubDevicesRepo

        // when call interactor.getDevice => array of device
        let exp = expectation(description: "expected : should return ArrayWith 1 objc")
        sut.getDevices { deviceArrayB in
            // get back deviceArray
            XCTAssertEqual(deviceArrayB, expectedDeviceArray)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
}

class StubDevicesRepo: IDevicesRepo {
    var nextData: DeviceModel?
    func getDataDevices(completion: @escaping (DeviceModel?) -> Void) {
		completion(nextData)
    }
}
