//
//  CyclingStatsDisplayApp.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/29/24.
//

import SwiftUI

private let appAssembler: AppAssembler = AppAssembler() // swinject app assembler handles dependency injection

@main
struct CyclingStatsDisplayApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = appAssembler.resolver.resolved(LoginScreenCoordinator.self)
            
            LoginScreenView(coordinator: coordinator).onOpenURL { url in
                // handles redirect after app is reopened
                coordinator.loginScreenViewModel.authorizeAfterRedirect(url: url)
            }
        }
    }
}
