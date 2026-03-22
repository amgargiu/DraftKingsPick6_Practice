//
//  GameModelDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import Foundation
import Combine

class GameModelDataService {
    
    
    @Published var games: [GameModel] = []
    var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        downloadPlayers()
    }
    
    
    
    func downloadPlayers() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/amgargiu/DraftKingsPick6_Practice/refs/heads/data/games.json") else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: [GameModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                print("Completion:", completion)
            }, receiveValue: { [weak self] gameData in
                print("Games downloaded:", gameData.count)
                print(gameData.first ?? "No first player")
                self?.games = gameData
            })
            .store(in: &cancellables)
    }
}
