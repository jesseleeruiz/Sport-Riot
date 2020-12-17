//
//  SRError.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/16/20.
//

import Foundation

enum SRError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
