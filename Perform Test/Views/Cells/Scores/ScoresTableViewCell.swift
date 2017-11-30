//
//  ScoresTableViewCell.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: Outlets, variables, overrides...
class ScoresTableViewCell: RowColorTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamANameLabel: UILabel! {
        didSet {
            teamANameLabel.textColor = .text
        }
    }
    @IBOutlet weak var teamBNameLabel: UILabel! {
        didSet {
            teamBNameLabel.textColor = .text
        }
    }
    @IBOutlet weak var middleScoreView: UIView! {
        didSet {
            middleScoreView.backgroundColor = UIColor.text.withAlphaComponent(0.1)
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.textColor = .text
        }
    }
    
    var score: Score? {
        didSet {
            prepareView(using: score)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func prepareView(using score: Score?) {
        guard let score = score else { return }
        teamANameLabel.text = score.teamAName
        teamBNameLabel.text = score.teamBName
        scoreLabel.text = "\(score.teamAScore) : \(score.teamBScore)"
    }
    
}
