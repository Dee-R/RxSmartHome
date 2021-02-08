/// INTERACTOR / UseCase
//  DevicesInteractor.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// // 👁👁🤝
protocol DevicesInteractor { // IWANT someone who
    func getDevices(completion:([Int])->())
}

// ⛔️⛔️
class DevicesInteractorImpl: DevicesInteractor { // I GOT SOMEONE WHO
    let repoRemote: DevicesRepo
    
    init() {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        repoRemote = DevicesRepoImpl()
    }
    func getDevices(completion: ([Int])->()) {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // FIXME: Need implementation of Remote or Local Service
        repoRemote.fetchDevices { (dataArray) in
            let data = dataArray as! Array<Int>
            completion(data)
        }
    }
}

