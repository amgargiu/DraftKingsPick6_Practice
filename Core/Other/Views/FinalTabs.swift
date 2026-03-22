//
//  FinalTabs.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/19/26.
//


import SwiftUI

struct FinalTabs: View {
    
    @State var selectedTab: Int = 0
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                HomeView(vm: vm)
                    .tag(0)
                
                PicksView(vm: vm)
                    .tag(1)
                
                PlayerImageView(player: DevPreview.player)
                    .tag(2)
                
                PlayerTeamImageView(player: DevPreview.player)
                    .tag(3)
                
                RewardsView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            BottomTabBarView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    FinalTabs()
}
