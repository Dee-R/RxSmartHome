/// ApiNetwork

import Foundation

// ⛔️⛔️ Engine
class ApiNetwork: NSObject, IApiNetwork {
//    var session: URLSession?
    var session: URLSessionProtocol? // for injecting a mock / stub object from unit test
    private var dataTask: URLSessionTask?
    
    override init() {
        super.init()
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func fetchFromURL(urlString:String?, success:@escaping (Data) -> Void, failure:@escaping (NSError) -> Void) {
        guard let unw_session = session else { failure(NSError(domain: "ApiNetwork", code: 100, userInfo: nil)); return }
        guard let unw_urlString = urlString,
              let unw_url = URL(string: unw_urlString) else { failure(NSError(domain: "ApiNetwork", code: 101, userInfo: nil)) ; return}
        
        dataTask = unw_session.dataTask(with: unw_url, completionHandler: { (data, response, error) in
            // error
            if let error = error {
                failure(error as NSError)
                return
            }
            // response
            if let response = response as? HTTPURLResponse,
               let data = data {
                if response.statusCode == 200 {
                    success(data)
                    return
                }
            }
            // failure
            failure(NSError(domain: "ApiNetwork", code: 102, userInfo: nil))
            return
        })
        dataTask?.resume()
        
    }
    
    
    func fetch(completion: @escaping (DeviceModel?, String?) -> Void) {
        // // TODO: integration
        completion(nil,nil)
    }
}


// 👁👁🤝 Proper protocol
protocol IApiNetwork {
    func fetch(completion: @escaping (DeviceModel?, String?)->Void)
}
