//
//  PlayerImageViewModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine

class PlayerImageViewModel: ObservableObject {
    
    @Published var playerImage: UIImage?
    
    let playerImageService : PlayerImagesDataService
    let player : PlayerModel
    var cancellables: Set<AnyCancellable> = []

    
    init(player: PlayerModel) {
        self.player = player
        playerImageService = PlayerImagesDataService(player: player)
        addSub()
    }
    
    
    func addSub() {
        playerImageService.$playerImage
            .sink { [weak self] imageData in
                self?.playerImage = imageData
            }
            .store(in: &cancellables)
    }
    
    
}
