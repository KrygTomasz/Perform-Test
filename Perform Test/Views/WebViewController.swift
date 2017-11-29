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
        initBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        goTo(url: url)
    }
    
    private func goTo(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func initBarButton() {
        let closeBarButton = UIBarButtonItem(title: R.string.localizable.close(), style: .plain, target: self, action: #selector(onCloseButtonClicked))
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func onCloseButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

}
