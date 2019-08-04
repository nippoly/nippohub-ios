//
//  DailyReportNewViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/30.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

final class DailyReportPostViewController: UIViewController {
    @IBOutlet private weak var formDate: UIDatePicker!
    @IBOutlet private weak var formTitle: UITextField!
    @IBOutlet private weak var formContent: UITextView!
    @IBOutlet private weak var btnSubmit: UIButton!
    var dailyReport: DailyReport?

    override func viewDidLoad() {
        if let dailyReport = dailyReport {
            formDate.date = dailyReport.date
            formTitle.text = dailyReport.title
            formContent.text = dailyReport.content

            btnSubmit.setTitle("更新", for: .normal)
        }
    }
    
    @IBAction
    func sendDailyReport() {
        guard let currentUser = AccountRepository.instance.currentUser else { return }
        let date = formDate.date
        let title = formTitle.text!
        let content = formContent.text!
        let dailyReportRepository = DailyReportRepository.instance
        
        if let dailyReport = dailyReport {
            let updatedDailyReport = DailyReport(
                id: dailyReport.id,
                date: date,
                title: title,
                content: content,
                accessKey: dailyReport.accessKey
            )

            dailyReportRepository.update(user: currentUser, dailyReport: updatedDailyReport)

            navigationController.flatMap {
                $0.viewControllers[$0.viewControllers.count - 2] as? DailyReportShowViewController
            }?.dailyReport = updatedDailyReport
        } else {
            dailyReportRepository.create(user: currentUser, date: date, title: title, content: content)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    static func instantiate(dailyReport: DailyReport? = nil) -> DailyReportPostViewController {
        let vc = UIStoryboard(name: "DailyReportPost", bundle: nil).instantiateInitialViewController() as! DailyReportPostViewController

        vc.dailyReport = dailyReport

        return vc
    }
}
