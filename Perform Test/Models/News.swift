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
    var pubDate: String = ""
    var description: String = ""
    var link: String = ""
    
    static func fillWithXML(_ xmlIndexer: XMLIndexer) -> News {
        let news = News()
        let titleXml = xmlIndexer["title"]
        if let title = titleXml.element?.text {
            news.title = title
        }
        let pubDateXml = xmlIndexer["pubDate"]
        if let pubDate = pubDateXml.element?.text {
            news.pubDate = pubDate
        }
        let descriptionXml = xmlIndexer["description"]
        if let description = descriptionXml.element?.text {
            news.description = description
        }
        let linkXml = xmlIndexer["link"]
        if let link = linkXml.element?.text {
            news.link = link
        }
        return news
    }
    
}

