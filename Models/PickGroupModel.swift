//
//  PickGroupModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/19/26.
//

import Foundation

struct PickGroupModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let multiplier : String
    let picks: [PickModel]
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: PickGroupModel, rhs: PickGroupModel) -> Bool {
            lhs.id == rhs.id
        }
}
