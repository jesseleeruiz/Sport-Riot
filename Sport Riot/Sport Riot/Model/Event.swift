//
//  Event.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//
// swiftlint:disable nesting

import Foundation

struct Event: Decodable, Equatable {
    let events: [Events]
    
    struct Events: Decodable, Equatable {
        let title: String
        let type: String
        let datetimeLocal: String
        let url: String
        
        let performers: [Performers]
        let stats: Stats
        let venue: Venue
        
        struct Performers: Decodable, Equatable {
            let image: String
        }

        struct Stats: Decodable, Equatable {
            let listingCount: Int?
            let lowestPrice: Int?
            let averagePrice: Int?
            let highestPrice: Int?
        }

        struct Venue: Decodable, Equatable {
            let displayLocation: String
        }
    }
}
