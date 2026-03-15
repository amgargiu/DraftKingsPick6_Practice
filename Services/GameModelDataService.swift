//
//  GameModelDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/15/26.
//

import Foundation


class GameModelDataService {
    
    static let mockGames: [GameModel] = [
        GameModel(
            id: "1",
            homeTeam: "Heat", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/mia.png",
            awayTeam: "Magic", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/orl.png",
            weekday: "WED", time: "7:30 PM"
        ),
        GameModel(
            id: "2",
            homeTeam: "Lakers", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/lal.png",
            awayTeam: "Warriors", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/gs.png",
            weekday: "WED", time: "10:00 PM"
        ),
        GameModel(
            id: "3",
            homeTeam: "Celtics", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/bos.png",
            awayTeam: "Knicks", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/ny.png",
            weekday: "THU", time: "8:00 PM"
        ),
        GameModel(
            id: "4",
            homeTeam: "Suns", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/phx.png",
            awayTeam: "Mavericks", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/dal.png",
            weekday: "THU", time: "10:30 PM"
        ),
        GameModel(
            id: "5",
            homeTeam: "Bucks", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/mil.png",
            awayTeam: "76ers", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/phi.png",
            weekday: "FRI", time: "7:00 PM"
        ),
        GameModel(
            id: "6",
            homeTeam: "Nuggets", homeTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/den.png",
            awayTeam: "Clippers", awayTeamImage: "https://a.espncdn.com/i/teamlogos/nba/500/lac.png",
            weekday: "FRI", time: "9:30 PM"
        )
    ]
    
}
