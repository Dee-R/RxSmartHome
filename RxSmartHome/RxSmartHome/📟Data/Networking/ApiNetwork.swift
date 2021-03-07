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
    func fetch(url: String, completion: @escaping(Data?, NSError?) -> Void) {
        let error = NSError(domain: "Api", code: 100, userInfo: nil)
		// URL
        guard let unwURL = URL(string: url) else {
            completion(nil, error)
            return
        }

        session.dataTask(with: unwURL) { (data, _, _) in
            completion(data, nil)
        }.resume()
    }
}
// session
protocol IURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: IURLSession { }
