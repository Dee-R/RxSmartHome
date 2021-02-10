/// REPOSITORY impl
//  DevicesRepoImpl.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// ⛔️⛔️
class DevicesRepoImpl: DevicesRepo {
    // repoLocal
//    let apiNetwork: ApiNetwork =  ApiNetworkImpl()
    //let dataSourceRemote: DevicesRepo = DevicesRepo()
    init() { print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ") }
    func fetchDevices(completion: @escaping (DevicesData<Any>) -> ()) {
        
//        self.apiNetwork.fetchDevice { (deviceModelObj) in
//            completion(deviceModelObj)
//        }
        
    }
}








