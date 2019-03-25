//
//  DailyReportIndexViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/26.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

class DailyReportIndexViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, currentUser in
            if let user = currentUser {
                let ref: DatabaseReference! = Database.database().reference()
                
                ref.child("daily_reports").queryOrdered(byChild: "userId").queryEqual(toValue: user.uid).observe(.childAdded, with: { snapshot -> Void in
                    print(snapshot)
                })
            }
        }
    }
}
