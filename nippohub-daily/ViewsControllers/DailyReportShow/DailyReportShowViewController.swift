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
    @IBOutlet private weak var dailyReportShareURLView: DailyReportShareURLView!
    @IBOutlet private weak var btnShare: UIButton!
    @IBOutlet private weak var webKitForContents: WKWebView!
    
    var dailyReport: DailyReport!
    
    override func viewDidAppear(_ animated: Bool) {
        let url = Bundle.main.url(forResource: "daily_report_show", withExtension: "html")!
        let req = URLRequest(url: url)

        if let accessKey = dailyReport.accessKey {
            dailyReportShareURLView.isHidden = false
            dailyReportShareURLView.shareURL = "https://nippohub.jp/daily_reports/public/\(accessKey)"
            btnShare.isHidden = true
        } else {
            dailyReportShareURLView.isHidden = true
            btnShare.isHidden = false
        }
        
        webKitForContents.navigationDelegate = self
        webKitForContents.load(req)
    }

    @IBAction func transitToEdit() {
        let viewController = DailyReportPostViewController.instantiate(dailyReport: dailyReport)

        viewController.dailyReport = dailyReport

        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func shareDailyReport() {

    }
    
    static func instantiate(dailyReport: DailyReport) -> DailyReportShowViewController {
        let viewController = UIStoryboard(name: "DailyReportShow", bundle: nil).instantiateInitialViewController() as! DailyReportShowViewController

        viewController.dailyReport = dailyReport

        return viewController
    }
}

extension DailyReportShowViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let title = "\(DateConverter.converter.toString(from: dailyReport.date)) \(dailyReport.title)".split(separator: "'").joined(separator: "\\'")
        let content = dailyReport.content.split(separator: "\\").joined(separator: "\\\\").split(separator: "\n").joined(separator: "\\n").split(separator: "\"").joined(separator: "\\\"")

        webKitForContents.evaluateJavaScript("rendering('\(title)', \"\(content)\")", completionHandler: nil)
    }
}
