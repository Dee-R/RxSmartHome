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
    func test_refTo_repoRemote_given_isNotNil() {
        XCTAssertNotNil(sut.repoRemote)
    }
}
