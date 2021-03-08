// ApiNetwork
import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {
//    func fetchFromURL(urlString: String?, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void)
}

// ⛔️⛔️ Engine
class ApiNetwork: NSObject {
    var session: IURLSession
    override init() {
        session = URLSession.shared
    }
    func fetch(url: String, completion: @escaping(DeviceModel?, NSError?) -> Void) {
        let error = NSError(domain: "Api", code: 100, userInfo: nil)
		// URL
        guard let unwURL = URL(string: url) else { completion(nil, error); return }
		// session
        session.dataTask(with: unwURL) { [weak self] (data, _, _) in
            guard let this = self else {return}
            guard let unwDataB = data else { completion(nil, error); return }

            // parse json
            let parsedJson: DeviceModel? = this.parseData(unwDataB)
            completion(parsedJson, nil)
        }.resume()
    }
    func parseData(_ data: Data?) -> DeviceModel? {
        guard let unwData = data else { return nil }
        let data: DeviceModel? = try? JSONDecoder().decode(DeviceModel.self, from: unwData)
        return data
    }
}
// session
protocol IURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: IURLSession { }
