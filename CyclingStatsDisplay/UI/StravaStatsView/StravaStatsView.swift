//
//  StravaStatsDisplayView.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import SwiftUI

struct StravaStatsView: View {
    @ObservedObject private var viewModel: StravaStatsViewModel
    
    
    init(stravaStatsViewModel: StravaStatsViewModel) {
        self.viewModel = stravaStatsViewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.stravaOrange,.orange, .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                TopBarView(text: viewModel.header)
                Spacer()
                switch viewModel.riderStats {
                case .none:
                    ProgressView().frame(width: 400, height: 400)
                case .success(let riderStats):
                    ForEach(riderStats, id: \.self) { statType in
                        VStack {
                            Text(statType.key).bold()
                                .foregroundColor(Color.white)
                                .font(.system(size: 34))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Rectangle().fill(Color.stravaOrange))
                                .multilineTextAlignment(.center)
                            HStack {
                                ForEach(statType.values, id: \.self) { stat in
                                    VStack {
                                        Text(stat.title).bold()
                                        Text(stat.value)
                                    }
                                }
                            }
                        }
                    }
                case .failure(let error):
                    VStack {
                        Text("Failed to load rider data: \(error.localizedDescription)")
                            .frame(width: 200, height: 200)
                        Button(action: {
                            self.viewModel.getRiderStats(retry: true)
                        }) {
                            RetryButtonView()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}



#Preview {
    
    StravaStatsView(stravaStatsViewModel: AppAssembler().resolver.resolved(StravaStatsViewModel.self, argument: "Jack Abraham"))
}

