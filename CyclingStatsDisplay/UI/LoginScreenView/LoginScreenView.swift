//
//  LoginScreenView.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import SwiftUI

struct LoginScreenView: View {
    @ObservedObject private var viewModel: LoginScreenViewModel
    @ObservedObject private var coordinator : LoginScreenCoordinator
    
    init(coordinator: LoginScreenCoordinator) {
        self.coordinator = coordinator
        self.viewModel = coordinator.loginScreenViewModel
    }
    
    
    var body: some View {
        NavigationStack(path: self.$coordinator.path) {
            ZStack {
                LinearGradient(
                    colors: [.stravaOrange,.orange, .white],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                VStack {
                    TopBarView(text: "Cycling Stats Display")
                    Spacer()
                    Text("Welcome to Cycling Statistics Display. \nPlease click the button below to sign in with your Strava account")
                        .font(.system(size: 20))
                        .padding()
                        .background(Color.stravaOrange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        self.viewModel.authorize()
                    } label: {
                        Image("StravaConnect")
                    }
                    .navigationDestination(for: StravaStatsViewModel.self) { statsViewModel in
                        StravaStatsView(stravaStatsViewModel: statsViewModel)
                    }
                    Spacer()
                }
            }
        }.onAppear {
            // for swiftui lifecycle, scene UI window should be available by now
            // so the web auth session can now access the UI window for its
            // presentationContextProvider attribute
            self.viewModel.registerWindow()
        }
    }
}

#Preview {
    LoginScreenView(coordinator: AppAssembler().resolver.resolved(LoginScreenCoordinator.self))
}
