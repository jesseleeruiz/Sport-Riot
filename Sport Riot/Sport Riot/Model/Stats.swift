//
//  Stats.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/20/20.
//

import Foundation

struct Stats: Codable, Equatable, Hashable {
    let listingCount: Int?
    let lowestPrice: Int?
    let averagePrice: Int?
    let highestPrice: Int?
}
