//
//  LaunchViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/04/09.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit

final class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountManager.manager.didSetUp { [unowned self] auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "launchToDailyReportIndexSegue", sender: nil)
            } else {
                self.performSegue(withIdentifier: "launchToSignInSegue", sender: nil)
            }
        }
    }
}
