//
//  MockURLSession.swift
//  Sport RiotTests
//
//  Created by Jesse Ruiz on 12/23/20.
//

import Foundation
@testable import Sport_Riot

class MockURLSession: URLSessionProtocol {
    
    var dataTask = MockURLSessionDataTask()
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    private (set) var lastURL: URL?
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(data, response, error)
        return dataTask
    }
}
