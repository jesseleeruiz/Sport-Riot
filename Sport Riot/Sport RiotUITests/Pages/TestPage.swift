//
//  TestPage.swift
//  Sport RiotUITests
//
//  Created by Jesse Ruiz on 12/23/20.
//

import XCTest

protocol TestPage {
    var testCase: XCTestCase { get }
}

extension TestPage {
    var app: XCUIApplication {
        return XCUIApplication()
    }
}

extension XCTestCase {
    func expect(exists element: XCUIElement, file: String = #file, line: UInt = #line) {
        if !element.exists {
            record(XCTIssue(type: .assertionFailure, compactDescription: "Expected \(element) to exist."))
        }
    }
}
