//  REPOSITORY impl
import Foundation

// ⛔️⛔️
class DevicesRepo: IDevicesRepo {
    var apiNetwork: IApiNetwork?
    var url: String = "1234"
    init() {
//        apiNetwork = ApiNetwork()
    }
    func getData(completion: @escaping (DeviceModel?) -> Void) {
		// data From api missing
//        apiNetwork?.fetch(url: url, completion: { (deviceModelB, errorB) in
//            if errorB == nil {
//                completion(deviceModelB)
//            } else {
//                completion(nil)
//            }
//        })
    }
}
