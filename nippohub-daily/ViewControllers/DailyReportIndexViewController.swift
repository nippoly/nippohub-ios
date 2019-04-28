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
        
        let currentUser = AccountManager.instance.currentUser()
        
        tableDailyReports.register(UINib(nibName: "DailyReportListItem", bundle: nil), forCellReuseIdentifier: "DailyReportListItem")
        tableDailyReports.dataSource = self
        tableDailyReports.delegate = self
        
        if let user = currentUser {
            let ref: DatabaseReference! = Database.database().reference()

            ref.child("users/\(user.uid)/daily_reports").queryOrdered(byChild: "date").queryLimited(toLast: 30).observe(.value, with: { snapshot -> Void in
                let dailyReports = snapshot.children.map({ dailyReportRaw -> DailyReport in
                    let dailyReport = dailyReportRaw as! DataSnapshot
                    // TODO: 変換失敗時の処理を考える
                    let date = (try? DateConverter.converter.toDate(from: dailyReport.childSnapshot(forPath: "date").value as! String)) ?? Date()

                    return DailyReport(id: dailyReport.key, date: date, title: dailyReport.childSnapshot(forPath: "title").value as! String, content: dailyReport.childSnapshot(forPath: "content").value as! String)
                }).sorted(by: { (report1, report2) -> Bool in
                    report1.date >= report2.date
                })
                
                self.dailyReports = dailyReports
                self.tableDailyReports.reloadData()
            })
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
