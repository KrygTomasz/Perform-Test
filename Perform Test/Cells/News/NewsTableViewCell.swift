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
            publicationDateLabel.textColor = .lightGray
        }
    }
    
    var news: News? {
        didSet {
            guard let news = news else { return }
            titleLabel.text = news.title
            publicationDateLabel.text = news.getDateString(withFormat: "EEEE, dd MMMM yyyy, HH:mm")
            RequestManager.downloadImage(url: news.imageURL, completion: setThumbnailImage(_:))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setThumbnailImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
    
}
