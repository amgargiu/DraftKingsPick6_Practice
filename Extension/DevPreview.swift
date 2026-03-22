//
//  DevPreview.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/9/26.
//

import Foundation



class DevPreview {
    
    
    static let player = PlayerModel(
        id: 1,
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
    
    
    
    
    // samples
    
    static let fakePick1 = PickModel(
        player: PlayerModel(
            id: 1,
            player: "LeBron James",
            image: nil,
            team: "LAL",
            teamImage: nil,
            position: "SF",
            opp: "BOS",
            time: "7:30 PM",
            MIN: nil, FGM: nil, FGA: nil, FTM: nil, FTA: nil,
            threePM: nil, REB: nil, AST: nil, STL: nil, BLK: nil, TO: nil, PTS: nil,
            last5Min: nil, last5FGM: nil, last5FGA: nil, last5FTM: nil, last5FTA: nil,
            last5ThreePM: nil, last5REB: nil, last5AST: nil, last5STL: nil, last5BLK: nil,
            last5TO: nil, last5PTS: nil,
            pctRostered: nil,
            fantasyPtsTotal: nil,
            fantasyPtsAvg: nil,
            injuryStatus: nil
        ),
        statType: .points,
        targetValue: "27.5",
        direction: .more
    )

    static let fakePick2 = PickModel(
        player: PlayerModel(
            id: 2,
            player: "Stephen Curry",
            image: nil,
            team: "GSW",
            teamImage: nil,
            position: "PG",
            opp: "PHX",
            time: "10:00 PM",
            MIN: nil, FGM: nil, FGA: nil, FTM: nil, FTA: nil,
            threePM: nil, REB: nil, AST: nil, STL: nil, BLK: nil, TO: nil, PTS: nil,
            last5Min: nil, last5FGM: nil, last5FGA: nil, last5FTM: nil, last5FTA: nil,
            last5ThreePM: nil, last5REB: nil, last5AST: nil, last5STL: nil, last5BLK: nil,
            last5TO: nil, last5PTS: nil,
            pctRostered: nil,
            fantasyPtsTotal: nil,
            fantasyPtsAvg: nil,
            injuryStatus: nil
        ),
        statType: .assists,
        targetValue: "4.5",
        direction: .more
    )

    static let fakePick3 = PickModel(
        player: PlayerModel(
            id: 3,
            player: "Jayson Tatum",
            image: nil,
            team: "BOS",
            teamImage: nil,
            position: "SF",
            opp: "LAL",
            time: "7:30 PM",
            MIN: nil, FGM: nil, FGA: nil, FTM: nil, FTA: nil,
            threePM: nil, REB: nil, AST: nil, STL: nil, BLK: nil, TO: nil, PTS: nil,
            last5Min: nil, last5FGM: nil, last5FGA: nil, last5FTM: nil, last5FTA: nil,
            last5ThreePM: nil, last5REB: nil, last5AST: nil, last5STL: nil, last5BLK: nil,
            last5TO: nil, last5PTS: nil,
            pctRostered: nil,
            fantasyPtsTotal: nil,
            fantasyPtsAvg: nil,
            injuryStatus: nil
        ),
        statType: .rebounds,
        targetValue: "8.5",
        direction: .less
    )
    
    static let fakeGroup = PickGroupModel(
        title: "Tonight’s Picks",
        multiplier: "6x",
        picks: [fakePick1, fakePick2, fakePick3]
    )
    
}
