//
//  TopBarView.swift
//  StravaApp
//
//  Created by Jack Abraham on 9/27/24.
//

import SwiftUI

struct TopBarView: View {
    
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {

        Text(text).bold()
            .foregroundColor(Color.white)
            .font(.system(size: 40))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Rectangle().fill(Color.stravaOrange).ignoresSafeArea())
            .multilineTextAlignment(.center)
        
        
    }
}

#Preview {
    TopBarView(text: "Cycling Stats Display")
}
