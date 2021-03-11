// ApiNetwork
import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {
    func fetch(url: String, completion: @escaping(Result<DeviceModel, Error>) -> Void)
}

// ⛔️⛔️ Engine
class ApiNetwork: NSObject, IApiNetwork {
    var session: IURLSession
    var dataTask: IURLSessionDataTask?
    override init() {
        session = URLSession.shared
        //        dataTask = URLSessionDataTask()
    }
    func fetch(url: String, completion: @escaping(Result<DeviceModel, Error>) -> Void) {
        guard let unwUrl = URL(string: url) else { completion(.failure(ApiNetworkError.url));return }
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
extension URLSessionDataTask: IURLSessionDataTask {}
