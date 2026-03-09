//
//  test.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct test: View {
    
    let player: PlayerModel
    
    var body: some View {
        
        ZStack {
            
            // Background team logo
            TeamImageView(player: player)
                .opacity(0.12)
                .scaleEffect(1)
            
            VStack(spacing: 10) {
                
                // Player Image
                PlayerImageView(player: player)
                    .frame(width: 159, height: 150)
                
                // Name
                Text(player.player ?? "")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                // Team / Position
                Text("\(player.team ?? "") • \(player.position ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Key Stats Row
                HStack(spacing: 20) {
                    statView(value: player.PTS, label: "PTS")
                    statView(value: player.REB, label: "REB")
                    statView(value: player.AST, label: "AST")
                }
                .padding(.bottom, 20)
                
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.15))
        )
        .shadow(radius: 3)
        .padding(.vertical, 6)
        
    }
    
    
    // Small stat block
    func statView(value: Double?, label: String) -> some View {
        VStack {
            Text(String(format: "%.1f", value ?? 0))
                .font(.headline)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    test(player: DevPreview.player)
}
