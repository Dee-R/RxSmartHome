/// REPOSITORY <i>
//  DevicesRepo.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// 👁👁🤝
protocol DevicesRepo {
    typealias DevicesData<T> = T
     func fetchDevices(completion :@escaping (DevicesData<Any>)->())
    // delete
    // update
}
