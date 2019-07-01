//
//  DailyReportIndexViewController.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/26.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import UIKit
import Firebase

final class DailyReportIndexViewController: UIViewController {
    @IBOutlet private weak var tableDailyReports: UITableView!
    var dailyReports: [DailyReport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = AccountRepository.instance.currentUser
        let dailyReportRepository = DailyReportRepository.instance
        
        tableDailyReports.register(UINib(nibName: "DailyReportListItem", bundle: nil), forCellReuseIdentifier: "DailyReportListItem")
        tableDailyReports.dataSource = self
        tableDailyReports.delegate = self
        
        if let user = currentUser {
            dailyReportRepository.fetch(user: user) { [unowned self] in
                self.dailyReports = $0
                self.tableDailyReports.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dailyReportIndexToDailyReportShowSegue" {
            let destController = segue.destination as! DailyReportShowViewController
            let index = sender as! Int
            
            destController.dailyReport = dailyReports[index]
        }
    }
}

extension DailyReportIndexViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyReportListItem") as! DailyReportListItem
        let dailyReport = dailyReports[indexPath.row]
        
        cell.title = "\(DateConverter.converter.toString(from: dailyReport.date)) \(dailyReport.title)" // TODO: Date追加
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dailyReportIndexToDailyReportShowSegue", sender: indexPath.row)
    }
}
