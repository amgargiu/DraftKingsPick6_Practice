//
//  PlayersDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import Combine


class PlayersDataService {
    
    @Published var players: [PlayerModel] = []
    var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        downloadPlayers2()
    }
    
    
    
    func downloadPlayers() {
        
        guard let url = URL(string: "https://gist.githubusercontent.com/amgargiu/2d215fa3c719c2eb6952fd1e878d9810/raw/e2a7460674712044bbec8fcd2de5bb2ca80f00d4/players-2-21-26.json") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: [PlayerModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                print("Completion:", completion)
            }, receiveValue: { [weak self] playersData in
                print("Players downloaded:", playersData.count)
                print(playersData.first ?? "No first player")
                self?.players = playersData
            })
            .store(in: &cancellables)
    }
    
    func downloadPlayers2() {
        // 1. Find the file inside the app bundle
        guard let url = Bundle.main.url(forResource: "players", withExtension: "json") else {
            print("Could not find players.json in bundle")
            return
        }
        
        // 2. Load the raw data from that file
        guard let data = try? Data(contentsOf: url) else {
            print("Could not load data from players.json")
            return
        }
        
        // 3. Decode it exactly like before
        guard let decodedPlayers = try? JSONDecoder().decode([PlayerModel].self, from: data) else {
            print("Could not decode players.json")
            return
        }
        
        // 4. Set it
        self.players = decodedPlayers
        print("Players loaded locally:", decodedPlayers.count)
    }
    
}
