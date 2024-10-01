//
//  AuthResponse.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation


struct AuthResponse : Codable {
    let access_token : String
    let athlete : Athlete
}

struct Athlete : Codable {
    let id : Int
    let firstname : String
    let lastname : String
}
