//
//  DailyReportEditViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/31.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

final class DailyReportEditViewController: UIViewController {
    @IBOutlet private weak var formDate: UIDatePicker!
    @IBOutlet private weak var formTitle: UITextField!
    @IBOutlet private weak var formContent: UITextView!
    
    var dailyReport: DailyReport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formDate.date = dailyReport.date
        formTitle.text = dailyReport.title
        formContent.text = dailyReport.content
    }
    
    @IBAction
    func sendDailyReport() {
        let date = formDate.date
        let title = formTitle.text!
        let content = formContent.text!
        let currentUser = AccountRepository.instance.currentUser
        let dailyReportRepository = DailyReportRepository.instance
        let dailyReport = DailyReport(
            id: self.dailyReport.id,
            date: date,
            title: title,
            content: content
        )
        
        if let user = currentUser {
            dailyReportRepository.update(user: user, dailyReport: dailyReport)
        }
        
        (self.navigationController?.viewControllers[self.navigationController!.viewControllers.count - 2] as! DailyReportShowViewController).dailyReport = dailyReport
        // TODO: nilチェックする
        // TODO: showで処理する
        (self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 3] as! DailyReportIndexViewController).updateDailyReports(dailyReport: dailyReport)
        self.navigationController?.popViewController(animated: true)
    }
}
