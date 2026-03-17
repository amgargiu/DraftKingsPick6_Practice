//
//  testing.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/14/26.
//

import SwiftUI

struct testing: View {
    
    
    
    @State private var selectedCount: Int = 0
    // transtioning from above to players
    @StateObject var vm = PlayersViewModel()
    @State private var selectedPlayers: [PlayerModel] = []
    
    var currentMultiplier: String {
        switch selectedPlayers.count {
        case 2: return "4.8x"
        case 3: return "9.6x"
        case 4: return "16x"
        case 5: return "19x"
        case 6: return "40x"
        case 7: return "60x"
        case 8: return "100x"
        default: return "0x"
        }
    }
        
        var body: some View {
            
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 12) {
                    // THE HEADER LOGIC
                    headerView
                    // THE SLOTS LOGIC (Only shows if count > 0)
                    if selectedPlayers.count > 0 {
                        HStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: -5) {
                                    
                                    ForEach(0..<8, id: \.self) { index in
                                        
                                        if index < selectedPlayers.count {
                                            // Filled Slot
                                            let player = selectedPlayers[index] 
                                            PlayerCircleView(player: player)
                                                        .frame(width: 44, height: 44)
//                                            Circle()
//                                                .stroke(style: StrokeStyle(lineWidth: 2))
//                                                .foregroundColor(.white)
//                                                .frame(width: 40, height: 40)
//                                                .background(Circle().fill(Color.orange))
//                                                .shadow(color: .black.opacity(0.3), radius: 2)
//                                                .overlay(Text("👤").font(.caption))
                                            
                                        } else if index < (selectedPlayers.count + 1) || selectedPlayers.count >= 2 {
                                            // Dotted Slot (Show 1 extra if building, or ALL if valid)
                                            Circle()
                                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                                                .foregroundColor(.white.opacity(0.6))
                                                .frame(width: 40, height: 40)
                                                .background(Circle().fill(selectedPlayers.count == 1 ? Color.brown : Color.orange))
                                                .shadow(color: .black.opacity(0.3), radius: 2)
                                                .overlay(
                                                    Group {
                                                        if selectedPlayers.count == 1 {
                                                            Image(systemName: "plus").foregroundStyle(.white.opacity(0.6))
                                                        } else {
                                                            multiplierLabel(for: index)
                                                        }
                                                    }
                                                )
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                } // end HStack
                                .padding(.vertical,2)
                                .padding(.horizontal,2)
                            } // End ScrollView
                            .frame(maxWidth: .infinity)

                            
//                            Spacer()
                            
                            Color.clear
                                .frame(width: UIScreen.main.bounds.width*0.4, height: 20)
                                .overlay(
                                    Group {
                                        if selectedPlayers.count == 1 {
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
                                        } else {
                                            Button(action: {
                                                    print("Submit Pressed")
                                                }) {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(.white)
                                                        .frame(width: 150, height: 50)
                                                        .overlay(
                                                            VStack(spacing: 0) {
                                                                HStack(spacing: 4) {
                                                                    Image(systemName: "bolt.fill")
                                                                        .foregroundStyle(.orange)
                                                                    Text(currentMultiplier)
                                                                }
                                                                .font(.system(size: 18, weight: .bold))
                                                                
                                                                Text("Or More!")
                                                                    .font(.system(size: 14, weight: .semibold).italic())
                                                            }
                                                            .foregroundColor(Color(#colorLiteral(red: 0.7967509921, green: 0.5009445243, blue: 0.1730350623, alpha: 1)))
                                                        )
                                                }
                                        }
                                    }
                                        )
                            
                        } // end Main HStack
           
                    }


                } // end Vtsack
                .padding([.leading, .trailing, .bottom], 20)
                .padding(.bottom, 40)
                // DYNAMIC STYLING
                .background(
                    RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(
                                    colors: selectedPlayers.count >= 2
                                        ? [Color(#colorLiteral(red: 0.8746507669, green: 0.5210690997, blue: 0.2556014708, alpha: 1)), Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))] // Bright Orange
                                        : [Color(#colorLiteral(red: 0.3604600694, green: 0.2833285628, blue: 0.05178363906, alpha: 1)), Color(#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1))], // Dull Brown
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        if selectedPlayers.count < 8 {
                            // 1. Grab a random player from the VM data
                            if let randomPlayer = vm.allPlayers.randomElement() {
                                
                                // 2. Add them to the array (this triggers the UI update)
                                selectedPlayers.append(randomPlayer)
                            }
                        } else {
                            // 3. Reset when we hit the max for testing purposes
                            selectedPlayers.removeAll()
                        }
                    }
                }
            
//            .padding(.bottom, 400) // Keeps it above your Bottom Tab Bar

        }
        
    
    
    
        var headerView: some View {
            HStack {
                if selectedPlayers.count == 0 {
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
                        
                        
                    }
                    .padding(.top,15)
                }
                
                
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
        }
        
        @ViewBuilder
        func multiplierLabel(for index: some BinaryInteger) -> some View {
            // Only show multipliers (3x, 6x...) if valid (count >= 2)
            if selectedPlayers.count >= 2 {
                Text("\(index*3-1)x")
                    .font(.system(size: 8))
                    .foregroundColor(.white)
            }
        }}

#Preview {
    testing()
}
