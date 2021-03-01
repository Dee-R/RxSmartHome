// ApiNetwork

import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {
    func fetchFromURL(urlString: String?, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void)
}

// ⛔️⛔️ Engine
class ApiNetwork: NSObject, IApiNetwork {
    var session: IURLSession?
    var dataTask: URLSessionDataTask?
    override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    func fetchFromURL(urlString: String?, success:@escaping (Data) -> Void, failure:@escaping (NSError) -> Void) {
        guard let unwUrlString = urlString, let unwUrl = URL(string: unwUrlString) else { failure(NSError(domain: "ApiNetwork", code: 101, userInfo: nil)) ; return}
        guard let unwSession = session else { failure(NSError(domain: "ApiNetwork", code: 100, userInfo: nil)); return }

        self.dataTask = unwSession.dataTask(with: unwUrl) { (data, response, _) in
            if let response = response as? HTTPURLResponse, let data = data {
                if response.statusCode == 200 {
                    success(data)
                    return
                }
            }

        }

        dataTask?.resume()
    }
}

protocol IURLSession: class {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: IURLSession { }
