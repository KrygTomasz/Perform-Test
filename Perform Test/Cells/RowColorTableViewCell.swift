//
//  RowColorTableViewCell.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class RowColorTableViewCell: UITableViewCell {
    
    /**
     Setting this property impacts row color of given cell. The default value is 0.
     */
    var row: Int = 0 {
        didSet {
            setRowColor()
        }
    }
    
    private func setRowColor() {
        row % 2 == 0 ? (self.contentView.backgroundColor = .tint) : (self.contentView.backgroundColor = .main)
    }
    
}
