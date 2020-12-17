//
//  Event.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import Foundation

struct Event: Codable, Equatable {
    let title: String
    let type: String
    let datetimeLocal: String
    let url: String
    let performers: [Performers]
    let stats: Stats?
    let vanue: Venue
}

struct Performers: Codable, Equatable {
    let image: String
}

struct Stats: Codable, Equatable {
    let listingCount: Int?
    let lowestPrice: Int?
    let averagePrice: Int?
    let highestPrice: Int?
}

struct Venue: Codable, Equatable {
    let displayLocation: String
}
