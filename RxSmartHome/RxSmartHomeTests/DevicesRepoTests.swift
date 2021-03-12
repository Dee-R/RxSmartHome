//  DevicesRepoTest.swift
// dummy : object passed but never used
// Fake : work on implementation but not suitable for production code
// stubs


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

    // ApiNetwork
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

    // coreData
    func test_GivenRepo_whenAddDevice_thenGetId() {
    	let fakeRepoCoreData = FakeRepoCoreData()
        let deviceObjc = Device(id: nil, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
        let idObjc = fakeRepoCoreData.addDevice(device: deviceObjc)
        let exist = fakeRepoCoreData.deviceExist(id: idObjc)
        XCTAssertTrue(exist)
    }
    func test_GivenDevice_whenRetrieveDeviceByID_thenGetDevice() {
        let fakeRepoCoreData = FakeRepoCoreData()
        let deviceObjc = Device(id: nil, deviceName: "Light", productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)
        let idObjc = fakeRepoCoreData.addDevice(device: deviceObjc)

        // when
        guard let device = fakeRepoCoreData.retrieveDevice(id: idObjc) else { return }
        XCTAssertEqual(device.deviceName, "Light")
    }
    func test_GivenDevice_whendeleteWithId_thenDataDoesntExistAnyMore() {
        let fakeRepo = FakeRepoCoreData()
        _ = fakeRepo.addDevice(device: Device(id: 1, deviceName: "Light", productType: .none, intensity: nil, mode: nil, position: nil, temperature: nil))
        _ = fakeRepo.addDevice(device: Device(id: 2, deviceName: "roller", productType: .none, intensity: nil, mode: nil, position: nil, temperature: nil))
        fakeRepo.deleteDevice(id: 2)
        XCTAssertFalse(fakeRepo.deviceExist(id: 2))
    }
    func test_GivenDevice_whenUpdate_thenReturnDeviceName() {
        let fakerepo: FakeRepoCoreData = FakeRepoCoreData()
        // add device
        _ = fakerepo.addDevice(device: Device(id: 1, deviceName: "device1", productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil))

        // retrieve device
        var device = fakerepo.retrieveDevice(id: 1)

        // change device
        device?.deviceName = "Light"
        // update device
        fakerepo.updateDevice(id: 1, device: device!)
        // test
        XCTAssertEqual(fakerepo.retrieveDevice(id: 1)?.deviceName, "Light")
    }
    func test_GivenDevice_whenRetrieveAll_thenGetDictionnary() {
		// instance
        let fakerepo: FakeRepoCoreData = FakeRepoCoreData()
        // add device
        _ = fakerepo.addDevice(device: Device(id: 1, deviceName: "device1", productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil))
        _ = fakerepo.addDevice(device: Device(id: 3, deviceName: "device3", productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil))
		// retrieveAll
        let alldata = fakerepo.retrieveAllDevice()
        XCTAssertNotNil(alldata)
        XCTAssertEqual(alldata[1]?.deviceName, "device1")
    }
}


// FakeRepoCoreData
class FakeRepoCoreData {
    var database: [Int: Device] =  [:]

    func addDevice(device: Device) -> Int {
        let id = database.count + 1
		database[id] = device
        return id
    }
    func retrieveDevice(id: Int) -> Device? {
        if let objc = database[id] {
            return objc
        } else {
            return nil
        }
    }
    func deleteDevice(id: Int) {
        if deviceExist(id: id) {
            database[id] = nil
        }
    }
    func updateDevice(id: Int, device: Device) {
        if deviceExist(id: id) {
            database[id] = device
        }
    }
    func retrieveAllDevice() -> [Int: Device] {
        if !(database.isEmpty) {
			return database
        } else {
            return [:]
        }
    }

    func deviceExist(id: Int) -> Bool {
        return database.contains { (key: Int, _: Device) -> Bool in
            return key == id
        }
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
