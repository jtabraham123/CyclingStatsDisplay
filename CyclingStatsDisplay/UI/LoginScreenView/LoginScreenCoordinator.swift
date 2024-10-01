//
//  LoginScreenCoordinator.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation
import SwiftUI
import Swinject



class LoginScreenCoordinator: ObservableObject {
    private let resolver: Resolver
    @Published var path = NavigationPath()
    var loginScreenViewModel: LoginScreenViewModel
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.loginScreenViewModel = resolver.resolved(LoginScreenViewModel.self)
        self.loginScreenViewModel.addDelegate(delegate: self)
    }
    
}
// navigation event to move to the StravaStatsViewPage
extension LoginScreenCoordinator: LoginScreenViewModelDelegate {
    func didAuthenticate(_ name: String) {
        path.append(self.resolver.resolved(StravaStatsViewModel.self, argument: name))
    }
}
