//
//  URLSessionDataTask+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/23/20.
//

import Foundation

// Built this out in order to Mock the Data Task for testing purposes.
protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
