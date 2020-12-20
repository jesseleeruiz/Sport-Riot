//
//  Event.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//
// swiftlint:disable nesting

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
        
        struct Performers: Codable {
            let image: String
            let id: Int
        }

        struct Stats: Codable {
            let listingCount: Int?
            let lowestPrice: Int?
            let averagePrice: Int?
            let highestPrice: Int?
        }

        struct Venue: Codable {
            let displayLocation: String
        }
    }
}
