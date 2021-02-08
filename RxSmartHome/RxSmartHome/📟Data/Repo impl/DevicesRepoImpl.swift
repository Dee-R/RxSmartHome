/// REPOSITORY impl
//  DevicesRepoImpl.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// ⛔️⛔️
class DevicesRepoImpl: DevicesRepo {
    // repoLocal
    let apiNetwork: DevicesRepo =  ApiNetworkImpl()
    //let dataSourceRemote: DevicesRepo = DevicesRepo()
    
    init() { print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ") }
    func fetchDevices(completion: (DataDevices<Any>) -> ()) {
        // renvoie à l interation
        let data: DataDevices<Int> = [1,2,3]
        apiNetwork.fetchDevices { (dataOfNetwork) in
            completion(dataOfNetwork)
        }
    }
}








