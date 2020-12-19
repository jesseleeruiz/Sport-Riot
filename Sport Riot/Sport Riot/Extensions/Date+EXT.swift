//
//  Date+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/18/20.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy, hh:mm a"
        return dateFormatter.string(from: self)
    }
}
