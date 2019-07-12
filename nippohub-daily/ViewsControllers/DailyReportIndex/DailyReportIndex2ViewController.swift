//
//  DailyReportIndex2ViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/07/12.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DailyReportIndex2ViewController: ButtonBarPagerTabStripViewController {
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [DailyReportIndexViewController(), DailyReportIndexViewController()]
    }
}
