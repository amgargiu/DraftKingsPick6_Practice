//
//  test.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct PlayerGridView: View {
    
    @StateObject var vm = PlayersViewModel()
    
    // The "Source of Truth" for what is selected
    // Note: If you want the bottom bar to see this, you might move this to @Binding later
    @State private var selectedPicks: [PickModel] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    @Binding var displayStat: StatType
    
    var body: some View {
        
//        seePicksHelper
        
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(vm.allPlayers) { player in
                        PlayerTileView(
                            player: player,
                            displayStat: displayStat,
                            // Pass whether THIS player is currently in the picks array
                            selectedDirection: selectedPicks.first(where: { $0.player.id == player.id })?.direction,
                            // Pass the action to handle the selection logic
                            onSelect: { direction in
                                handlePick(player: player, direction: direction)
                            }
                        )
                    }
                }
                .padding(.horizontal, 4)
            }
            
            // Note: You will eventually place your 'testing()' bottom bar view here
            // and pass 'selectedPicks' to it.
        }
    }
    
    // THE LOGIC BRAIN
    private func handlePick(player: PlayerModel, direction: SelectionDirection) {
        // 1. Find if we already have a pick for this player
        let existingPick = selectedPicks.first(where: { $0.player.id == player.id }) // player id property in PickModel
        
        // 2. Remove ANY existing pick for this player regardless of direction
        selectedPicks.removeAll(where: { $0.player.id == player.id })
        
        // 3. If the new direction is DIFFERENT than the one we just removed, add it back
        // (If they were the same, we leave it removed - that's a deselection)
        if existingPick?.direction != direction {
            if selectedPicks.count < 8 {
                let newPick = PickModel(
                    player: player,
                    statType: displayStat,
                    targetValue: 0.0,
                    direction: direction
                )
                selectedPicks.append(newPick)
            }
        }
    }}

#Preview {
    PlayerGridView(displayStat: .constant(.points))
}




extension PlayerGridView {
    
    var seePicksHelper : some View {
        Group {
            Text("selectedPicks: \(selectedPicks.count)")
            ForEach(selectedPicks) { pick in
                HStack {
                    // Access the player name from the player model inside the pick
                    Text(pick.player.player ?? "Unknown Player")
                        .fontWeight(.bold)
                    // Show the stat type and direction
                    Text(pick.statType.rawValue.uppercased())
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                    Text(pick.direction == .more ? "MORE" : "LESS")
                        .foregroundColor(pick.direction == .more ? .green : .red)
                        .fontWeight(.black)
                }
            }
        } // end group
    }
    
}
