//
//  AuthenticationView.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/29/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

// holds the UIWindow for the scene for the presentationContextProvider attribute in web authentication
class AuthenticationViewProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    let window: UIWindow
    
    init(window : UIWindow) {
        self.window = window
    }
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return window
    }
}
