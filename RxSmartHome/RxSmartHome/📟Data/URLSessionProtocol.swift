//  URLSessionProtocol.swift

import Foundation
protocol URLSessionProtocol: class {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: URLSessionProtocol { }  // use to extract the difficult dependancy injection
