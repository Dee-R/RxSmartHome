//  INTERACTOR / UseCase
//  DevicesInteractor.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// // 👁👁🤝
protocol IDevicesInteractor {
    func getDevices(completion: @escaping ([Device]) -> Void)
}

// ⛔️⛔️
class DevicesInteractor: IDevicesInteractor {
    var dataManagerRepository: IDataManagerRepository
    init() {
        dataManagerRepository = DataManagerRepository()
    }
    func getDevices(completion: @escaping ([Device]) -> Void) {
        dataManagerRepository.getDataDevices { devices in
			completion(devices)
        }
    }
}

// 01 fetch data objc from
// 02 bring back here
// 03 take only the device array
// 04 save it in core data
// 05 fetcj it from core data
// 06 send it back to the sender
