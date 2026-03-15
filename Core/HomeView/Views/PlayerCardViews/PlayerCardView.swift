//
//  PlayerCardView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/11/26.
//

import SwiftUI

struct PlayerCardView: View {
    
    let player: PlayerModel
    
    
    
    var body: some View {
        
        
        
        VStack {
            
            ZStack (alignment: .top) {

                Color.clear
                    .overlay(
                        TeamImageView(player: player)
                            .scaledToFit()
                            .frame(width: 200, height: 200) // Scaled for grid width
                            .opacity(0.12)
                            .offset(x: 50, y: -20),
                        alignment: .topTrailing
                    )
                
                
                VStack {
                    
                    VStack(spacing: 0) {
                        PlayerImageView(player: player)
                            .scaledToFit()
                            .frame(minHeight: 80, maxHeight: 160) // Adaptive height
                            .padding(.vertical, -4)
                        HStack {
                            TeamImageView(player: player)
                                .frame(width: 20, height: 20)
                            Text(player.abbrevName)
                                .font(.system(size: 14, weight: .bold)) // Adaptive size
                                .lineLimit(1)

                            Text(player.displayPosition)
                                .font(.system(size: 12))
                                .opacity(0.6)
                        }
                        .bold()
                        .fontDesign(.rounded)
                        .shadow(color: Color(.black), radius: 5, x: 0, y: 0)
                        
                        HStack {
                            Text(player.displayTeam)
                                .bold()
                            Text("@")
                            Text(player.displayOpp)
                        }
                        
                        HStack {
                            let day = Date().formatted(.dateTime.weekday(.abbreviated))
                            Text(day)
                            Text(player.displayTime)
                        }
                        
                    }
                    // img - name - pos
                    
                    
                    // team - number - opp - ht
                    
                    // dotted line or long rectangle
                    
                    VStack {
                        Divider()
                        
                        HStack {
                            
                            Image(systemName: "minus")
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(lineWidth: 2)
                                        .opacity(0.5)
                                        .frame(width: 28, height: 28)
                                )
                            Spacer()
                            Text(player.ptsString)
                                .font(.title3)
                                .bold()
                            Spacer()
                            Image(systemName: "plus")
                                .background(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(lineWidth: 2)
                                        .opacity(0.5)
                                        .frame(width: 28, height: 28)
                                )
                        } // end H
                        .padding(.horizontal, 10)

                        
                    }
                    
                    
                    
                    Text("Points")
                    
                    HStack (spacing: 5) {
                        
                        RoundedRectangle(cornerRadius: 17)
                            .fill(Color(.gray)).opacity(0.2)
                            .overlay {
                                HStack {
                                    Image(systemName: "arrow.up")
                                    Text("More")
                                        .font(Font.title3.bold())
                                }
                            }
                        RoundedRectangle(cornerRadius: 17)
                            .fill(Color(.gray)).opacity(0.2)
                            .overlay {
                                HStack {
                                    Image(systemName: "arrow.down")
                                    Text("Less")
                                        .font(Font.title3.bold())
                                }
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    
                }
                .foregroundStyle(Color(.white))
                
                
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(white: 0.08))
            )
        }
   
    }
}

//struct PlayerCardView: View {
//    
//    let player: PlayerModel
//    
//    
//    
//    var body: some View {
//        
//        
//        
//        ZStack {
//            
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color(.black).opacity(0.9))
//                .frame(width: 370, height: 410)
//                .overlay(alignment: .trailing) {
//                    TeamImageView(player: player)
//                        .frame(width: 300, height: 400)
//                        .scaledToFit()
//                        .opacity(0.1)
//                        .offset(x: 80, y: -100)
//                        .clipped()
//                }
//
//            
//            
//            
//            VStack {
//                
//                VStack(spacing: 0) {
//                    PlayerImageView(player: player)
//                        .frame(width: 100, height: 160)
//                        .padding(.vertical, -7)
//                    HStack {
//                        TeamImageView(player: player)
//                            .frame(width: 40, height: 30)
//                            .scaledToFit()
//                        Text(player.abbrevName)
//                        Text(player.displayPosition)
//                            .opacity(0.6)
//                    }
//                    .bold()
//                    .font(.title3)
//                    .fontDesign(.rounded)
//                    .shadow(color: Color(.black), radius: 5, x: 0, y: 0)
//
//                }
//                // img - name - pos
//                
//                
//                // team - number - opp - ht
//                HStack {
//                    Text(player.displayTeam)
//                        .bold()
//                    Text("@")
//                    Text(player.displayOpp)
//                }
//                
//                HStack {
//                    let day = Date().formatted(.dateTime.weekday(.abbreviated))
//                    Text(day)
//                    Text(player.displayTime)
//                }
//                // dotted line or long rectangle
//
//                Rectangle()
//                    .fill(.gray)
//                    .frame(maxWidth: 320, maxHeight: 1)
//                
//                HStack {
//                    
//                    Image(systemName: "minus")
//                        .background(
//                            RoundedRectangle(cornerRadius: 7)
//                                .stroke(lineWidth: 2)
//                                .opacity(0.5)
//                                .frame(width: 28, height: 28)
//                        )
//                    Spacer()
//                    Text(player.ptsString)
//                        .font(.title)
//                        .bold()
//                    Spacer()
//                    Image(systemName: "plus")
//                        .background(
//                            RoundedRectangle(cornerRadius: 7)
//                                .stroke(lineWidth: 2)
//                                .opacity(0.5)
//                                .frame(width: 28, height: 28)
//                        )
//                }
//                .frame(width: 300)
//                
//                Text("Points")
//                
//                HStack (spacing: 5) {
//                    
//                    RoundedRectangle(cornerRadius: 17)
//                        .fill(Color(.gray)).opacity(0.2)
//                        .overlay {
//                            HStack {
//                                Image(systemName: "arrow.up")
//                                Text("More")
//                                    .font(Font.title3.bold())
//                            }
//                        }
//                    RoundedRectangle(cornerRadius: 17)
//                        .fill(Color(.gray)).opacity(0.2)
//                        .overlay {
//                            HStack {
//                                Image(systemName: "arrow.down")
//                                Text("Less")
//                                    .font(Font.title3.bold())
//                            }
//                        }
//                }
//                .frame(width: 350, height: 60)
//                
//            }
//            .foregroundStyle(Color(.white))
//            
//            
//            
//        }
//   
//    }
//}

#Preview {
    PlayerCardView(player: DevPreview.player)
}

extension PlayerCardView {
    
}
