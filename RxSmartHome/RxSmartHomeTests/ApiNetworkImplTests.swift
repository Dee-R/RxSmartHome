//  ApiNetworkImplTests.swift
//  RxSmartHomeTests
//  Created by Eddy R on 09/02/2021.

import XCTest

class ApiNetworkImplTests: XCTestCase {
    var sut: MockApiNetwork!
    override func setUp() {
        super.setUp()
        sut = MockApiNetwork()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_api_fetch_device_givenSuccessReponse() {
        sut.shouldReturnError = false
        helperfetch(msg: "success response expectation") { data, response in
            XCTAssertEqual(response, "success to fetch")
        }
    }
    func test_api_fetch_device_givenErrorResponse() {
        sut.shouldReturnError = true
        helperfetch(msg: "success response expectation") { data, response in
            XCTAssertEqual(response, "error to fetch")
        }
    }
    func test_api_fetch_device_givenDeviceObj() {
        helperfetch(msg: "get device objc") { (data, response) in
            guard (data != nil) else { assertionFailure(); return}
        }
    }
    func test_api_fetch_device_givenNoDeviceObj() {
        sut.shouldReturnError = true
        helperfetch(msg: "get device objc") { (data, response) in
            guard (data != nil) else { XCTAssert(true); return}
        }
    }
    func test_api_fetch_device_givenNil() {
        _ = sut.shouldReturnError = true
        helperfetch(msg: "return nil") { (device, response) in
            XCTAssertTrue(device == nil)
        }
    }
    func test_api_fetch_device_givenDeviceObjWithArrayOfDevice() {
        helperfetch(msg: "getArrayOfDevices") { (deviceObjc, response) in
            guard let unwDeviceObjc = deviceObjc else { fatalError("unwDeviceObjc : nil") }
            if unwDeviceObjc.devices != DeviceModel(devices: [Device(id: nil, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil).devices {
                assertionFailure()
            }
        }
    }
    
    // helper
    func helperfetch(msg:String = "", completion : (DeviceModel? ,String)->()) {
        let exp = expectation(description: "msg expectation")
        sut.fetch() { data,response in
            completion(data, response ?? "")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    
    
    class MockApiNetwork {
        var shouldReturnError = false
        var responseFetch:String {
            if !shouldReturnError {
                return "success to fetch"
            } else {
                return "error to fetch"
            }
        }
        var dataFetch:DeviceModel? {
            if !shouldReturnError {
                let device = Device(id: nil, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
                return DeviceModel(devices: [device], user: nil)
            } else {
                return nil
            }
        }
        
        func fetch(completion:(DeviceModel?, String?)->Void) {
            completion(dataFetch, responseFetch)
        }
    }
}













var jsonData =
    """
{
    "devices": [
    {
    "id": 1,
    "deviceName": "Lampe - Cuisine",
    "intensity": 50,
    "mode": "ON",
    "productType": "Light"
    }
    ],
    "user": {
        "firstName": "John",
        "lastName": "Doe",
        "address": {
            "city": "Issy-les-Moulineaux",
            "postalCode": 92130,
            "street": "rue Michelet",
            "streetCode": "2B",
            "country": "France"
        },
        "birthDate": 813766371000
    }
}
"""

