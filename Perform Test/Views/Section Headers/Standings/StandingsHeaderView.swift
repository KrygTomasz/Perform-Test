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
            clubLabel.text = R.string.localizable.club()
            clubLabel.textColor = .text
        }
    }
    @IBOutlet weak var playedMatchesLabel: UILabel! {
        didSet {
            playedMatchesLabel.text = R.string.localizable.playedMatchesShortcut()
            playedMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var winsLabel: UILabel! {
        didSet {
            winsLabel.text = R.string.localizable.winsShortcut()
            winsLabel.textColor = .text
        }
    }
    @IBOutlet weak var drawsLabel: UILabel! {
        didSet {
            drawsLabel.text = R.string.localizable.drawsShortcut()
            drawsLabel.textColor = .text
        }
    }
    @IBOutlet weak var lostsLabel: UILabel! {
        didSet {
            lostsLabel.text = R.string.localizable.lostsShortcut()
            lostsLabel.textColor = .text
        }
    }
    @IBOutlet weak var goalDiferenceLabel: UILabel! {
        didSet {
            goalDiferenceLabel.text = R.string.localizable.goalDifferenceShortcut()
            goalDiferenceLabel.textColor = .text
        }
    }
    @IBOutlet weak var pointsLabel: UILabel! {
        didSet {
            pointsLabel.text = R.string.localizable.pointsShortcut()
            pointsLabel.textColor = .text
        }
    }
    
}
