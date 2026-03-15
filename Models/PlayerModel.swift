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


extension PlayerModel {
    
    // MARK: - String Unwrapping
    var displayName: String { player ?? "Unknown Player" }
    var displayTeam: String { team ?? "FA" }
    var displayPosition: String { position ?? "N/A" }
    var displayOpp: String { opp ?? "---" }
    var displayTime: String { time ?? "--:--" }
    var displayInjury: String { injuryStatus ?? "Healthy" }
    
    var abbrevName: String {
        guard let player else { return "Unknown Player" }
        let splitName = player.split(separator: " ")
        return "\(splitName[0].prefix(1).uppercased()). \(splitName[1])."
    }
    
    
    
    // MARK: - Stats (Double to String Formatting) - Unwrapping
    var ptsString: String { formatDouble(PTS) }
    var astString: String { formatDouble(AST) }
    var rebString: String { formatDouble(REB) }
    var stlString: String { formatDouble(STL) }
    var blkString: String { formatDouble(BLK) }
    var toString: String { formatDouble(TO) }
    var fgmString: String { formatDouble(FGM) }
    var fgaString: String { formatDouble(FGA) }
    var ftmString: String { formatDouble(FTM) }
    var ftaString: String { formatDouble(FTA) }
    var minString: String { formatDouble(MIN) }
    var threePMString: String { formatDouble(threePM) }
    
    // MARK: - Advanced Stats
    var rosteredString: String {
        if let pct = pctRostered {
            return String(format: "%.1f%%", pct * 100)
        }
        return "0%"
    }
    
    var fantasyTotal: String {
        if let total = fantasyPtsTotal {
            return "\(total)"
        }
        return "0"
    }
    
    var fantasyAvg: String { formatDouble(fantasyPtsAvg) }

    // MARK: - Helper Private Formatter
    private func formatDouble(_ value: Double?) -> String {
        guard let value = value else { return "0.0" }
        return String(format: "%.1f", value)
    }
}
