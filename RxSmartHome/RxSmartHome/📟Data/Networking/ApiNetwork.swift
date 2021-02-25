/// ApiNetwork

import Foundation

// 👁👁🤝 Proper protocol
protocol IApiNetwork {
    //    func fetch(completion: @escaping (DeviceModel?, String?)->Void)
}

// ⛔️⛔️ Engine
class ApiNetwork: NSObject {
    var session: IURLSession?
    var dataTask: URLSessionDataTask?
    
    override init() {
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func fetchFromURL(urlString:String?, success:@escaping (Data) -> Void, failure:@escaping (NSError) -> Void) {
        guard let unw_urlString = urlString,
              let unw_url = URL(string: unw_urlString) else { failure(NSError(domain: "ApiNetwork", code: 101, userInfo: nil)) ; return}
        guard let unw_session = session else { failure(NSError(domain: "ApiNetwork", code: 100, userInfo: nil)); return }
        
        self.dataTask = unw_session.dataTask(with: unw_url) { (d, r, e) in
            
        }
        
//        dataTask?.resume()
    }
}

protocol IURLSession: class {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: IURLSession { }
