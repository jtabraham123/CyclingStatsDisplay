//
//  LoginScreenViewModel.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation

protocol LoginScreenViewModelDelegate: AnyObject {
    func didAuthenticate(_ name: String)
}

class LoginScreenViewModel: ViewModelType {
    
    private let authenticationService: AuthenticationService
    var loginUsername = ""
    private weak var delegate: LoginScreenViewModelDelegate?
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    func registerWindow() {
        authenticationService.registerWindow()
    }
    
    func addDelegate(delegate: LoginScreenViewModelDelegate) {
        self.delegate = delegate
    }
    
    // After successful authentication, the viewmodel calls didAuthenticate (which is implemented in the Coordinator)
    // which triggers a navigation event to the StravaStatsView
    
    // this is for Strava App based authentication and is called from the CyclingStatsDisplay app file
    // after a url redirect from Strava App back to the CyclingStatsDisplay app
    func authorizeAfterRedirect(url: URL) {
        authenticationService.authenticateWithURL(url: url, error: nil) { [weak self] result in
            if case .success(let name) = result {
                DispatchQueue.main.async {
                    self?.delegate?.didAuthenticate(name)
                }
            }
        }
    }
    
    // this is for Strava Web based authentication
    func authorize() {
        authenticationService.authenticate { [weak self] result in
            if case .success(let name) = result {
                DispatchQueue.main.async {
                    self?.delegate?.didAuthenticate(name)
                }
            }
        }
    }
}

