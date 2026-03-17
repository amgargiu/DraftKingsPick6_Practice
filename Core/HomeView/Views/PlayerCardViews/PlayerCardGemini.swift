//
//  PlayerCardGemini.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/12/26.
//

import SwiftUI

struct PlayerCardGemini: View {
    let player: PlayerModel
    
    // We use @State to track if the user clicked "More" or "Less"
    @State private var selectedPick: String? = nil
    
    var body: some View {
        // 1. THE FOUNDATION (ZStack)
        // This allows us to layer the logo BEHIND the text.
        ZStack {
            // THE BASE CARD
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(white: 0.1)) // Very dark grey
            
            // THE GHOST LOGO
            // We use an overlay here so it stays pinned to the top right
            // without pushing the other content around.
            Color.clear
                .overlay(alignment: .topTrailing) {
                    PlayerTeamImageView(player: player)
                        .scaledToFit()
                        .frame(width: 180) // Large logo
                        .opacity(0.12)     // Faded out
                        .offset(x: 40, y: -20)
                }
                .clipped() // Keeps the ghost logo inside the rounded corners
            
            // 2. THE CONTENT TOWER (VStack)
            VStack(spacing: 12) {
                
                // --- ZONE A: IDENTITY ---
                VStack(spacing: 4) {
                    PlayerImageView(player: player)
                        .scaledToFit()
                        .frame(height: 110)
                        .padding(.top, -10) // Pulls image slightly higher
                    
                    HStack(spacing: 6) {
                        PlayerTeamImageView(player: player)
                            .frame(width: 18, height: 18)

                        
                        Text(player.abbrevName)
                            .font(.system(size: 16, weight: .bold))
                            .lineLimit(1)
                        
                        Text(player.displayPosition)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("\(player.displayOpp) @ \(player.displayTeam)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.gray)
                    
                    Text("Today, 9:40 PM")
                        .font(.system(size: 11))
                        .foregroundStyle(.gray.opacity(0.6))
                }
                
                // --- ZONE B: THE DASHED LINE ---
                // This creates the "cut-out" look from your screenshot.
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.white.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                // --- ZONE C: THE STAT ---
                VStack(spacing: 2) {
                    HStack {
                        // Minus Button
                        statControlIcon(name: "minus.circle.fill")
                        
                        Spacer()
                        
                        // The Big Number
                        VStack(spacing: -2) {
                            Text(player.ptsString)
                                .font(.system(size: 28, weight: .black))
                                .lineLimit(1)
                            Text("Points")
                                .font(.system(size: 12, weight: .bold))
                        }
                        
                        Spacer()
                        
                        // Plus Button
                        statControlIcon(name: "plus.circle.fill")
                    }
                    .padding(.horizontal, 25)
                }
                
                // --- ZONE D: INTERACTION BUTTONS ---
                HStack(spacing: 10) {
                    actionButton(title: "More", icon: "arrow.up", type: "More")
                    actionButton(title: "Less", icon: "arrow.down", type: "Less")
                }
                .padding(.top, 5)
            }
            .padding(15) // Inner padding for the content tower
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .aspectRatio(0.85, contentMode: .fit) // Keeps the "Card Shape"
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
    
    // --- PROFESSOR'S HELPERS (Functions) ---

    // A simple function for the +/- icons to keep the main code readable
    func statControlIcon(name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 22))
            .foregroundStyle(Color(white: 0.2))
    }

    // This @ViewBuilder function creates the More/Less buttons
    @ViewBuilder
    func actionButton(title: String, icon: String, type: String) -> some View {
        Button {
            selectedPick = type
        } label: {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(title.uppercased())
                    .font(.system(size: 13, weight: .heavy))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(selectedPick == type ? Color.green : Color(white: 0.15))
            .cornerRadius(10)
        }
    }
}

#Preview {
    PlayerCardGemini(player: DevPreview.player)
}
