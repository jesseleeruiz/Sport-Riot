//
//  Event.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import Foundation

struct Event: Codable, Equatable {
    let events: [Events]
    
    struct Events: Codable, Equatable {
        let title: String
        let type: String
        let datetimeLocal: String
        let url: String
        let id: Int
        
        let performers: [Performers]
        let stats: Stats
        let venue: Venue
    }
}
