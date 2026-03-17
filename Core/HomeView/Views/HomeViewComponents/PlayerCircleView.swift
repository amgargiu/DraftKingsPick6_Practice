//
//  PlayerCircleView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import SwiftUI

struct PlayerCircleView: View {
    
    // Essentially need player not just URL
    let player: PlayerModel
    
    var body: some View {
        ZStack {
            // 1. THE BACKGROUND
            Circle()
                .fill(Color.orange)
            
            // 2. THE PLAYER IMAGE
            AsyncImage(url: URL(string: player.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill() // Ensures it fills the circle
                    .frame(width: 40, height: 40)
                    .clipShape(Circle()) // Cuts the shoulders off at the circle edge
            } placeholder: {
                ProgressView()
                    .scaleEffect(0.5)
            }
            
            // 3. THE WHITE BORDER (Sitting on top)
            Circle()
                .stroke(Color.white, lineWidth: 2)
        }
        .aspectRatio(1, contentMode: .fit) // Slightly larger than 40 to account for border
        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    PlayerCircleView(player: DevPreview.player)
}
