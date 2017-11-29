//
//  WebViewController.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 29.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: MainViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar(title: "Sample VC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goTo(url: url)
    }
    
    private func goTo(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
