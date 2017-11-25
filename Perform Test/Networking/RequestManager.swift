//
//  RequestManager.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 25.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import Foundation
import SWXMLHash

class RequestManager {
    
    private let scoresEndpoint = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/scores.xml"
    private let standingsEndpoint = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/standings.xml"
    
    private func getGetRequest(for endpoint: String) -> URLRequest {
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    typealias TeamRankingCompletion = ([RankingTeam])->()
    func getTeamRanking(completion: @escaping TeamRankingCompletion) {
        let request = getGetRequest(for: standingsEndpoint)
        let session = URLSession.shared
        var rankingTeams: [RankingTeam] = []
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                print("dataTaskWithRequest error: \(String(describing: error))")
                completion(rankingTeams)
                return
            }
            let xml = SWXMLHash.parse(dataObj)
            let rankingArray = xml["gsmrs"]["competition"]["season"]["round"]["resultstable"]["ranking"].all
            for ranking in rankingArray {
                let rankingTeam = RankingTeam.fillWithXML(ranking.element)
                rankingTeams.append(rankingTeam)
            }
            completion(rankingTeams)
        }
        task.resume()
    }
    
}
