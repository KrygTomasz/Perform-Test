//
//  StandingsHeaderView.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class StandingsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .darkMain
        }
    }
    @IBOutlet weak var clubLabel: UILabel! {
        didSet {
            clubLabel.text = "Club"
            clubLabel.textColor = .text
        }
    }
    @IBOutlet weak var playedMatchesLabel: UILabel! {
        didSet {
            playedMatchesLabel.text = "P"
            playedMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var winsLabel: UILabel! {
        didSet {
            winsLabel.text = "W"
            winsLabel.textColor = .text
        }
    }
    @IBOutlet weak var drawsLabel: UILabel! {
        didSet {
            drawsLabel.text = "D"
            drawsLabel.textColor = .text
        }
    }
    @IBOutlet weak var lostsLabel: UILabel! {
        didSet {
            lostsLabel.text = "L"
            lostsLabel.textColor = .text
        }
    }
    @IBOutlet weak var goalDiferenceLabel: UILabel! {
        didSet {
            goalDiferenceLabel.text = "GD"
            goalDiferenceLabel.textColor = .text
        }
    }
    @IBOutlet weak var pointsLabel: UILabel! {
        didSet {
            pointsLabel.text = "Pts"
            pointsLabel.textColor = .text
        }
    }
    
}
