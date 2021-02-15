/// INTERACTOR / UseCase
//  DevicesInteractor.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// // 👁👁🤝
protocol DevicesInteractor { // vm want ...
    func getDevices(completion: @escaping ([Device])->())
}

// ⛔️⛔️
class DevicesInteractorImpl: DevicesInteractor { // I GOT SOMEONE WHO
    let repoRemote: DevicesRepo
    
    init() {
        repoRemote = DevicesRepoImpl()
    }
    func getDevices(completion: @escaping ([Device])->()) {
        
        repoRemote.fetchDevices { (deviceModelObj) in
            guard let deviceObj = deviceModelObj as? DeviceModel else { fatalError() }
            guard let unwDevices = deviceObj.devices else { return }
            completion(unwDevices)
        }
    }
}

