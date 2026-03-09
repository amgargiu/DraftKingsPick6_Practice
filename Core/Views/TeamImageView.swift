//
//  TeamImageView.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import SwiftUI

struct TeamImageView: View {
    let player: PlayerModel
    @StateObject var vm : TeamImageViewModel
    
    init(player: PlayerModel) {
        self.player = player
        _vm = StateObject(wrappedValue: TeamImageViewModel(player: player))
    }
    
    var body: some View {
        
        ZStack {
            if let image = vm.teamImage {
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
    TeamImageView(player: DevPreview.player)
}
