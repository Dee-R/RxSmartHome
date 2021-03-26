//  LocalDataRepositoryTests.swift

import XCTest
import CoreData

@testable import RxSmartHome

class LocalDataRepositoryTests: XCTestCase {
    var sut: LocalDataRepository!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        super.setUp()
		coreDataStack = CoreDataStack()
        sut = LocalDataRepository(managedObjectContext: coreDataStack.viewContextCD, coreDataStack: coreDataStack)
    }
    override func tearDown() {
		coreDataStack = nil
        sut = nil
        super.tearDown()
    }
    // add
    func test_whenAddDevice_thenGetDevice() {
        sut.deleteDevices()
        let objc: DeviceCD? = sut.addDevice(id: 1)
        XCTAssertNotNil(objc, "should not be nil")
        XCTAssertEqual(objc?.id, 1)
    }
    // root to context
    func test_whenRootContext_IsSaved_AfterAddingDevice() {
        // create secondary context
        let secondaryContext = coreDataStack.newViewContext()
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.viewContextCD) { (_) -> Bool in
            return true
        }
        secondaryContext.perform {
            let device = self.sut.addDevice(id: 3)
            XCTAssertNotNil(device)
        }
        waitForExpectations(timeout: 0.05) { (error) in
            XCTAssertNil(error, "save did not occur")
        }

    }
	// get
    func test_GivenContext_whenDeleteAll_thenEmptyArray() {
        _ = sut.addDevice(id: 9)
        _ = sut.addDevice(id: 10)
//        sut.deleteDevices() // delete all
        sut.deleteDevicesBatch() // delete all
        let devices = sut.getDevices()
        XCTAssertTrue(devices!.isEmpty)
    }
    func test_GivenTwoObject_whenDeleteOneObject_thenGetOneObjec() {
        let nine = sut.addDevice(id: 9)
        let ten = sut.addDevice(id: 10)
        sut.deleteDevice(nine!)
        let actual = sut.getDevices()
        XCTAssertEqual(actual, [ten!])
    }
}
