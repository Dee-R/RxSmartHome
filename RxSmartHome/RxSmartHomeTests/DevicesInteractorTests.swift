// Interactor

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
        XCTAssertNotNil(sut.dataManagerRepository)
    }

    // 01 : stub
    func test_GivenDataM_whenGetDevicesWithSuccess_thenGetArrayOfDeviceWithOneDevice() {
        // given
        let stubDataManagerRepository = StubDataManagerRepository() // stub
        stubDataManagerRepository.nextData = [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)]
        sut.dataManagerRepository = stubDataManagerRepository


		// when
        let exp = expectation(description: "expected : devices array")
        // INTERACTOR
        sut.getDevices { devicesList in
            // then
            XCTAssertNotNil(devicesList)
            XCTAssertEqual(devicesList, [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenDataM_whenGetDevicesWithSuccess_thenGetArrayOfDeviceWithTwoDevices() {
        // given
        let stubDataManagerRepository = StubDataManagerRepository() // stub
        stubDataManagerRepository.nextData = [
            Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil),
            Device(id: 1, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
        ]
        sut.dataManagerRepository = stubDataManagerRepository


        // when
        let exp = expectation(description: "expected : devices array")
        // INTERACTOR
        sut.getDevices { devicesList in
            // then
            XCTAssertNotNil(devicesList)
            let expectedArrayOfdevice = [
                Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil),
            	Device(id: 1, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
            ]
            XCTAssertEqual(devicesList, expectedArrayOfdevice)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
    func test_GivenDataM_whenGetDevicesWithAProblem_thenGetAnEmptyArray() {
		// given
        let stubDataManagerRepository: StubDataManagerRepository = StubDataManagerRepository()
        stubDataManagerRepository.nextData = nil
        sut.dataManagerRepository = stubDataManagerRepository

        // when
        let exp = expectation(description: "expected: empty array of device")
        sut.getDevices { (deviceArray) in
            // then
            XCTAssertTrue(deviceArray.isEmpty)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.05)
    }
}

/*
 Interactor
 getDevice -> [Device]
 DateManagor
 getDevice ( fetch Web + save and fetch CoreData) -> [Device]
 webRepo
 fetchDevice -> ObjcDevice
 localRepo
 saveDevice -> Void
 FetchDevice -> Device
 */
