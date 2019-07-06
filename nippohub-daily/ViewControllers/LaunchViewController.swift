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
        
        AccountRepository.instance.didSetUp { [unowned self] auth, user in
            if user != nil {
                let navigationController = UINavigationController()
                let viewController = DailyReportIndexViewController.instantiate()

                self.present(navigationController, animated: false)
                navigationController.pushViewController(viewController, animated: false)
            } else {
                let viewController = SignInViewController.instantiate()

                self.present(viewController, animated: false)
            }
        }
    }
}
