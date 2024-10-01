//
//  ServiceAssembly.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(StravaAPIService.self) { r in
            StravaAPIService()
        }.inObjectScope(.container)
        
        container.register(AuthenticationService.self) { r in
            AuthenticationService(stravaAPIService: r.resolved(StravaAPIService.self))
        }.inObjectScope(.container)
        
    }
}
