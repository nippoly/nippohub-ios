//
//  DailyReportIndex2ViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/07/12.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DailyReportIndexViewController: ButtonBarPagerTabStripViewController {
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [DailyReportsTableViewController(), DailyReportsTableViewController()]
    }

    @IBAction func transitToNewDailyReport() {
        let viewController = DailyReportNewViewController.instantiate()

        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func transitToSettings() {
        let viewController = SettingViewController.instantiate()

        navigationController?.pushViewController(viewController, animated: true)
    }

    static func instantiate() -> DailyReportIndexViewController {
        return UIStoryboard(name: "DailyReportIndex", bundle: nil).instantiateInitialViewController() as! DailyReportIndexViewController
    }
}
