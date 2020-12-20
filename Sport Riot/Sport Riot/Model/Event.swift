//
//  Event.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import Foundation

struct Event: Codable {
    let events: [Events]
    
    struct Events: Codable {
        let title: String
        let type: String
        let datetimeLocal: String
        let url: String
        
        let performers: [Performers]
        let stats: Stats
        let venue: Venue
    }
}
