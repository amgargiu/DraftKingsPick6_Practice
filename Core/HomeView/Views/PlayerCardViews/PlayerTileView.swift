//
//  PlayerTileView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct PlayerTileView: View {
    let player: PlayerModel
    let displayStat: StatType
    
    // NEW: These allow the Tile to communicate with your main Picks array
    let selectedDirection: SelectionDirection?
    var onSelect: (SelectionDirection) -> Void

    var body: some View {
        VStack(spacing: 0) {
            // 1. TOP SECTION (Flexible Height)
            ZStack(alignment: .top) {
                // MASSIVE BACKGROUND LOGO
                Color.clear
                    .overlay(alignment: .topTrailing, content: {
                        PlayerTeamImageView(player: player)
                                .scaledToFit()
                                .frame(width: 220) // Make it big
                                .opacity(0.15)
                                // THE MASK: Fades the logo out as it moves toward the center
                                .mask(
                                    LinearGradient(
                                        stops: [
                                            .init(color: .clear, location: 0),    // Invisible at the left/center
                                            .init(color: .black, location: 1)    // Fully visible at the top-right
                                        ],
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing
                                    )
                                )
                                .offset(x: 70, y: -40) // Nudge it into the corner
                    })
                

                VStack(spacing: 4) {
                    PlayerImageView(player: player)
                        .scaledToFit()
                            .frame(minHeight: 80, maxHeight: 110) // some adaptability
                            .padding(.top, -10)
                            // ADD THIS OVERLAY:
                            .overlay(
                                LinearGradient(
                                    colors: [.clear, Color(white: 0.13)], // Fades from nothing to the card's background color
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            )
                    
                    VStack(spacing: 2) {
                        HStack(spacing: 4) {
                            PlayerTeamImageView(player: player)
                                .frame(width: 16, height: 16)
                            
                            Text(abbreviatedName)
                                .font(.system(size: 16, weight: .bold)) // 1. Set size and bold weight
                                    .foregroundColor(.white)
                                    .lineLimit(1)                          // 2. Ensure it stays on one line
                                    .minimumScaleFactor(0.7)
                            
                            Text(player.position ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Text("\(player.opp ?? "") @ \(player.team ?? "")")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))

                        
                        Text(player.time ?? "Today, 10:00 PM")
                            .font(.system(size: 12))
                            .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))

                            .bold()
                    }
                    .padding(.top, -15) // This moves the text up so it overlaps the bottom of the player
                }
            }
            
            // 2. MIDDLE SECTION (after Line)
            VStack(spacing: 0) {
                Divider()
                    .background(Color.white.opacity(0.2))
                    .padding(.vertical, 10)
                
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20)) // Scaled down for grid
                        .foregroundColor(Color(white: 0.2))
                    
                    Spacer()
                    
                    VStack(spacing: -2) {
                        
                        Group {
                            switch displayStat {
                            case .points:
                                Text("\(player.ptsString)")
                            case .rebounds:
                                Text("\(player.rebString)")
                            case .assists:
                                Text("\(player.astString)")
                            }
                        }
                        .font(.system(size: 16, weight: .black))
                        .foregroundColor(.white)
                        
                        Text(displayStat.rawValue)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20)) // Scaled down for grid
                        .foregroundColor(Color(white: 0.2))

                }
                .padding(.horizontal, 10)
            }
            
            // 3. BOTTOM SECTION
            HStack(spacing: 8) {
                // Calls onSelect with .more
                actionButton(title: "More", icon: "arrow.up", selected: selectedDirection == .more) {
                    onSelect(.more)
                }
                    
                // Calls onSelect with .less
                actionButton(title: "Less", icon: "arrow.down", selected: selectedDirection == .less) {
                    onSelect(.less)
                }
            }
            .padding(.top, 12)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(white: 0.13))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .clipped()
    }
    
    @ViewBuilder
    private func actionButton(title: String, icon: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(title.uppercased())
                    .font(.system(size: 12, weight: .heavy))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40) // Tighter buttons for grid
            .background(selected ? Color.green : Color(white: 0.22))
            .foregroundColor(.white)
            .cornerRadius(9)
        }
    }
    
    private var abbreviatedName: String {
        let name = player.player ?? "Unknown"
        let components = name.components(separatedBy: " ")
        
        if components.count >= 2 {
            let firstName = components[0]
            let lastName = components.dropFirst().joined(separator: " ")
            if let firstLetter = firstName.first {
                return "\(firstLetter). \(lastName)"
            }
        }
        return name
    }
}

#Preview {
    PlayerTileView(
        player: DevPreview.player,
        displayStat: .points,
        selectedDirection: .none,
        onSelect: { _ in }
    )
}



