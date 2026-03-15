//
//  BottomTabBarView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct BottomTabBarView: View {
    
    
    @Binding var selectedTab: Int
    
    // The items for our bar - TUPLES
    let tabs = [
        ("Home", "house.fill"),
        ("My Picks", "checkmark.seal.fill"),
        ("Draft", "plus.app.fill"),
        ("Invite", "person.badge.plus.fill"),
        ("Rewards", "gift.fill")
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Spacer()
                
                Button {
                    selectedTab = index
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].1)
                            .font(.system(size: 22))
                            // ICON TURNS GREEN ON SELECT
                            .foregroundColor(selectedTab == index ? .green : .gray)
                        
                        Text(tabs[index].0)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(selectedTab == index ? .white : .gray)
                    }
                }
                
                Spacer()
            }
        }
        .frame(height: 65)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [.black , Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]),
                        center: .topLeading,
                        angle: .degrees(225))
                )
                .ignoresSafeArea() // lets color bleed into safe area
        ) // Dark betting-app theme
    }
}

#Preview {
    BottomTabBarView(selectedTab: .constant(0))
}
