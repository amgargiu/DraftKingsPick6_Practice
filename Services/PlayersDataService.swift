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
        downloadPlayers()
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
    
}
