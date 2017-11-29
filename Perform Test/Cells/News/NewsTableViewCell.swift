//
//  NewsTableViewCell.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 27.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class NewsTableViewCell: RowColorTableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .text
        }
    }
    @IBOutlet weak var publicationDateLabel: UILabel! {
        didSet {
            publicationDateLabel.textColor = .text
        }
    }
    @IBOutlet weak var goToNewsImageView: UIImageView! {
        didSet {
            goToNewsImageView.image = R.image.right()?.withRenderingMode(.alwaysTemplate)
            goToNewsImageView.tintColor = .text
        }
    }
    
    var news: News? {
        didSet {
            guard let news = news else { return }
            titleLabel.text = news.title
            publicationDateLabel.text = news.pubDate
            RequestManager.downloadImage(url: news.imageURL, completion: setThumbnailImage(_:))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setThumbnailImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
    
}
