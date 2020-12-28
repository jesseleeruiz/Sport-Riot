//
//  Date+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/18/20.
//

import Foundation

extension Date {
    
    /// Converts the date to a string.
    /// - Returns: Returns a string version of the date received.
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy, hh:mm a"
        return dateFormatter.string(from: self)
    }
}
