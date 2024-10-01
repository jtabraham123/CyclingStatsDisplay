//
//  File.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation


struct RiderStatsResponse : Codable {
    let recent_ride_totals: RiderData
    let ytd_ride_totals: RiderData
    let all_ride_totals: RiderData
}

struct RiderData : Codable {
    let count: Int
    let distance: Double
    let moving_time: Int
    let elapsed_time: Int
    let elevation_gain: Double
}
