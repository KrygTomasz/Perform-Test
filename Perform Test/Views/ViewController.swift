//
//  ViewController.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 25.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: MainViewController {
    
    @IBOutlet private weak var newsDropDownView: DropDownSectionView! {
        didSet {
            newsDropDownView.title = R.string.localizable.news()
            newsDropDownView.isHidden = true
            newsDropDownView.appTheme()
            newsDropDownView.sectionType = .news
            newsDropDownView.delegate = self
        }
    }
    @IBOutlet private weak var scoresDropDownView: DropDownSectionView! {
        didSet {
            scoresDropDownView.title = R.string.localizable.scores()
            scoresDropDownView.isHidden = true
            scoresDropDownView.appTheme()
            scoresDropDownView.sectionType = .scores
            scoresDropDownView.delegate = self
        }
    }
    @IBOutlet private weak var standingsDropDownView: DropDownSectionView! {
        didSet {
            standingsDropDownView.title = R.string.localizable.standings()
            standingsDropDownView.isHidden = true
            standingsDropDownView.appTheme()
            standingsDropDownView.sectionType = .standings
            standingsDropDownView.delegate = self
        }
    }
    @IBOutlet private weak var dropDownSeparatorView: UIView! {
        didSet {
            dropDownSeparatorView.backgroundColor = .text
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .main
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100.0
            tableView.register(R.nib.newsTableViewCell(), forCellReuseIdentifier: "NewsTableViewCell")
            tableView.register(R.nib.standingsTableViewCell(), forCellReuseIdentifier: "StandingsTableViewCell")
            tableView.register(R.nib.scoresTableViewCell(), forCellReuseIdentifier: "ScoresTableViewCell")
            tableView.register(R.nib.scoresHeaderView(), forHeaderFooterViewReuseIdentifier: "ScoresHeaderView")
            tableView.register(R.nib.standingsHeaderView(), forHeaderFooterViewReuseIdentifier: "StandingsHeaderView")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var indicator: Indicator?
    private var sectionType: DropDownSectionType = .news {
        didSet {
            stopTimer()
            indicator?.show(description: "\(R.string.localizable.downloading())...")
            prepareDropDownSection(sectionType)
        }
    }
    private var isDropDownExpanded: Bool = false {
        didSet {
            self.newsDropDownView.isHidden = !isDropDownExpanded
            self.scoresDropDownView.isHidden = !isDropDownExpanded
            self.standingsDropDownView.isHidden = !isDropDownExpanded
            setDropDownButton()
        }
    }
    private var news: [News] = []
    private var scores: [Score] = []
    private var standings: [Standing] = [] {
        didSet {
            standings.sort(by: {
                $0.rank < $1.rank
            })
        }
    }
    private var scoreDate: String = ""
    private var timer: Timer?
    private let AUTO_REFRESH_INTERVAL: Double = 30.0
    private let HEADER_HEIGHT: CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = Indicator(in: self.view)
        self.view.backgroundColor = .tint
        initNavigationBar()
        sectionType = .news
    }
    
    private func initNavigationBar() {
        prepareNavigationBar(title: R.string.localizable.appName())
        setDropDownButton()
    }
    
    private func reloadDataAfterResponse(wasSuccessful success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.scrollToTop()
            self.indicator?.hide(success: success, failedDescription: R.string.localizable.checkConnectionTryAgain())
        }
    }
    
    private func scrollToTop() {
        if tableView.numberOfRows(inSection: 0) > 0 {
            let topIndexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndexPath, at: .top, animated: false)
        }
    }
    
}

//MARK: DropDownSection delegate, preparation and handling
extension ViewController: DropDownSectionDelegate {
    
    func onDropDownSectionClicked(_ dropDownSection: DropDownSectionView) {
        toggleDropDown()
        sectionType = dropDownSection.sectionType
    }
    
    private func toggleDropDown() {
        isDropDownExpanded = !isDropDownExpanded
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func setDropDownButton() {
        let image: UIImage!
        if isDropDownExpanded {
            image = R.image.fold()?.resize(to: CGSize(width: 24, height: 24))
        } else {
            image = R.image.expand()?.resize(to: CGSize(width: 24, height: 24))
        }
        let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onDropDownButtonClicked))
        self.navigationItem.rightBarButtonItem  = rightBarButton
    }
    
    @objc private func onDropDownButtonClicked() {
        toggleDropDown()
    }
    
    private func prepareDropDownSection(_ type: DropDownSectionType) {
        selectDropDownSection(ofType: sectionType)
        switch type {
        case .news:
            prepareNewsSection()
        case .scores:
            prepareScoresSection()
        case .standings:
            prepareStandingsSection()
        default:
            self.reloadDataAfterResponse(wasSuccessful: true)
            return
        }
    }
    
    private func selectDropDownSection(ofType type: DropDownSectionType) {
        deselectAllDropDownSections()
        switch type {
        case .news:
            newsDropDownView.selected = true
        case .scores:
            scoresDropDownView.selected = true
        case .standings:
            standingsDropDownView.selected = true
        default:
            return
        }
    }
    
    private func deselectAllDropDownSections() {
        newsDropDownView.selected = false
        scoresDropDownView.selected = false
        standingsDropDownView.selected = false
    }
    
    private func prepareNewsSection() {
        RequestManager().getNews(completion: {success, news in
            self.news = news
            self.reloadDataAfterResponse(wasSuccessful: success)
        })
        tableView.allowsSelection = true
    }
    
    private func prepareScoresSection() {
        RequestManager().getScores(completion: { success, scores, date in
            self.scores = scores
            self.reloadDataAfterResponse(wasSuccessful: success)
            self.setScoresDate(to: date)
        })
        tableView.allowsSelection = false
        startTimer()
    }
    
    private func prepareStandingsSection() {
        RequestManager().getStandings(completion: { success, standings in
            self.standings = standings
            self.reloadDataAfterResponse(wasSuccessful: success)
        })
        tableView.allowsSelection = false
    }
    
}

//MARK: Handling scores view update
extension ViewController {
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: AUTO_REFRESH_INTERVAL, target: self, selector: #selector(onTimerUpdate), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
    
    @objc func onTimerUpdate() {
        if sectionType == .scores {
            scoresUpdate()
        }
    }
    
    private func scoresUpdate() {
        RequestManager().getScores(completion: { success, scores, date in
            if success {
                self.scores = scores
                self.reloadDataAfterResponse(wasSuccessful: success)
                self.setScoresDate(to: date)
            }
        })
    }
    
    func setScoresDate(to date: Date?) {
        guard let date = date else {
            scoreDate = ""
            NSLog("Wrong date format from web service")
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        self.scoreDate = dateFormatter.string(from: date)
    }
    
}

//MARK: UITableView delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionType {
        case .news:
            return news.count
        case .scores:
            return scores.count
        case .standings:
            return standings.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionType {
        case .news:
            guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
            return newsCell
        case .scores:
            guard let scoresCell = tableView.dequeueReusableCell(withIdentifier: "ScoresTableViewCell", for: indexPath) as? ScoresTableViewCell else { return UITableViewCell() }
            return scoresCell
        case .standings:
            guard let standingsCell = tableView.dequeueReusableCell(withIdentifier: "StandingsTableViewCell", for: indexPath) as? StandingsTableViewCell else { return UITableViewCell() }
            return standingsCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch sectionType {
        case .news:
            guard let newsCell = cell as? NewsTableViewCell else { return }
            newsCell.news = news[indexPath.row]
            newsCell.row = indexPath.row
        case .scores:
            guard let scoresCell = cell as? ScoresTableViewCell else { return }
            scoresCell.score = scores[indexPath.row]
            scoresCell.row = indexPath.row
        case .standings:
            guard let standingsCell = cell as? StandingsTableViewCell else { return }
            standingsCell.standing = standings[indexPath.row]
            standingsCell.row = indexPath.row
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sectionType {
        case .news:
            return getNewsHeader()
        case .scores:
            return getScoresHeader()
        case .standings:
            return getStandingsHeader()
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sectionType {
        case .news:
            return 0
        case .scores:
            return HEADER_HEIGHT
        case .standings:
            return HEADER_HEIGHT
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sectionType {
        case .news:
            let row = indexPath.row
            let selectedNews = news[row]
            guard let webViewController = R.storyboard.main().instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
            webViewController.url = selectedNews.linkURL
            let navigationController = UINavigationController(rootViewController: webViewController)
            present(navigationController, animated: true, completion: nil)
        case .scores:
            return
        case .standings:
            return
        default:
            return
        }
    }
    
}

//MARK: UITableView headers preparation
extension ViewController {
    
    private func getNewsHeader() -> UIView {
        return UIView()
    }
    
    private func getScoresHeader() -> UIView {
        guard let scoresHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ScoresHeaderView") as? ScoresHeaderView else { return UIView() }
        scoresHeaderView.dateString = scoreDate
        return scoresHeaderView
    }
    
    private func getStandingsHeader() -> UIView {
        guard let standingsHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StandingsHeaderView") as? StandingsHeaderView else { return UIView() }
        return standingsHeaderView
    }
    
}
