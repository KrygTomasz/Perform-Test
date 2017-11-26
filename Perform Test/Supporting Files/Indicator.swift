//
//  Indicator.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 26.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit
import MBProgressHUD

class Indicator {
    
    private var view: UIView!
    private var indicator: MBProgressHUD?
    
    init(in view: UIView) {
        self.view = view
    }
    
    func show(description: String) {
        indicator = MBProgressHUD.showAdded(to: view, animated: true)
        indicator?.label.text = description
    }
    
    func hide(success: Bool, failedDescription: String) {
        guard let indicator = indicator else { return }
        if success {
            indicator.hide(animated: true)
        } else {
            indicator.mode = .text
            indicator.label.text = ""
            indicator.detailsLabel.text = failedDescription
            indicator.hide(animated: true, afterDelay: 2.0)
        }
    }
    
}
