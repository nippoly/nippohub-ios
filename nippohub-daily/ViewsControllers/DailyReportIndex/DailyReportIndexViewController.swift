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
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let currentYearMonth = YearMonth(year: year, month: month)

        return (0...23).map {
            let vc = DailyReportsTableViewController()
            vc.yearMonth = currentYearMonth.sub(month: $0)

            return vc
        }.reversed()
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
