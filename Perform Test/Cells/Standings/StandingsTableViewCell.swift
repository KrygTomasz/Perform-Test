//
//  StandingsTableViewCell.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: Outlets, variables, overrides...
class StandingsTableViewCell: RowColorTableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rankLabel: UILabel! {
        didSet {
            rankLabel.textColor = .text
        }
    }
    @IBOutlet weak var clubNameLabel: UILabel! {
        didSet {
            clubNameLabel.textColor = .text
        }
    }
    @IBOutlet weak var playedMatchesLabel: UILabel! {
        didSet {
            playedMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var wonMatchesLabel: UILabel! {
        didSet {
            wonMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var drawMatchesLabel: UILabel! {
        didSet {
            drawMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var lostMatchesLabel: UILabel! {
        didSet {
            lostMatchesLabel.textColor = .text
        }
    }
    @IBOutlet weak var goalDifferenceLabel: UILabel! {
        didSet {
            goalDifferenceLabel.textColor = .text
        }
    }
    @IBOutlet weak var pointsLabel: UILabel! {
        didSet {
            pointsLabel.textColor = .text
        }
    }
    
    var standing: Standing? {
        didSet {
            guard let standing = standing else { return }
            rankLabel.text = standing.rank
            clubNameLabel.text = standing.clubName
            playedMatchesLabel.text = "\(standing.playedMatches)"
            wonMatchesLabel.text = "\(standing.wins)"
            drawMatchesLabel.text = "\(standing.draws)"
            lostMatchesLabel.text = "\(standing.losts)"
            goalDifferenceLabel.text = "\(standing.goalDifference)"
            pointsLabel.text = "\(standing.points)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
}
