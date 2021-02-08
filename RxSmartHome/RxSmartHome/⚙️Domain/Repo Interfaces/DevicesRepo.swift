/// REPOSITORY <i>
//  DevicesRepo.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// 👁👁🤝
protocol DevicesRepo {
    typealias DataDevices<T> = Array<T>
    
    func fetchDevices(completion: (DataDevices<Any>)->())
    // delete
    // update
}
