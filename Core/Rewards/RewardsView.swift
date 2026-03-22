//
//  RewardsView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/19/26.
//

import SwiftUI

struct RewardsView: View {
    var body: some View {
        Image("banner-copilot-nba-game")
            .resizable()
            .scaledToFit()
            .frame(height: 250)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

#Preview {
    RewardsView()
}
