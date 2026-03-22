//
//  PlayerImageView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI


struct PlayerImageView: View {
    let player: PlayerModel
    @State private var image: UIImage? = nil // Simple property, not a whole Class

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image).resizable().scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            // Call the Singleton directly
            PlayerImagesDataService.shared.getImage(urlString: player.image, displayName: player.displayName ?? "") { returnedImage in
                self.image = returnedImage
            }
        }
        .onDisappear {
            self.image = nil // Release the RAM immediately
        }
    }
}


//
//struct PlayerImageView: View {
//    
//    let player: PlayerModel
//    @StateObject var vm : PlayerImageViewModel
//    
//    init(player: PlayerModel) {
//        self.player = player
//        _vm = StateObject(wrappedValue: PlayerImageViewModel(player: player))
//    }
//    
//    var body: some View {
//        
//        ZStack {
//            if let image = vm.playerImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            // If the user scrolls back up, tell the VM to
//            // re-load the image from the FileManager
//            vm.getImage()
//        }
//        .onDisappear {
//            // When the player leaves the screen,
//            // kill the UIImage in RAM.
//            vm.playerImage = nil
//        }
//    }
//}

#Preview {
    PlayerImageView(player: DevPreview.player)
}
