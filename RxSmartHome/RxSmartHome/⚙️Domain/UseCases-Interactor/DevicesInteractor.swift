//  INTERACTOR / UseCase
//  DevicesInteractor.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// // 👁👁🤝
protocol IDevicesInteractor { // vm want ...
    func getDevices(completion: @escaping ([Device]) -> Void)
}

// ⛔️⛔️
class DevicesInteractor: IDevicesInteractor {
	// I GOT SOMEONE WHO
//    let repoRemote: IDevicesRepo?
    let devicesRepository: IDevicesRepo?
    init() {
        devicesRepository = DevicesRepo()
    }
    func getDevices(completion: @escaping ([Device]) -> Void) {
//        devicesRepository?.getData(completion: { (_) in
//        })
    }
}
