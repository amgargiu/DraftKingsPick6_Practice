//
//  GameModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import Foundation


struct GameModel: Identifiable, Codable {
    let id: UUID = UUID()
    let homeTeam: String
    let awayTeam: String
    let time: String
}
