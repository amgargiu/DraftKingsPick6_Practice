//
//  PlayerImageView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct PlayerImageView: View {
    
    let player: PlayerModel
    @StateObject var vm : PlayerImageViewModel
    
    init(player: PlayerModel) {
        self.player = player
        _vm = StateObject(wrappedValue: PlayerImageViewModel(player: player))
    }
    
    var body: some View {
        
        ZStack {
            if let image = vm.playerImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        
        
    }
}

#Preview {
    PlayerImageView(player: DevPreview.player)
}
