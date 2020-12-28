//
//  MockURLSessionDataTask.swift
//  Sport RiotTests
//
//  Created by Jesse Ruiz on 12/23/20.
//

import Foundation
@testable import Sport_Riot

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
