//
//  AppDIBuilder.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

import Foundation

class AppDIBuilder {
    static let shared = AppDIBuilder(appEnvironment: AppEnvironment())
    let appEnvironment: AppEnvironment
    
    init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
//    func buildDevicesDI() -> DevicesViewModelImpl{
//        return DevicesViewModelImpl()
//    }
}
