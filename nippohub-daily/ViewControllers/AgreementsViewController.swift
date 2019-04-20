//
//  AgreementsViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/21.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import WebKit

class AgreementsViewController: UIViewController {
    @IBOutlet private weak var webviewAgreements: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://nippohub.com/agreements_content.html")!
        let req = URLRequest(url: url)

        webviewAgreements.navigationDelegate = self
        webviewAgreements.load(req)
    }
    
    @IBAction
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AgreementsViewController: WKNavigationDelegate {
}
