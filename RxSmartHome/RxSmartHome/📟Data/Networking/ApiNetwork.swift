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
		// Session
        session.dataTask(with: unwURL) { [weak self] (data, _, _) in
            guard let this = self else {return}
            guard let unwData = data else { completion(nil, error); return }

            let resultParsing = this.parseData(unwData)
            completion(resultParsing.devicemodel, resultParsing.error)
        }.resume()
    }
    typealias ResultParsed = (devicemodel: DeviceModel?, error:NSError?)
    func parseData(_ data: Data?) -> ResultParsed {
        let error: NSError = NSError(domain: "Api Fetch Parse", code: 101, userInfo: nil)
        guard let unwData = data else { return ResultParsed(nil, error) }

        if let dataDecoded = try? JSONDecoder().decode(DeviceModel.self, from: unwData) {
			return ResultParsed(dataDecoded, nil)
        }
        return ResultParsed(nil, error)
    }
}
// session
protocol IURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: IURLSession { }
