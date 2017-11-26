//
//  Standing.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import SWXMLHash

class Standing {
    
    var rank: String = "00"
    var clubName: String = "–"
    var playedMatches: Int = 0
    var wins: Int = 0
    var draws: Int = 0
    var losts: Int = 0
    var goalsFor: Int = 0
    var goalsAgainst: Int = 0
    var goalDifference: Int {
        get {
            return goalsFor - goalsAgainst
        }
    }
    var points: Int = 0
    
    static func fillWithXML(_ xml: XMLElement?) -> Standing {
        let standing = Standing()
        if let rank = xml?.attribute(by: "rank")?.text {
            standing.rank = rank
        }
        if let clubName = xml?.attribute(by: "club_name")?.text {
            standing.clubName = clubName
        }
        if let playedMatches = xml?.attribute(by: "matches_total")?.int() {
            standing.playedMatches = playedMatches
        }
        if let wins = xml?.attribute(by: "matches_won")?.int() {
            standing.wins = wins
        }
        if let draws = xml?.attribute(by: "matches_draw")?.int() {
            standing.draws = draws
        }
        if let losts = xml?.attribute(by: "matches_lost")?.int() {
            standing.losts = losts
        }
        if let goalsFor = xml?.attribute(by: "goals_pro")?.int() {
            standing.goalsFor = goalsFor
        }
        if let goalsAgainst = xml?.attribute(by: "goals_against")?.int() {
            standing.goalsAgainst = goalsAgainst
        }
        if let points = xml?.attribute(by: "points")?.int() {
            standing.points = points
        }
        return standing
    }
    
}
