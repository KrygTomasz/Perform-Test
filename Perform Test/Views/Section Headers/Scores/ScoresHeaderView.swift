//
//  ScoresHeaderView.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class ScoresHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .darkMain
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .text
        }
    }
    
    var dateString: String = "" {
        didSet {
            dateLabel.text = dateString
        }
    }

}
