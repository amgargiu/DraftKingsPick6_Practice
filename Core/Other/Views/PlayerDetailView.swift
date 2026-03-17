//
//  PlayerDetailView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/16/26.
//

import SwiftUI


// 1. THIS MUST BE OUTSIDE OR ACCESSIBLE

struct PlayerDetailView: View {
    let player: PlayerModel
    
    // 2. COMPUTED PROPERTIES FOR DATA (Inside the View)
    var seasonStatItems: [StatItem] {
        [
            StatItem(label: "PTS", value: String(format: "%.1f", player.PTS ?? 0)),
            StatItem(label: "REB", value: String(format: "%.1f", player.REB ?? 0)),
            StatItem(label: "AST", value: String(format: "%.1f", player.AST ?? 0)),
            StatItem(label: "3PM", value: String(format: "%.1f", player.threePM ?? 0)),
            StatItem(label: "STL", value: String(format: "%.1f", player.STL ?? 0)),
            StatItem(label: "BLK", value: String(format: "%.1f", player.BLK ?? 0)),
            StatItem(label: "TO", value: String(format: "%.1f", player.TO ?? 0)),
            StatItem(label: "MIN", value: String(format: "%.1f", player.MIN ?? 0))
        ]
    }
    
    var last5StatItems: [StatItem] {
        [
            StatItem(label: "PTS", value: String(format: "%.1f", player.last5PTS ?? 0)),
            StatItem(label: "REB", value: String(format: "%.1f", player.last5REB ?? 0)),
            StatItem(label: "AST", value: String(format: "%.1f", player.last5AST ?? 0)),
            StatItem(label: "3PM", value: String(format: "%.1f", player.last5ThreePM ?? 0)),
            StatItem(label: "STL", value: String(format: "%.1f", player.last5STL ?? 0)),
            StatItem(label: "BLK", value: String(format: "%.1f", player.last5BLK ?? 0)),
            StatItem(label: "TO", value: String(format: "%.1f", player.last5TO ?? 0)),
            StatItem(label: "MIN", value: String(format: "%.1f", player.last5Min ?? 0))
        ]
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                
                // FADING BACKGROUND LOGO
                PlayerTeamImageView(player: player)
                    .scaledToFit()
                    .frame(width: 350)
                    .opacity(0.24)
                    .mask(LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom))
                    .offset(y: -50)
                    .ignoresSafeArea()
                    
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        // HERO SECTION
                        VStack(spacing: 15) {
                            PlayerImageView(player: player)
                                .scaledToFit()
                                .frame(width: 300, height: 250)
                                .shadow(color: .orange.opacity(0.2), radius: 20)
                            
                            VStack(spacing: 8) {
                                Text(player.player ?? "Unknown")
                                    .font(.system(size: 36, weight: .black))
                                    .multilineTextAlignment(.center)
                                
                                HStack(spacing: 12) {
                                    PlayerTeamImageView(player: player)
                                        .frame(width: 30, height: 30)
                                    Text("\(player.team ?? "")  |  \(player.position ?? "")")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        // STAT GRIDS
                        VStack(spacing: 35) {
                            detailStatGrid(title: "Season Averages", stats: seasonStatItems)
                            detailStatGrid(title: "Last 5 Games", stats: last5StatItems)
                        }
                        .padding(.horizontal)
                        
                        // FANTASY FOOTER
                        HStack {
                            VStack(alignment: .leading) {
                                Text("ROSTERED").font(.caption.bold())
                                Text("\(Int((player.pctRostered ?? 0) * 100))%").font(.title2)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("FANTASY AVG").font(.caption.bold())
                                Text(String(format: "%.1f", player.fantasyPtsAvg ?? 0))
                                    .font(.title2)
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(25)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color(white: 0.15)))
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                    }
                    .padding(.top, -30)
                }
            }
            .foregroundColor(.white)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XMarkButton()
                        .foregroundStyle(.orange)
                }
            }
        }
    }

    // 3. FIXED GRID HELPER
    private func detailStatGrid(title: String, stats: [StatItem]) -> some View {
        VStack(alignment: .center, spacing: 15) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .heavy))
                .tracking(2)
                .foregroundColor(.orange)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                // FIXED FOR EACH: Uses \.id now
                ForEach(stats) { item in
                    VStack(spacing: 6) {
                        Text(item.label)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.gray)
                        Text(item.value)
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(white: 0.12)))
                }
            }
        }
    }
}

#Preview {
    PlayerDetailView(player: DevPreview.player)
}
