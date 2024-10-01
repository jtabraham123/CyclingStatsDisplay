//
//  ViewModelAssembly.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginScreenViewModel.self) { r in
            LoginScreenViewModel(authenticationService: r.resolved(AuthenticationService.self))
        }.inObjectScope(.transient)
        
        container.register(StravaStatsViewModel.self) { (r, argument: String) in
            StravaStatsViewModel(stravaAPIService: r.resolved(StravaAPIService.self), athleteName: argument)
        }.inObjectScope(.transient)
    }
}
