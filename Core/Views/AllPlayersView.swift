//
//  AllPlayersView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct AllPlayersView: View {
    
    @StateObject var vm = PlayersViewModel()
    
    var body: some View {
        
        
            List {
                ForEach(vm.allPlayer) { player in
                    LazyVStack(spacing: 20) {
//                        PlayerImageView(player: player)
//                        Text(player.player ?? "")
                        test(player: player)

                    }
                    .background(
                        TeamImageView(player: player)
                    )

                }
                .listRowInsets(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
            }
        
    }
}

#Preview {
    AllPlayersView()
}
