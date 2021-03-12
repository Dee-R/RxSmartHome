//  REPOSITORY impl
import Foundation

// ⛔️⛔️
class DevicesRepo: IDevicesRepo {
    var apiNetwork: IApiNetwork
    
    var url: String = "http://storage42.com/modulotest/data.json"
    init() {
        apiNetwork = ApiNetwork()
    }
    func getDataDevices(completion: @escaping (DeviceModel?) -> Void) {
        apiNetwork.fetch(url: url) { (result) in
            do {
                let deviceModelObjc = try result.get()
                completion(deviceModelObjc)
            } catch {
                completion(nil)
            }
        }
    }
}
