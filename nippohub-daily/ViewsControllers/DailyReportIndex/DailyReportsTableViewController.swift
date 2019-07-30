//
//  DailyReportIndexViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/26.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase
import XLPagerTabStrip

final class DailyReportsTableViewController: UITableViewController {
    private var dailyReports: [DailyReport] = []
    var yearMonth: YearMonth!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "DailyReportListItem", bundle: nil), forCellReuseIdentifier: "DailyReportListItem")
    }

    override func viewDidAppear(_ animated: Bool) {
        let currentUser = AccountRepository.instance.currentUser
        let dailyReportRepository = DailyReportRepository.instance

        if let user = currentUser {
            dailyReportRepository.fetch(user: user, dateGt: yearMonth.firstDateOfYearMonth(), dateLt: yearMonth.lastDateOfYearMonth()) { [unowned self] in
                self.dailyReports = $0
                self.tableView.reloadData()
            }
        }
    }
    
    static func instantiate() -> DailyReportIndexViewController {
        return UIStoryboard(name: "DailyReportIndex", bundle: nil).instantiateInitialViewController() as! DailyReportIndexViewController
    }
}

extension DailyReportsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyReports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyReportListItem") as! DailyReportListItem
        let dailyReport = dailyReports[indexPath.row]
        
        cell.title = "\(DateConverter.converter.toString(from: dailyReport.date)) \(dailyReport.title)" // TODO: Date追加
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DailyReportShowViewController.instantiate(dailyReport: dailyReports[indexPath.row])

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DailyReportsTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: yearMonth.string())
    }
}
