//
//  GameCapsuleView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import SwiftUI

struct GameCapsuleView: View {
    let game: GameModel
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color(white: 0.15)) // Dark grey background
            
            HStack(spacing: 10) {
                // 1. AWAY TEAM LOGO (Left)
                teamLogo(url: game.awayTeamImage)
                
                // 2. MIDDLE INFO
                VStack(spacing: 2) {
                    Text("TODAY") // or game.weekday
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.gray)
                    
                    Text(game.time)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(minWidth: 50) // Keeps the time centered
                
                // 3. HOME TEAM LOGO (Right)
                teamLogo(url: game.homeTeamImage)
            }
            .padding(.horizontal, 5)
        }
    }
    
    // Helper for loading logos
    private func teamLogo(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            Circle().fill(.gray.opacity(0.3))
        }
        .frame(width: 32, height: 32)
    }
}

#Preview {
    GameCapsuleView(game: DevPreview.game)
}
