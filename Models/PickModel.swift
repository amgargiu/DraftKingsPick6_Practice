//
//  PickModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import Foundation


enum SelectionDirection {
    case more, less
}

struct PickModel: Identifiable, Equatable {
    // This ensures the "Pick" ID is the same as the "Player" ID
    // 1. The ID is now a combination of Name + Stat
        // Example: "LeBron James-points"
    var id: String {
            "\(player.player ?? "Unknown")-\(statType.rawValue)"
    }
    
    let player: PlayerModel
    let statType: StatType
    let targetValue: String
    var direction: SelectionDirection

    static func == (lhs: PickModel, rhs: PickModel) -> Bool {
        return lhs.id == rhs.id && lhs.direction == rhs.direction
    }
}
