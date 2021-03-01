//
//  DevicesRepoTest.swift
//  RxSmartHomeTests
//
//  Created by Eddy R on 15/02/2021.
//

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


}
