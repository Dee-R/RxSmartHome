//  REPOSITORY impl
import Foundation

// should be in the Domain Layer
// 👁👁🤝
protocol IDataManagerRepository {
    func getDataDevices(completion: @escaping ([Device]) -> Void)
}

// ⛔️⛔️
class DataManagerRepository: IDataManagerRepository {
    var webDataRepository: IWebDataRepository
    var url: String = "http://storage42.com/modulotest/data.json"
    init() {
        webDataRepository = WebDataRepository()
    }
    /** when called return data from Web repository but saved and fetched from core data */
    func getDataDevices(completion: @escaping ([Device]) -> Void) {
        // TODO: See below
        // get objcModel from web
        webDataRepository.fetch(url: url) { result in
            do {
                let objcDeviceModel = try result.get()
				
            } catch let error as NSError {
                print("██░░░ L\(#line) 🚧🚧 err : \(error), \(error.userInfo) 🚧🚧 ",String(describing: self),#function)
            }
        }
        // parse it
        // save into CoreData
        // fetch from CoreData
        // pass [Device]
		completion( [Device(id: 0, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)] )
    }
    func parseObjcModel(_ deviceModel: DeviceModel) -> [Device] {
        if let deviceArray = deviceModel.devices {
			return deviceArray
        }
        return []
    }
}
