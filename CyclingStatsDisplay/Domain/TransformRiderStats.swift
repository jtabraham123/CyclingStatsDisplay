//
//  TransformRiderStats.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation

/*
 This file is the domain layer. It transforms the data objects recieved from the StravaAPIService into
 new objects that are easier to access for the view. This way the view can focus solely on presenting the data.
*/

struct RiderStatsDomainObject: Hashable {
    let key: String
    let values: [RiderDataWithTitle]
}

struct RiderDataWithTitle: Hashable {
    let title: String
    let value: String
}

extension RiderStatsResponse {
    
    func toRiderStatsDomainObject() -> [RiderStatsDomainObject] {
        var transformed : [RiderStatsDomainObject] = []
        transformed.append(RiderStatsDomainObject(key: "Recent Rides", values: recent_ride_totals.toRiderDataWithTitle()))
        transformed.append(RiderStatsDomainObject(key: "Rides This Year", values: ytd_ride_totals.toRiderDataWithTitle()))
        transformed.append(RiderStatsDomainObject(key: "Alltime Rides", values: all_ride_totals.toRiderDataWithTitle()))
        return transformed
    }
    
}


extension RiderData {
    func toRiderDataWithTitle() -> [RiderDataWithTitle] {
        var transformed : [RiderDataWithTitle] = []
        transformed.append(RiderDataWithTitle(title: "Ride Count", value: String(count)))
        let milesTraveled = distance/1609.34
        transformed.append(RiderDataWithTitle(title:"Distance Rode", value: String(format: "%.2f", milesTraveled) + " miles"))
        let minutesRiding = Float(moving_time)/60.0
        transformed.append(RiderDataWithTitle(title:"Time Spent Riding", value: String(format: "%.2f", minutesRiding) + " minutes"))
        let feetGain = elevation_gain*3.28084
        transformed.append(RiderDataWithTitle(title: "Elevation Gain", value: String(format: "%.2f", feetGain) + " feet"))
        return transformed
    }
}
