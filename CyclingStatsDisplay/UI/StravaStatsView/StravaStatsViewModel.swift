//
//  StravaStatsDisplayViewModel.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation


class StravaStatsViewModel: ViewModelType {
    private let stravaAPIService: StravaAPIService
    private let athleteName: String
    var header: String
    @Published var riderStats: Result<[RiderStatsDomainObject], Error>? = nil
    
    init(stravaAPIService: StravaAPIService, athleteName: String) {
        self.stravaAPIService = stravaAPIService
        self.athleteName = athleteName
        self.header = athleteName + "'s Ride Stats"
        self.getRiderStats(retry: false)
    }
    
    
    func getRiderStats(retry: Bool) {
        
        if (retry) {
            DispatchQueue.main.async {
                self.riderStats = nil
            }
        }
        stravaAPIService.getRiderData { [weak self] result in
            DispatchQueue.main.async {
                if case .success(let stats) = result {
                    self?.riderStats = .success(stats.toRiderStatsDomainObject())
                }
                else if case .failure(let error) = result{
                    self?.riderStats = .failure(error)
                }
            }
        }
    }
}
