//
//  PlayerModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation


struct PlayerModel: Identifiable, Codable, Hashable {
    
    let id: UUID = UUID()
    
    let player, image, team, teamImage, position, opp, time: String?
    
    let MIN, FGM, FGA, FTM, FTA, threePM, REB, AST, STL, BLK, TO, PTS: Double?
    
    let pctRostered: Double?
    let fantasyPtsTotal: Int?
    
    let fantasyPtsAvg: Double?
    
    let injuryStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case player, image, team, teamImage, position, opp, time
        case MIN, FGM, FGA, FTM, FTA, REB, AST, STL, BLK, TO, PTS
        case pctRostered, fantasyPtsTotal, fantasyPtsAvg, injuryStatus
        case threePM = "3PM"
    }
}
