/// REPOSITORY impl
//  DevicesRepoImpl.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// ⛔️⛔️
class DevicesRepo: IDevicesRepo {
    let apiNetwork : IApiNetwork? = nil
    
    init() {
//        apiNetwork = ApiNetwork()
    }
    
    func fetchDevices(completion: @escaping (DevicesData<Any>) -> ()) {
        //renvoyer Devices by call api
//        try? api.fetch { (string, error) in }
    }
}








