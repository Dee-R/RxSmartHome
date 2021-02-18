/// DevicesRepoImpl
//  DevicesRepo.swift
//  RxSmartHome
//  Created by Eddy R on 08/02/2021.

import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {
    func fetch(completion: @escaping (DeviceModel?, String?)->Void)
}

// ⛔️⛔️ Engine
class ApiNetwork: IApiNetwork {
    func fetch(completion: @escaping (DeviceModel?, String?) -> Void) {
        // // TODO: integration
        completion(nil,nil)
    }
}
