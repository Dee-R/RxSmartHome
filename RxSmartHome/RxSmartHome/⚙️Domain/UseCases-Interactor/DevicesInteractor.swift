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
    var devicesRepository: IDevicesRepo
    init() {
        devicesRepository = DevicesRepo()
    }
    func getDevices(completion: @escaping ([Device]) -> Void) {
        devicesRepository.getDataDevices { (deviceModelObjc) in
            if let deviceArray = deviceModelObjc?.devices {
                completion(deviceArray)
            } else {
				completion([])
            }
        }
    }
}
