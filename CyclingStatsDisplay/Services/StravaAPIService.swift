//
//  StravaAPIService.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import Foundation
import Combine

class StravaAPIService {
    private var authToken = ""
    private var athleteID: Int? = nil
    private var cancellable: AnyCancellable?
    
    
    func setTokenAndAthleteID(authToken: String, athleteID: Int) {
        self.authToken = authToken
        self.athleteID = athleteID
    }
    
    //makes call to strava api to obtain athletes stats
    func getRiderData(completion: @escaping (Result<RiderStatsResponse, Error>) -> Void) {
        if let id = athleteID {
            guard let url = URL(string: "https://www.strava.com/api/v3/athletes/\(id)/stats") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
            cancellable = URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: RiderStatsResponse.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { result in
                        switch result {
                        case .finished:
                            break
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }, receiveValue: { riderStatsResponse in
                        // Handle the decoded response
                        completion(.success(riderStatsResponse))
                    })
        }
        
        
    }
    
}
