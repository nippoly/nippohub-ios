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
        let date = DateConverter.converter.toString(from: formDate.date)
        let title = formTitle.text!
        let content = formContent.text!
        let currentUser = AccountManager.instance.currentUser
        
        if let user = currentUser {
            let ref: DatabaseReference! = Database.database().reference()

            ref.child("users/\(user.id)/daily_reports").childByAutoId().setValue([
                "date": date,
                "title": title,
                "content": content,
                "createdAt": Int(Date().timeIntervalSince1970 * 1000)
            ])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
