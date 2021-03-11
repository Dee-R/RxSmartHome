// ApiNetwork
import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {}

// ⛔️⛔️ Engine
class ApiNetwork: NSObject {
    var session: IURLSession
    var dataTask: IURLSessionDataTask?
    override init() {
        session = URLSession.shared
        dataTask = URLSessionDataTask()
    }
    func fetch(url: String, completion: @escaping(Result<DeviceModel, Error>) -> Void) {
        guard let unwUrl = URL(string: url) else { completion(.failure(ApiNetworkError.url));return }
//        let objcDeviceModel = DeviceModel(devices: [Device(id: 1, deviceName: "", productType: .heater, intensity: 10, mode: "", position: 1, temperature: 1)], user: nil)

        // session
        dataTask = session.dataTaskCustom(with: unwUrl) {[weak self] (data, _, _) in
            guard let this = self else {return} // this
            let data: DeviceModel? = this.parse(data) // parse data
            guard let unwDeviceModel = data else { return } // unwrap it
            completion(.success(unwDeviceModel)) // send it back with success
        }
        dataTask?.resume()
    }
    func parse(_ data: Data?) -> DeviceModel? {
        guard let unwData = data else { return nil }
        let dataParsed = try? JSONDecoder().decode(DeviceModel.self, from: unwData)
        return dataParsed
    }
}
enum ApiNetworkError: Error {
	case url
    case parse
}
protocol IURLSession {
    func dataTaskCustom(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> IURLSessionDataTask
}
extension URLSession: IURLSession {
    func dataTaskCustom(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> IURLSessionDataTask {
		dataTask(with: url, completionHandler: completionHandler) as IURLSessionDataTask
    }
}

protocol IURLSessionDataTask {
	func resume()
}
extension URLSessionDataTask: IURLSessionDataTask {

}

/*
 class ApiNetwork: NSObject, IApiNetwork {
 typealias ResultParsed = (devicemodel: DeviceModel?, error: NSError?)
 var session: IURLSession
 var dataTask: URLSessionDataTask?

 override init() {
 session = URLSession.shared
 //        dataTask = URLSessionDataTask()
 }
 func fetch(url: String, completion: @escaping(Result<DeviceModel, Error>) -> Void) {
 guard let unwURL = URL(string: url) else { completion(.failure(ApiNetworkError.url));return }
 session.dataTask(with: unwURL) { (data, _, _) in
 completion(.success(DeviceModel(devices: [Device(id: 1, deviceName: nil, productType: nil, intensity: nil, mode: nil, position: nil, temperature: nil)], user: nil)))
 }.resume()
 }
 }
 enum ApiNetworkError: Error {
 case url
 }
 protocol IURLSession {
 func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
 }
 extension URLSession: IURLSession {}
 */
