//
//  MainViewController.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 29.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func prepareNavigationBar(title: String) {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .main
        navigationController?.navigationBar.tintColor = .text
        setTitle(title)
    }
    
    private func setTitle(_ title: String) {
        navigationController?.navigationBar.topItem?.title = title
    }
    
}
