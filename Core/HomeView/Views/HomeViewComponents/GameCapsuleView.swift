//
//  GameCapsuleView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import SwiftUI

struct GameCapsuleView: View {
    
    @ObservedObject var vm: HomeViewModel
    let game: GameModel
    @Binding var selectedGameID: UUID?
    @State var load = false
    
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(selectedGameID == game.id ? .gray : Color(white: 0.15)) // Dark grey background
            
            HStack(spacing: 10) {
                // 1. AWAY TEAM LOGO (Left)
                teamLogo(team: game.homeTeam.uppercased())
                
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
                teamLogo(team: game.awayTeam.uppercased())
            }
            .padding(.horizontal, 5)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                load.toggle()
            }
        }
    }
    
    // Helper for loading logos
    @ViewBuilder
    private func teamLogo(team: String) -> some View {
        
        if let image = PlayerTeamImagesDataService.shared.teamdict[team ?? ""] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
        } else {
                ProgressView()
                    .frame(width: 32, height: 32)
        }
 
    }
}

#Preview {
    GameCapsuleView(vm: HomeViewModel(), game: GameModel(homeTeam: "was", awayTeam: "gsw", time: "8:00"), selectedGameID: .constant(UUID()))
}
