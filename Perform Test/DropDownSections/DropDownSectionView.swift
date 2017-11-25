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

class DropDownSectionView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleButton: UIButton! {
        didSet {
            titleButton.addTarget(self, action: #selector(onTitleButtonClicked), for: .touchUpInside)
        }
    }
    
    private var contentView: UIView!
    var title: String = "" {
        didSet {
            titleButton.setTitle(title, for: .normal)
        }
    }
    var delegate: DropDownSectionDelegate?
    
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

//MARK: Reusable DropDownView preparation methods
extension DropDownSectionView {
    
    fileprivate func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
}

//MARK: App Theme Method
extension DropDownSectionView {
    
    func appTheme() {
        containerView.backgroundColor = .tint
        titleButton.setTitleColor(.text, for: .normal)
        separatorView.backgroundColor = .text
    }

}
