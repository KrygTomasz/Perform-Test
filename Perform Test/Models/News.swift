//
//  News.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 27.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import SWXMLHash

class News {
    
    var title: String = ""
    var pubDate: Date?
    var imageURL: URL?
    var description: String = ""
    var linkURL: URL?
    
    static func fillWithXML(_ xmlIndexer: XMLIndexer) -> News {
        let news = News()
        let titleXml = xmlIndexer["title"]
        if let title = titleXml.element?.text {
            news.title = title
        }
        let pubDateXml = xmlIndexer["pubDate"]
        let rfc822Format = "EEE, dd MMM yyyy HH:mm:ss z"
        if let pubDate = pubDateXml.element?.date(withFormat: rfc822Format) {
            news.pubDate = pubDate
        }
        let imageXml = xmlIndexer["enclosure"].element
        if let imageLink = imageXml?.attribute(by: "url")?.text {
            let url = URL(string: imageLink)
            news.imageURL = url
        }
        let linkXml = xmlIndexer["link"]
        if let link = linkXml.element?.text {
            let url = URL(string: link)
            news.linkURL = url
        }
        return news
    }
    
    func getDateString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = pubDate else { return "" }
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

