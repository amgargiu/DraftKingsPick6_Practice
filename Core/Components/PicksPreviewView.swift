//
//  PicksPreviewView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct PicksPreviewView: View {
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Spacer() // This is the secret—it anchors the view to the bottom
            
            VStack(alignment: .center) {
                if !isExpanded {
                    // --- COLLAPSED STATE ---
                    HStack {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.up")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Text("MAKE 2+ PICKS")
                            .font(.system(size: 16, weight: .black))
                            .italic()
                            .overlay {
                                // The gradient we want for the letters
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                // This "cuts out" the text from the gradient
                                .mask(
                                    Text("MAKE 2+ PICKS")
                                        .font(.system(size: 16, weight: .black))
                                        .italic()
                                )
                            }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.up") // Pointing up to show direction
                    }
                    .foregroundColor(.white)
                    .padding()
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .bottom)),
                        removal: .opacity.combined(with: .move(edge: .top))
                    ))
                } else {
                    // --- EXPANDED STATE ---
                    VStack(spacing: 20) {
                        Text("SELECT YOUR LINEUP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 15) {
                            ForEach(1...5, id: \.self) { _ in
                                Circle()
                                    .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                    .frame(width: 45, height: 45)
                                    .overlay(Text("+").foregroundColor(.white))
                            }
                        }
                    }
                    .padding(.top, 10)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity.combined(with: .move(edge: .bottom))
                    ))
                }
            }
            .frame(maxWidth: .infinity)
            // Taller heights: 60 when closed, 140 when open
            .frame(height: isExpanded ? 140 : 60, alignment: .top)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.6, green: 0.3, blue: 0.1)) // Deep Burnt Orange
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 100) // Keeps it above your Bottom Tab Bar
    }
}

#Preview {
    PicksPreviewView()
}
