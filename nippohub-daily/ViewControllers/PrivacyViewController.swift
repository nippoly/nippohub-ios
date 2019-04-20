//
//  PrivacyViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/21.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import WebKit

class PrivacyViewController: UIViewController {
    @IBOutlet private weak var webviewPrivacy: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://nippohub.com/privacy_content.html")!
        let req = URLRequest(url: url)
        
        webviewPrivacy.navigationDelegate = self
        webviewPrivacy.load(req)
    }
    
    @IBAction
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PrivacyViewController: WKNavigationDelegate {
}
