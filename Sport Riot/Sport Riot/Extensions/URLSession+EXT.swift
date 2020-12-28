//
//  URLSession+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/23/20.
//

import Foundation

// Built this out in order to Mock the URL Session for testing purposes.
typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

extension URLSession {
    static func defaultSession() -> URLSession {
        return URLSession(configuration: URLSessionConfiguration.default,
                          delegate: nil,
                          delegateQueue: OperationQueue.main)
    }
}
