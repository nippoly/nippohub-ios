//
//  DailyReportShowViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/29.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import WebKit

final class DailyReportShowViewController: UIViewController {
    @IBOutlet private weak var webKitForContents: WKWebView!
    
    var dailyReport: DailyReport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "daily_report_show", withExtension: "html")!
        let req = URLRequest(url: url)
        
        webKitForContents.navigationDelegate = self
        webKitForContents.load(req)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dailyReportShowToDailyReportEditSegue" {
            let destController = segue.destination as! DailyReportEditViewController
            
            destController.dailyReport = self.dailyReport
        }
    }
}

extension DailyReportShowViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let title = "\(DateConverter.converter.toString(from: dailyReport.date)) \(dailyReport.title)".split(separator: "'").joined(separator: "\\'")
        let content = dailyReport.content.split(separator: "\\").joined(separator: "\\\\").split(separator: "\n").joined(separator: "\\n").split(separator: "\"").joined(separator: "\\\"")

        webKitForContents.evaluateJavaScript("rendering('\(title)', \"\(content)\")", completionHandler: nil)
    }
}
