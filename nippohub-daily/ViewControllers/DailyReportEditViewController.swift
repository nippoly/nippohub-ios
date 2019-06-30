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
        let date = DateConverter.converter.toString(from: formDate.date)
        let title = formTitle.text!
        let content = formContent.text!
        let currentUser = AccountRepository.instance.currentUser
        
        if let user = currentUser {
            let ref: DatabaseReference! = Database.database().reference()
            
            ref.child("/users/\(user.id)/daily_reports/\(dailyReport.id)").updateChildValues([
                "date": date,
                "title": title,
                "content": content
            ])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
