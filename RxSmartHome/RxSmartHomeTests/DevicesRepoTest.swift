//
//  DevicesRepoTest.swift
//  RxSmartHomeTests
//
//  Created by Eddy R on 15/02/2021.
//

import XCTest
@testable import RxSmartHome

class DevicesRepoTest: XCTestCase {
    var sut: SpyDeviceRepo!
    override func setUp() {
        super.setUp()
        sut = SpyDeviceRepo(api: ApiNetwork())
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_repo_getBack_DataFromApi_givenDeviceObjc() {
        
        sut.repoApiNetwok.fetch { (device, response) in
            
        }
    }
    
    class SpyDeviceRepo {
        var repoApiNetwok: IApiNetwork
        typealias DevicesData<T> = T
        init(api: IApiNetwork) {
            self.repoApiNetwok = api
        }
        func fetchDevices( completion: @escaping (DevicesData<Any>)->() ) {
            
        }
        
    }
}


