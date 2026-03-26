//
//  FinalTabs.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/19/26.
//


import SwiftUI

struct FinalTabs: View {
    
    @State var selectedTab: Int = 5
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
                
                DictionaryDebugView()
                    .tag(5)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea() // 2. Tell the TabView container to ignore safe areas
            .safeAreaInset(edge: .leading) {
                Button {
                    selectedTab = 5
                } label: {
                    Circle().fill(Color.red).frame(width: 40, height: 40)
                }

            }
            
            BottomTabBarView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    FinalTabs()
}
