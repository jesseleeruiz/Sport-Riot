//
//  URLComponents+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
