//
//  DailyReportIndexViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/07/12.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import XLPagerTabStrip

final class DailyReportIndexViewController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        settings.style.buttonBarItemTitleColor = UIColor.black
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        settings.style.buttonBarBackgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.selectedBarHeight = 2

        super.viewDidLoad()
    }

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
        }
    }

    @IBAction private func transitToNewDailyReport() {
        let viewController = DailyReportPostViewController.instantiate()

        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction private func transitToSettings() {
        let viewController = SettingViewController.instantiate()

        navigationController?.pushViewController(viewController, animated: true)
    }

    static func instantiate() -> DailyReportIndexViewController {
        return UIStoryboard(name: "DailyReportIndex", bundle: nil).instantiateInitialViewController() as! DailyReportIndexViewController
    }
}
