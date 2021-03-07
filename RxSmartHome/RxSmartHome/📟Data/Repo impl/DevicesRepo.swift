//  REPOSITORY impl
//  DevicesRepoImpl.swift
//  Created by Eddy R on 08/02/2021.
import Foundation

// ⛔️⛔️
class DevicesRepo: IDevicesRepo {
    var apiNetwork: IApiNetwork?
    var urlString: String? = "--"

    init() {
//        apiNetwork = ApiNetwork()
    }
    func fetchData(completion: @escaping(Data?, NSError?) -> Void) {
//        apiNetwork?.fetchFromURL(urlString: urlString, success: { (data) in
//            completion(data, nil)
//        }, failure: { _ in
//            completion(nil, NSError())
//        })
    }
}
