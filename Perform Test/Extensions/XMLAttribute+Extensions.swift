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
}
