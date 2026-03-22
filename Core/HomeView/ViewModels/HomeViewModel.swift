//
//  HomeViewModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import Foundation
import SwiftUI
import Combine



class HomeViewModel : ObservableObject {
    
    @Published var cacheManager = CacheManager.instance // make this published / give it stat instead of let...
    // for all players downloaded
    @Published var allPlayers: [PlayerModel] = []
    let playerService = PlayersDataService()
    
    @Published var games: [GameModel] = []
    let gamesService = GameModelDataService()
    var cancellables: Set<AnyCancellable> = []
    
    @Published var sports: [SportModel] = SportModelDataService.sportArray
    @Published var bannerAds: [UIImage] = []
    
    /*
    https://juzarraga.com/wp-content/uploads/2012/01/mcd_mcbites.jpg
    https://www.toyotadrummondville.com/images/ckfinder/TD-toyota,%20marque-gagnante-08-EN-B.jpg
    https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/limuemuanddouglibertymutual.jpeg
     */
    
    @Published var selectedPicks: [PickModel] = []
    @Published var pickGroups: [PickGroupModel] = [ /*DevPreview.fakeGroup, DevPreview.fakeGroup*/ ]
        
    func addGroup(currentMultiplier: String) {
        guard !selectedPicks.isEmpty else { return }
        
        let newGroup = PickGroupModel(
            title: "Pick Group",
            multiplier: currentMultiplier,
            picks: selectedPicks
        )
        
        pickGroups.append(newGroup)
        selectedPicks.removeAll()
    }
    
    // for sleected Game...
    @Published var selectedGameID: UUID? = nil
    
    
    init() {
        addSub() // for all players
    }
    
    func addSub() {
        
        
        gamesService.$games
            .sink(receiveValue: { [weak self] games in
                
                // sort by mine instead of just .sink to "players"
                self?.games = games
            })
            .store(in: &cancellables)
        
        // first make sure games are updates and we have info there - efore we try to use it to filter players
        
        playerService.$players
            .combineLatest($games, $selectedGameID)
            .map { players, games, selectedGameID -> [PlayerModel] in
                guard let game = games.first(where: { $0.id == selectedGameID }) else { return players }
                
                let filtered = players.filter { $0.team == game.homeTeam || $0.team == game.awayTeam}
                return filtered
            }
            .sink(receiveValue: { [weak self] players in
                
                // sort by mine instead of just .sink to "players"
                let sortedPlayers = players.sorted {
                    ($0.MIN ?? 0) > ($1.MIN ?? 0)
                }
                
                self?.allPlayers = sortedPlayers
            })
            .store(in: &cancellables)
        
        
//        playerService.$players
//            .sink(receiveValue: { [weak self] players in
//                
//                // sort by mine instead of just .sink to "players"
//                let sortedPlayers = players.sorted {
//                    ($0.MIN ?? 0) > ($1.MIN ?? 0)
//                }
//                
//                self?.allPlayers = sortedPlayers
//            })
//            .store(in: &cancellables)
        
        
        
    }
    
    
}
