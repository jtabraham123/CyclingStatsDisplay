//
//  Errors.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case invalidData
    case authenticationError
}
