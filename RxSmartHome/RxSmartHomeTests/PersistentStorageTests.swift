//
//  PersistentStorageTests.swift
//  RxSmartHomeTests
//
//  Created by Eddy R on 12/03/2021.
import XCTest
import CoreData
import UIKit

@testable import RxSmartHome

class PersistentStorageTests: XCTestCase {
    var sut: PersistentStorage!
    override func setUp() {
        super.setUp()
        sut = PersistentStorage()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_GivenInstance_whenInit_thenInstanceNotNil() {
    	XCTAssertNotNil(sut)
    }
}

/*
NSManaged
 ObjectModel : permet de definir le shema
 ObjectContext
 Object
NSPersistent
 StoreCoordinator
 StoreCoordinator

Fichier
 DataModel.xcdatamodeld
 DataModel.momd
 dataModel.sqlite



 */
