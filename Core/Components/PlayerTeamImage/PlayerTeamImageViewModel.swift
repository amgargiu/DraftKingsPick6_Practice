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
    
    @Published var teamImage: UIImage? = nil
    @Published var teamdict = PlayerTeamImagesDataService.shared.teamdict
    
    
    // We no longer store/init the service here, so 88 services vanish from RAM
    private let player: PlayerModel
    private var cancellables = Set<AnyCancellable>()
    let teamImageService : PlayerTeamImagesDataService = PlayerTeamImagesDataService.shared
    

    init(player: PlayerModel) { // still need a player model on View init
        self.player = player
        getImage()
    }
    
    func getImage() {
        // We call the SINGLETON shared instance
        // This uses the "Tool" without creating a new "Worker" class
        teamImageService.getTeamImages(
            urlString: player.teamImage,
            displayTeam: player.displayTeam
        ) { [weak self] returnedImage in
            // When the image comes back (from FM or Web), we update the UI
            DispatchQueue.main.async {
                self?.teamImage = returnedImage
            }
        }
    }
}



//class PlayerTeamImageViewModel: ObservableObject {
//    
//    @Published var teamImage: UIImage?
//    
//    let teamImageService : PlayerTeamImagesDataService
//    let player : PlayerModel
//    var cancellables: Set<AnyCancellable> = []
//
//    
//    init(player: PlayerModel) {
//        self.player = player
//        teamImageService = PlayerTeamImagesDataService(player: player)
//        addSub()
//    }
//    
//    
//    func addSub() {
//        teamImageService.$playerTeamImage
//            .sink { [weak self] imageData in
//                self?.teamImage = imageData
//            }
//            .store(in: &cancellables)
//    }
//    
//    
//}
