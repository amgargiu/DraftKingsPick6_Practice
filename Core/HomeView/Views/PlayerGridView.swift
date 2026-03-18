//
//  test.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct PlayerGridView: View {
    
    @ObservedObject var vm : PlayersViewModel // needed to loop on for grid - init in homeview - mayeb in Env?
    
    // The "Source of Truth" for what is selected
    // Note: If you want the bottom bar to see this, you might move this to @Binding later
    
    
    //    @State private var selectedPicks: [PickModel] = []
//    @Binding var selectedPicks: [PickModel]
    let selectedPicks: [PickModel]
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    let displayStat: StatType
    
    @Binding var selectedPlayerForDetails: PlayerModel?
    
    
    var onPick: (PlayerModel, SelectionDirection) -> Void
    
    
    var body: some View {
        
        // un coment to see the picks at the top (now will only shwo in hoemView since binding in preview)
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
                                onPick(player, direction) // PASS IT UP
                            }
                        )
                        .overlay(alignment: .bottom) {
                            GeometryReader { geo in
                                Color.clear // make red to see this
                                    .contentShape(Rectangle()) // 2. Essential! Makes the invisible area "hit-testable"
                                    .onTapGesture {
                                        selectedPlayerForDetails = player
                                    }
                                // 3. Take up the full width, but exactly 50% of the height
                                    .frame(width: geo.size.width, height: geo.size.height * 0.5)
                            }
                            .padding(10)
                        }
                        
                    }
                }
                .padding(.horizontal, 4)
            }
            
            // Note: You will eventually place your 'testing()' bottom bar view here
            // and pass 'selectedPicks' to it.
        }
    }
}

#Preview {
    PlayerGridView(
        vm: PlayersViewModel(),
        selectedPicks: [], displayStat: .points,
        selectedPlayerForDetails: .constant(nil),
        onPick: { player, direction in
        print("Preview: Picked \(player.player ?? "Unknown") for \(direction)")
    })
}




extension PlayerGridView {
    
    
    
}
