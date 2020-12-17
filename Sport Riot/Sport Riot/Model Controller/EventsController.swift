//
//  EventsController.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import Foundation

class EventsController {
    
    // https://api.seatgeek.com/2/events?per_page=15&page=2&client_id=MjE0NDQ0MDJ8MTYwODE1MTc4OS45MDA0OTc0
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://api.seatgeek.com/2/events")
    
    func getEvents(page: Int, completion: @escaping (Result<[Event], SRError>) -> Void) {
        let endpoint = baseURL?
            .appendingPathComponent("per_page=15")
            .appendingPathComponent("page=\(page)")
            .appendingPathComponent(<#T##pathComponent: String##String#>)
    }
}
