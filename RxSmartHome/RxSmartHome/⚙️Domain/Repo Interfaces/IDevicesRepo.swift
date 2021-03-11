// REPOSITORY <i>
//  IDevicesRepo.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// 👁👁🤝
protocol IDevicesRepo {
    func getDataDevices(completion: @escaping (DeviceModel?) -> Void)
}
