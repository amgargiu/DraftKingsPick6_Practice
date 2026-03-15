//
//  HomeView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = PlayersViewModel()
    
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
                                .frame(height: 2) // Give it some actual thickness
                                .background(Color.gray) // This forces the color to show
                            PlayerGridView(displayStat: $displayStat)

                        }
                    } // end ScrollView
                } // end VStack
                .overlay(alignment: .bottom, content: {
                    VStack(spacing: -45) { // Negative spacing allows the orange bar to "tuck" behind the tab bar
                        testing()
                                .zIndex(0) // Lower layer
                            
                            BottomTabBarView(selectedTab: $selectedTab)
                                .zIndex(1) // Higher layer (stays on top)
                        }
                        // This is the magic line: it tells the whole stack to drop into the bottom notch
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
}
