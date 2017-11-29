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
    
    private let urlAddress = "http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/"
    private let newsEndpoint = "latestnews.xml"
    private let scoresEndpoint = "scores.xml"
    private let standingsEndpoint = "standings.xml"
    
    private func getGetRequest(for endpoint: String) -> URLRequest {
        let fullAddress = urlAddress + endpoint
        let url = URL(string: fullAddress)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    typealias NewsCompletion = (Bool, [News])->()
    func getNews(completion: @escaping NewsCompletion) {
        let request = getGetRequest(for: newsEndpoint)
        let session = URLSession.shared
        var success: Bool = true
        var newsArray: [News] = []
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                NSLog("Error: \(String(describing: error))")
                success = false
                completion(success, newsArray)
                return
            }
            let xml = SWXMLHash.parse(dataObj)
            let items = xml["rss"]["channel"]["item"].all
            for item in items {
                let news = News.fillWithXML(item)
                newsArray.append(news)
            }
            completion(success, newsArray)
        }
        task.resume()
    }
    
    typealias StandingsCompletion = (Bool, [Standing])->()
    func getStandings(completion: @escaping StandingsCompletion) {
        let request = getGetRequest(for: standingsEndpoint)
        let session = URLSession.shared
        var success: Bool = true
        var standings: [Standing] = []
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                NSLog("Error: \(String(describing: error))")
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
    
    typealias ScoresCompletion = (Bool, [Score], Date?)->()
    func getScores(completion: @escaping ScoresCompletion) {
        let request = getGetRequest(for: scoresEndpoint)
        let session = URLSession.shared
        var success: Bool = true
        var scores: [Score] = []
        var date: Date?
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let dataObj = data else {
                NSLog("Error: \(String(describing: error))")
                success = false
                completion(success, scores, nil)
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
            let parameters = xml["gsmrs"]["method"]["parameter"].all
            for parameter in parameters {
                if
                    let name = parameter.element?.attribute(by: "name")?.text,
                    name == "date",
                    let dateObj = parameter.element?.attribute(by: "value")?.date(withFormat: "yyyy-MM-dd") {
                        date = dateObj
                }
            }
            completion(success, scores, date)
        }
        task.resume()
    }
    
}
