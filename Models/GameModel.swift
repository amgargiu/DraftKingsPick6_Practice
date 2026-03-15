//
//  GameModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import Foundation


struct GameModel: Identifiable {
    let id: String
    let homeTeam: String
    let homeTeamImage: String
    let awayTeam: String
    let awayTeamImage: String
    let weekday: String
    let time: String
}
