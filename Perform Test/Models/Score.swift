//
//  Score.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import SWXMLHash

class Score {
    
    var teamAName: String = "–"
    var teamBName: String = "–"
    var teamAScore: Int = 0
    var teamBScore: Int = 0
    
    static func fillWithXML(_ xml: XMLElement?) -> Score {
        let score = Score()
        
        if let teamAName = xml?.attribute(by: "team_A_name")?.text {
            score.teamAName = teamAName
        }
        if let teamBName = xml?.attribute(by: "team_B_name")?.text {
            score.teamBName = teamBName
        }
        if let teamAScore = xml?.attribute(by: "fs_A")?.int() {
            score.teamAScore = teamAScore
        }
        if let teamBScore = xml?.attribute(by: "fs_B")?.int() {
            score.teamBScore = teamBScore
        }
        return score
    }
    
}
