//
//  DevPreview.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import Foundation



class DevPreview {
    
    
    static let player = PlayerModel(
        player: "Victor Wembanyama",
        image: "https://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/5104157.png&w=350",
        team: "SAS",
        teamImage: "https://a.espncdn.com/i/teamlogos/nba/500/sas.png",
        position: "C",
        opp: "Sac",
        time: "8:00 PM",
        MIN: 28.9,
        FGM: 8.3,
        FGA: 16.3,
        FTM: 5.8,
        FTA: 7.1,
        threePM: 1.8,
        REB: 11.1,
        AST: 2.8,
        STL: 1.0,
        BLK: 2.7,
        TO: 2.6,
        PTS: 24.2,
        last5Min: 27.2,
        last5FGM: 7.9,
        last5FGA: 15.1,
        last5FTM: 5.2,
        last5FTA: 6.8,
        last5ThreePM: 1.4,
        last5REB: 10.3,
        last5AST: 3.1,
        last5STL: 0.8,
        last5BLK: 3.2,
        last5TO: 2.1,
        last5PTS: 22.7,
        pctRostered: 100,
        fantasyPtsTotal: 2095,
        fantasyPtsAvg: 51.1,
        injuryStatus: "Available"
    )
    
    static let game = GameModel(
            id: "1",
            homeTeam: "Heat",
            homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/mia.png",
            awayTeam: "Magic",
            awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/orl.png",
            weekday: "WED", time: "7:30 PM"
        )
    
    
}
