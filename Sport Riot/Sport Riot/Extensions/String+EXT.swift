//
//  String+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/18/20.
//

import Foundation

extension String {
    
    /// Converts the stringed date from the API into a date.
    /// - Returns: Returns a date from the stringed API.
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    /// Converts the date into a stringed version that can be displayed into the app.
    /// - Returns: Returns a proper string that can be displayed in the app.
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
