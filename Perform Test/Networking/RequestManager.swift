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
    
    typealias StandingsCompletion = (Bool, [Standing])->()
    func getStanding(completion: @escaping StandingsCompletion) {
        let request = getGetRequest(for: standingsEndpoint)
        let session = URLSession.shared
        var success: Bool = true
        var standings: [Standing] = []
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                print("dataTaskWithRequest error: \(String(describing: error))")
                success = false
                completion(success, standings)
                return
            }
            let xml = SWXMLHash.parse(dataObj)
            let rankingArray = xml["gsmrs"]["competition"]["season"]["round"]["resultstable"]["ranking"].all
            for ranking in rankingArray {
                let standing = Standing.fillWithXML(ranking.element)
                standings.append(standing)
            }
            completion(success, standings)
        }
        task.resume()
    }
    
    typealias ScoresCompletion = (Bool, [Score])->()
    func getScores(completion: @escaping ScoresCompletion) {
        let request = getGetRequest(for: scoresEndpoint)
        let session = URLSession.shared
        var success: Bool = true
        var scores: [Score] = []
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                print("dataTaskWithRequest error: \(String(describing: error))")
                success = false
                completion(success, scores)
                return
            }
            let xml = SWXMLHash.parse(dataObj)
            let groupsArray = xml["gsmrs"]["competition"]["season"]["round"]["group"].all
            for group in groupsArray {
                let matchesArray = group["match"].all
                for match in matchesArray {
                    let score = Score.fillWithXML(match.element)
                    scores.append(score)
                }
            }
            completion(success, scores)
        }
        task.resume()
    }
    
}
