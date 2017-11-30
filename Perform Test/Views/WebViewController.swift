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
        prepareNavigationBar(title: R.string.localizable.news())
        initCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goTo(url: url)
    }

}

//MARK: Close bar button preparation
extension WebViewController {
    
    private func initCloseButton() {
        let closeBarButton = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: #selector(onCloseButtonClicked))
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc private func onCloseButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: Loading url into WKWebView
extension WebViewController {
    
    private func goTo(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
