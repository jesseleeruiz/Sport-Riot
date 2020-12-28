//
//  Sport_RiotUITests.swift
//  Sport RiotUITests
//
//  Created by Jesse Ruiz on 12/16/20.
//
// swiftlint:disable type_name

import XCTest

class Sport_RiotUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launchArguments = ["UITesting"]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testEventsAppear() {
        EventsTableViewPage(testCase: self)
            .verifyEventsTableViewPageIsShowing()
    }
}
