//
//  RankingTeam.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import Foundation
import SWXMLHash

class RankingTeam {
    
    var clubName: String = ""
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
    
    static func fillWithXML(_ xml: XMLElement?) -> RankingTeam {
        let rankingTeam = RankingTeam()
        if let clubName = xml?.attribute(by: "club_name")?.text {
            rankingTeam.clubName = clubName
        }
        if let playedMatches = xml?.attribute(by: "matches_total")?.int() {
            rankingTeam.playedMatches = playedMatches
        }
        if let wins = xml?.attribute(by: "matches_won")?.int() {
            rankingTeam.wins = wins
        }
        if let draws = xml?.attribute(by: "matches_draw")?.int() {
            rankingTeam.draws = draws
        }
        if let losts = xml?.attribute(by: "matches_lost")?.int() {
            rankingTeam.losts = losts
        }
        if let goalsFor = xml?.attribute(by: "goals_pro")?.int() {
            rankingTeam.goalsFor = goalsFor
        }
        if let goalsAgainst = xml?.attribute(by: "goals_against")?.int() {
            rankingTeam.goalsAgainst = goalsAgainst
        }
        if let points = xml?.attribute(by: "points")?.int() {
            rankingTeam.points = points
        }
        return rankingTeam
    }
    
}

extension XMLAttribute {
    func int() -> Int? {
        let text = self.text
        guard let int = Int(text) else { return nil }
        return int
    }
}
