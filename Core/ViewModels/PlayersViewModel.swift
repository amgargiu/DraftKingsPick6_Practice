//
//  PlayersViewModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import Foundation
import Combine

class PlayersViewModel: ObservableObject {
    
    @Published var allPlayer: [PlayerModel] = []
    let playerService = PlayersDataService()
    var cancellables: Set<AnyCancellable> = []

    
    
    init() {
        addSub()
    }
    
    func addSub() {
        playerService.$players
            .sink(receiveValue: { [weak self] players in
                self?.allPlayer = players
            })
            .store(in: &cancellables)
    }
}
