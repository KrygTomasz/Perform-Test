//
//  ViewController.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 25.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsDropDownView: DropDownSectionView! {
        didSet {
            newsDropDownView.title = "News"
            newsDropDownView.isHidden = true
            newsDropDownView.appTheme()
            newsDropDownView.delegate = self
        }
    }
    @IBOutlet weak var scoresDropDownView: DropDownSectionView! {
        didSet {
            scoresDropDownView.title = "Scores"
            scoresDropDownView.isHidden = true
            scoresDropDownView.appTheme()
            scoresDropDownView.delegate = self
        }
    }
    @IBOutlet weak var standingsDropDownView: DropDownSectionView! {
        didSet {
            standingsDropDownView.title = "Standings"
            standingsDropDownView.isHidden = true
            standingsDropDownView.appTheme()
            standingsDropDownView.delegate = self
        }
    }
    @IBOutlet weak var dropDownSeparatorView: UIView! {
        didSet {
            dropDownSeparatorView.backgroundColor = .text
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .main
        }
    }
    
    private var rankingTeams: [RankingTeam] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .tint
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .main
        self.navigationController?.navigationBar.tintColor = .text
        self.navigationController?.navigationBar.topItem?.title = "Perform Test"
        let expandImage = R.image.expand()?.resize(to: CGSize(width: 24, height: 24))
        let rightBarButton = UIBarButtonItem(image: expandImage, style: .plain, target: self, action: #selector(onDropDownButtonClicked))
        self.navigationItem.rightBarButtonItem  = rightBarButton
    }
    
    @objc func onDropDownButtonClicked() {
        self.newsDropDownView.isHidden = !self.newsDropDownView.isHidden
        self.scoresDropDownView.isHidden = !self.scoresDropDownView.isHidden
        self.standingsDropDownView.isHidden = !self.standingsDropDownView.isHidden
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}

extension ViewController: DropDownSectionDelegate {
    func onDropDownSectionClicked(_ dropDownSection: DropDownSectionView) {
        print(dropDownSection.title)
        RequestManager().getTeamRanking(completion: { (rankingTeams) in
            self.rankingTeams = rankingTeams
        })
    }
}
