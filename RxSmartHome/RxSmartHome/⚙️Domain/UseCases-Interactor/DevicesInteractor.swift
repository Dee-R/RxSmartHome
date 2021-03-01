//  INTERACTOR / UseCase
//  DevicesInteractor.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// // 👁👁🤝
protocol IDevicesInteractor { // vm want ...
    func getDevices(completion: @escaping ([Device]) -> Void)
}

// ⛔️⛔️
class DevicesInteractor: IDevicesInteractor { // I GOT SOMEONE WHO
    let repoRemote: IDevicesRepo

    init() {
        repoRemote = DevicesRepo()
    }
    func getDevices(completion: @escaping ([Device]) -> Void) {
        repoRemote.fetchData { _, _ in
        }
    }
}
