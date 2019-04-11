//
//  DailyReportShowViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/29.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import WebKit

class DailyReportShowViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelContent: UILabel!
    @IBOutlet private weak var webKitForContents: WKWebView!
    
    var dailyReport: DailyReport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = dailyReport.title // TODO: date追加
        labelContent.text = dailyReport.content
        
        webKitForContents.navigationDelegate = self
        
        let url = Bundle.main.url(forResource: "daily_report_show", withExtension: "html")!
        let req = URLRequest(url: url)
        
        webKitForContents.load(req)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let title = dailyReport.title // TODO: date追加
        let content = dailyReport.content.split(separator: "\n").joined(separator: "\\n") // TODO: 引用符のエスケープ

        webKitForContents.evaluateJavaScript("rendering('\(title)', \"\(content)\")", completionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dailyReportShowToDailyReportEditSegue" {
            let destController = segue.destination as! DailyReportEditViewController
            
            destController.dailyReport = self.dailyReport
        }
    }
}
