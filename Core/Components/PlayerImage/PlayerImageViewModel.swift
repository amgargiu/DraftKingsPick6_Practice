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
    
    @Published var playerImage: UIImage? = nil // dont even need this or the closure anymore....
    
    // We no longer store/init the service here, so 88 services vanish from RAM
    private let player: PlayerModel
    private var cancellables = Set<AnyCancellable>()
    let playerImageService = PlayerImagesDataService.shared

    init(player: PlayerModel) { // still need a player model on View init
        self.player = player
        getImage()
    }
    
    func getImage() {
        // We call the SINGLETON shared instance
        // This uses the "Tool" without creating a new "Worker" class
        playerImageService.getImage(
            urlString: player.image,
            displayName: player.displayName
        ) { [weak self] returnedImage in
            // When the image comes back (from FM or Web), we update the UI
            DispatchQueue.main.async {
                self?.playerImage = returnedImage
            }
        }
    }
}




//class PlayerImageViewModel: ObservableObject {
//    
//    @Published var playerImage: UIImage?
//    
//    let playerImageService : PlayerImagesDataService
//    let player : PlayerModel
//    var cancellables: Set<AnyCancellable> = []
//
//    
//    init(player: PlayerModel) {
//        self.player = player
//        playerImageService = PlayerImagesDataService(player: player)
//        addSub()
//    }
//    
//    
//    func addSub() {
//        playerImageService.$playerImage
//            .sink { [weak self] imageData in
//                self?.playerImage = imageData
//            }
//            .store(in: &cancellables)
//    }
//    
//    
//}
