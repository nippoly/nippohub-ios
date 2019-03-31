//
//  DailyReportEditViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/31.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

class DailyReportEditViewController: UIViewController {
    var dailyReport: DailyReport!
    
    @IBOutlet var formDate: UIDatePicker!
    @IBOutlet var formTitle: UITextField!
    @IBOutlet var formContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formDate.date = dailyReport.date
        formTitle.text = dailyReport.title
        formContent.text = dailyReport.content
    }
    
    @IBAction
    func sendDailyReport() {
        let formatter = DateFormatter()
        let date = formDate.date
        let title = formTitle.text!
        let content = formContent.text!
        let currentUser = Auth.auth().currentUser // TODO: 確実に取得できていることを担保する
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        if currentUser != nil {
            let ref: DatabaseReference! = Database.database().reference()
            
            ref.child("daily_reports/\(dailyReport.id)").updateChildValues([
                "date": formatter.string(from: date),
                "title": title,
                "content": content
            ])
        }
    }
}
