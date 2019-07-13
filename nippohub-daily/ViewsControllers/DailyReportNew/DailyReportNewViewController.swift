//
//  DailyReportNewViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/30.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

final class DailyReportNewViewController: UIViewController {
    @IBOutlet private weak var formDate: UIDatePicker!
    @IBOutlet private weak var formTitle: UITextField!
    @IBOutlet private weak var formContent: UITextView!
    
    @IBAction
    func sendDailyReport() {
        let date = formDate.date
        let title = formTitle.text!
        let content = formContent.text!
        let currentUser = AccountRepository.instance.currentUser
        let dailyReportRepository = DailyReportRepository.instance
        
        if let user = currentUser {
            let dailyReport = dailyReportRepository.create(user: user, date: date, title: title, content: content)
            
            // TODO: nilチェックする
            (self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2] as! DailyReportIndexViewController)//.updateDailyReports(dailyReport: dailyReport)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    static func instantiate() -> DailyReportNewViewController {
        return UIStoryboard(name: "DailyReportNew", bundle: nil).instantiateInitialViewController() as! DailyReportNewViewController
    }
}
