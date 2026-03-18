//
//  HomeView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = PlayersViewModel() // not really needed here
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var displayStat : StatType = .points
    
    // for sport picker
    @State var selectecSportID : Int = 1
    // bottom bar
    @State var selectedTab: Int = 0
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .default).autoconnect()
    @State var adTag : Int = 0
    let ads = [
        "https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/limuemuanddouglibertymutual.jpeg",
        "https://juzarraga.com/wp-content/uploads/2012/01/mcd_mcbites.jpg",
        "https://oohtoday.com/wp-content/uploads/2019/01/geico-tv-ad-lead-photo.png"
    ]
    
    // for Detail View
    @State var selectedPlayerForDetails : PlayerModel? = nil
    
    //For Gird view and maybe even testing pick prevew view
    @State private var selectedPicks: [PickModel] = []

    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 0) {
                    topBar
                    
                    ScrollView {
                        VStack {
                            banners
                                .padding(.top,5)

                            
                            
                            SportPickerView(selectedSportID: $selectecSportID)
                                .padding(.top,10)
                            
                            
                            
                            HStack {
                                
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    Image(systemName: "calendar")
                                }
                                .font(.title2)
                                .frame(maxWidth: UIScreen.main.bounds.width/5, alignment: .trailing)
                                
                                
                                ScrollView(.horizontal, showsIndicators: false)  {
                                    HStack {
                                        ForEach(GameModelDataService.mockGames) { game in
                                            GameCapsuleView(game: game)
                                        }
                                    }
                                }
                            }
                            .foregroundStyle(Color.white)
                            .padding(5)
                            .padding(.top,5)

                            
                            
                            StatPickerView(selection: $displayStat)
                                .padding(.top,5)

                            Divider()
                                .frame(height: 1) // Give it some actual thickness
                                .background(Color.gray.opacity(0.3)) // This forces the color to show
                                .offset(x: 0, y: -13)
                            
                            // 1. REMOVE THE PADDING FROM HERE
                            
                            seePicksHelper
                            PlayerGridView(
                                vm: vm,
                                selectedPicks: selectedPicks,
                                displayStat: displayStat,
                                selectedPlayerForDetails: $selectedPlayerForDetails) { player, direction in
                                    // 2. RUN THE LOGIC HERE
                                    handlePick(player: player, direction: direction)
                                }

                            // 2. ADD THIS SPACER INSTEAD
                            // This ensures there is always room to scroll past the grid
                            // You can make this dynamic: selectedPicks.isEmpty ? 20 : 120
                                    Spacer()
                                        .frame(height: selectedPicks.count == 0 ? 120 : 150)

                        }

                    } // end ScrollView
                } // end VStack
                .overlay(alignment: .bottom, content: {
                    VStack(spacing: -45) { // Negative spacing allows the orange bar to "tuck" behind the tab bar
                        testingPicks(selectedPicks: $selectedPicks)
                                .zIndex(0) // Lower layer
                            
                            BottomTabBarView(selectedTab: $selectedTab)
                                .zIndex(1) // Higher layer (stays on top)
                        }
                        // This is the magic line: it tells the whole stack to drop into the bottom notch
                })
                .sheet(item: $selectedPlayerForDetails, content: { player in
                    PlayerDetailView(player: player)
                })
                
            } // end ZStack
        } // end NaviagationStack
    }

}

#Preview {
    HomeView()
}


extension HomeView {
    
    
    
    var topBar : some View {
        HStack (alignment: .center) {
            LogoImageView()
                .frame(width: 30, height: 30)
            
            Text("NAME")
            
            Spacer()
            Image(systemName: "bell")
            Image(systemName: "person.circle")
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(
            Color(white: 0.13)
        )
        .foregroundStyle(.white)
        .bold()
    }
    
    var banners: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) { // Spacing between ads
                    ForEach(0..<ads.count, id: \.self) { index in
                        AsyncImage(url: URL(string: ads[index])) { image in
                            image.resizable()
                                 .scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(height: 120)
                        .containerRelativeFrame(.horizontal) // Makes ad responsive
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .id(index) // Required for the timer to "find" the ad
                    }
                }
                .scrollTargetLayout() // Tells the scrollview to snap to these items
            }
            .contentMargins(.horizontal, 30, for: .scrollContent) // This creates the "PEEK" effect
            .scrollTargetBehavior(.viewAligned) // The snapping magic
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    if adTag == 2 {
                        adTag = 0
                    } else {
                        adTag += 1
                    }
                    proxy.scrollTo(adTag, anchor: .center)
                }
            }
        }
        .padding(.top)
    }
    
    
    
    private func handlePick(player: PlayerModel, direction: SelectionDirection) {
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            // 1. Find if we already have a pick for this player
            let existingPick = selectedPicks.first(where: { $0.player.id == player.id }) // player id property in PickModel
            
            // 2. Remove ANY existing pick for this player regardless of direction
            selectedPicks.removeAll(where: { $0.player.id == player.id })
            
            // 3. If the new direction is DIFFERENT than the one we just removed, add it back
            // (If they were the same, we leave it removed - that's a deselection)
            if existingPick?.direction != direction {
                if selectedPicks.count < 8 {
                    let newPick = PickModel(
                        player: player,
                        statType: displayStat,
                        targetValue: 0.0,
                        direction: direction
                    )
                    selectedPicks.append(newPick)
                }
            }
        }
    }
    
    var seePicksHelper : some View {
        Group {
            Text("selectedPicks: \(selectedPicks.count)")
            ForEach(selectedPicks) { pick in
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
                    Text(pick.direction == .more ? "MORE" : "LESS")
                        .foregroundColor(pick.direction == .more ? .green : .red)
                        .fontWeight(.black)
                }
            }
        } // end group
        .foregroundStyle(.green)
    }
    
    
    
}
