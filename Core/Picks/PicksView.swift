//
//  PicksView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/18/26.
//

import SwiftUI

struct PicksView: View {
    
//    @StateObject var vm = PicksViewModel()
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.pickGroups) { group in
                    
                    
                    
                    Text(group.title)
                        .bold()
                        .underline(true)
                    Text(group.multiplier)
                        .bold()
                        .underline(true)
                    ForEach(group.picks, id: \.id) { pick in
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
                            Text(pick.targetValue)
                                .foregroundStyle(pick.direction == .more ? .blue : .red)
                            Text(pick.direction == .more ? "MORE" : "LESS")
                                .foregroundColor(pick.direction == .more ? .green : .red)
                                .fontWeight(.black)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PicksView(vm: HomeViewModel())
}
