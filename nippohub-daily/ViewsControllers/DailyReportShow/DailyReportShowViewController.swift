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

    private let accountRepository = AccountRepository.instance
    private let dailyReportShareUsecase = DailyReportShareUsecase.instance

    private var accessKey: String? {
        didSet {
            if let accessKey = accessKey {
                dailyReportShareURLView.isHidden = false
                dailyReportShareURLView.shareURL = "https://nippohub.jp/daily_reports/public/\(accessKey)"
                btnShare.isHidden = true
            } else {
                dailyReportShareURLView.isHidden = true
                btnShare.isHidden = false
            }
        }
    }

    var dailyReport: DailyReport!
    
    override func viewDidAppear(_ animated: Bool) {
        let url = Bundle.main.url(forResource: "daily_report_show", withExtension: "html")!
        let req = URLRequest(url: url)

        accessKey = dailyReport.accessKey
        
        webKitForContents.navigationDelegate = self
        webKitForContents.load(req)

        dailyReportShareURLView.onTapStopShare = { [unowned self] in
            guard let currentUser = self.accountRepository.currentUser else { return }

            self.dailyReportShareUsecase.stopSharing(user: currentUser, dailyReport: self.dailyReport)

            self.accessKey = nil
        }
    }

    @IBAction private func transitToEdit() {
        let viewController = DailyReportPostViewController.instantiate(dailyReport: dailyReport)

        viewController.dailyReport = dailyReport

        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func shareDailyReport() {
        guard let currentUser = accountRepository.currentUser else { return }

        if dailyReport.accessKey == nil {
            let accessKey = dailyReportShareUsecase.share(user: currentUser, dailyReport: dailyReport)

            self.accessKey = accessKey.id

            self.dailyReport = DailyReport(
                id: dailyReport.id,
                date: dailyReport.date,
                title: dailyReport.title,
                content: dailyReport.content,
                accessKey: accessKey.id
            )
        }
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
