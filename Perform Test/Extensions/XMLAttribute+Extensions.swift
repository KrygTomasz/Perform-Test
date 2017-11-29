//
//  XMLAttribute+Extensions.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import SWXMLHash

extension XMLAttribute {
    
    func int() -> Int? {
        let text = self.text
        guard let int = Int(text) else { return nil }
        return int
    }
    
    func date(withFormat format: String) -> Date? {
        let dateString = self.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
}

extension XMLElement {
    
    func date(withFormat format: String) -> Date? {
        let dateString = self.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
}
