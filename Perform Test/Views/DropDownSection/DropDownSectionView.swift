//
//  DropDownView.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 25.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

protocol DropDownSectionDelegate: class {
    func onDropDownSectionClicked(_ dropDownSection: DropDownSectionView)
}

enum DropDownSectionType {
    case news
    case scores
    case standings
    case unknown
}

class DropDownSectionView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleButton: UIButton! {
        didSet {
            titleButton.addTarget(self, action: #selector(onTitleButtonClicked), for: .touchUpInside)
        }
    }
    
    private var contentView: UIView!
    var sectionType: DropDownSectionType = .unknown
    var title: String = "" {
        didSet {
            titleButton.setTitle(title, for: .normal)
        }
    }
    var selected: Bool = false {
        didSet {
            selected ? (containerView.backgroundColor = .selection) : (containerView.backgroundColor = .lightMain)
        }
    }
    weak var delegate: DropDownSectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @objc func onTitleButtonClicked() {
        delegate?.onDropDownSectionClicked(self)
    }
    
}

//MARK: Reusable DropDownSectionView setup methods
extension DropDownSectionView {
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
}

//MARK: UI Methods
extension DropDownSectionView {
    
    func appTheme() {
        containerView.backgroundColor = .lightMain
        titleButton.setTitleColor(.text, for: .normal)
        separatorView.backgroundColor = .text
    }

}
