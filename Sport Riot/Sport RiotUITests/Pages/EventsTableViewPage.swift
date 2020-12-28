//
//  EventsTableViewPage.swift
//  Sport RiotUITests
//
//  Created by Jesse Ruiz on 12/23/20.
//

import XCTest

struct EventsTableViewPage: TestPage {
    let testCase: XCTestCase
    
    var tableView: XCUIElement {
        return app.tables.element(boundBy: 0)
    }
    
    func tableViewCell(at index: Int) -> XCUIElement {
        return tableView.cells.element(boundBy: index)
    }
    
    @discardableResult func verifyEventsTableViewPageIsShowing(file: String = #file, line: UInt = #line) -> EventsTableViewPage {
        testCase.expect(exists: tableView)
        return self
    }
}
