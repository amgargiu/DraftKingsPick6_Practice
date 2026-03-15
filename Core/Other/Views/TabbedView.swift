//
//  TabbedView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import SwiftUI

struct TabbedView: View {
    
    @State var selectedTab: Int = 0
    
    
    
    var body: some View {
        
        Picker("Selection", selection: $selectedTab) {
            Text("All").tag(0)
            Text("Card").tag(1)
            Text("Player").tag(2)
            Text("Team").tag(3)
        }
        .pickerStyle(.segmented) // The magic modifier
        .padding() // Give it some room from the screen edges
        
        
        TabView(selection: $selectedTab) {
            
            AllPlayersView()
                .tag(0)
            
            PlayerCardView(player: DevPreview.player)
                .tag(1)
            
            PlayerImageView(player: DevPreview.player)
                .clipped()
                .tag(2)
            
            TeamImageView(player: DevPreview.player)
                .clipped()
                .tag(3)
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never)) // This is the magic line
        
    }
}

#Preview {
    TabbedView()
}
