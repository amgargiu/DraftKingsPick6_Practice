//
//  SportPickerView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct SportPickerView: View {
    // Binding allows the HomeView to know which sport is picked
    @Binding var selectedSportID: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                // Using the specific array you provided
                ForEach(SportModelDataService.sportArray) { sport in
                    VStack(spacing: 8) {
                        ZStack {
                            // 1. THE CIRCLE BACKGROUND
                            Circle()
                                .fill(selectedSportID == sport.id ?
                                      LinearGradient(colors: [.black, .orange], startPoint: .top, endPoint: .bottom) :
                                      LinearGradient(colors: [Color(white: 0.15)], startPoint: .top, endPoint: .bottom))
                                .frame(width: 45, height: 45)
                            
                            // 2. THE ORANGE STROKE (Only when selected)
                            Circle()
                                .stroke(selectedSportID == sport.id ? Color.orange : Color.clear, lineWidth: 2)
                                .frame(width: 45, height: 45)
                            
                            // 3. THE ICON FROM YOUR ARRAY
                            Image(systemName: sport.image)
                                .font(.system(size: 22))
                                .foregroundColor(selectedSportID == sport.id ? .white : .gray)
                        }
                        
                        // 4. THE NAME FROM YOUR ARRAY
                        Text(sport.name)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedSportID = sport.id
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 1)
        }
    }
}

#Preview {
    SportPickerView(selectedSportID: .constant(1))
        .background(Color.black) // Matches your HomeView theme

}
