//
//  RetryButtonView.swift
//  CyclingStatsDisplay
//
//  Created by Jack Abraham on 9/30/24.
//

import SwiftUI


struct RetryButtonView: View {
    var body: some View {
        VStack {
            Text("Retry")
            Image(systemName: "arrow.clockwise.circle")
                .font(.title)
                .foregroundColor(.blue)
                .padding()
                .background(Color.white)
                .clipShape(Rectangle())
                .shadow(radius: 5)
        }
    }
}

#Preview {
    RetryButtonView()
}
