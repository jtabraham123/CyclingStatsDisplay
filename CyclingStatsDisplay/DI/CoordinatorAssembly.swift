//
//  CoordinatorAssembly.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation
import Swinject

// coordinator is the only object to hold the resolver so it can handle view model creation/injection
class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginScreenCoordinator.self) { r in
            LoginScreenCoordinator(resolver: r)
        }.inObjectScope(.container)
    }
}

