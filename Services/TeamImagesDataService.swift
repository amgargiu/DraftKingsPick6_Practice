//
//  TeamImagesDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine


class TeamImagesDataService {
    
    @Published var teamImage: UIImage?
    let player : PlayerModel
    var cancellables: Set<AnyCancellable> = []

    
    init(player: PlayerModel) {
        self.player = player
        getImage()
    }
    
    
    func getImage() {
        // eventually will check FM or Cache first then call download
        downloadImage()
    }
    
    func downloadImage() {
        
        guard let urlString = player.teamImage else { return }
        guard let url = URL(string: urlString) else { return }
        
        NetworkingManager.download(url: url)
            .sink(receiveCompletion: NetworkingManager.handleSinkCompletion, receiveValue: { [weak self] imageData in
                self?.teamImage = UIImage(data: imageData)
            })
            .store(in: &cancellables)
        
    }
    
    
}
