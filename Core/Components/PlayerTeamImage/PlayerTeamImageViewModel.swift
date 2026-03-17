//
//  TeamImageViewModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine

class PlayerTeamImageViewModel: ObservableObject {
    
    @Published var teamImage: UIImage?
    
    let teamImageService : PlayerTeamImagesDataService
    let player : PlayerModel
    var cancellables: Set<AnyCancellable> = []

    
    init(player: PlayerModel) {
        self.player = player
        teamImageService = PlayerTeamImagesDataService(player: player)
        addSub()
    }
    
    
    func addSub() {
        teamImageService.$playerTeamImage
            .sink { [weak self] imageData in
                self?.teamImage = imageData
            }
            .store(in: &cancellables)
    }
    
    
}
