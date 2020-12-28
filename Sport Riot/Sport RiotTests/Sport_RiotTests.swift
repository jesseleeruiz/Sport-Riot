//
//  Sport_RiotTests.swift
//  Sport RiotTests
//
//  Created by Jesse Ruiz on 12/16/20.
//
// swiftlint:disable type_name

import XCTest
@testable import Sport_Riot

class Sport_RiotTests: XCTestCase {
    var subject: EventsController!
    
    override func setUp() {
        super.setUp()
        subject = EventsController()
    }
    
    func testFetchingEvents() {
        let url = URL(string: "https://api.seatgeek.com/2/events")!
        let page = 1
        let expectation = XCTestExpectation(description: "Wait for \(url) to load.")
        var fetchedEvents: Event?
        
        subject.getEvents(page: page) { result in
            switch result {
            case .success(let event):
                fetchedEvents = event
                expectation.fulfill()
            case .failure(let error):
                NSLog("\(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(fetchedEvents, "There are events!")
    }
}
