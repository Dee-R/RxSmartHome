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
    func test_whenAddDevice_thenGetDevice() {
        let objc: DeviceCD? = sut.addDevice(id: 1)
        XCTAssertNotNil(objc, "should not be nil")
        XCTAssertEqual(objc?.id, 1)
    }
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
}
