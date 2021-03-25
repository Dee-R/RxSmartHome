//  StubDataManagerRepository.swift

import Foundation
@testable import RxSmartHome

class StubDataManagerRepository: IDataManagerRepository {
    var nextData: [Device]?
    func getDataDevices(completion: @escaping ([Device]) -> Void) {
        if let unwNextData = nextData {
            completion(unwNextData)
        } else {
            completion([])
        }
    }
}
