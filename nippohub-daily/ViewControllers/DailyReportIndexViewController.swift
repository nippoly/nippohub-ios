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
    @IBOutlet private weak var tableDailyReports: UITableView!
    var dailyReports: [DailyReport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = AccountManager.manager.currentUser()
        
        tableDailyReports.register(UINib(nibName: "DailyReportListItem", bundle: nil), forCellReuseIdentifier: "DailyReportListItem")
        tableDailyReports.dataSource = self
        tableDailyReports.delegate = self
        
        if let user = currentUser {
            let ref: DatabaseReference! = Database.database().reference()
            var dailyReports: [DailyReport] = []
            
            ref.child("users/\(user.uid)/daily_reports").observe(.childAdded, with: { snapshot -> Void in
                // TODO: 変換失敗時の処理を考える
                print(snapshot.childrenCount)
                let date = (try? DateConverter.converter.toDate(from: snapshot.childSnapshot(forPath: "date").value as! String)) ?? Date()
                
                dailyReports.append(DailyReport(id: snapshot.key, date: date, title: snapshot.childSnapshot(forPath: "title").value as! String, content: snapshot.childSnapshot(forPath: "content").value as! String))
                
                // TODO: ループ毎ではなくまとめて処理できるようにする
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
        
        cell.labelTitle.text = dailyReport.title // TODO: Date追加
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dailyReportIndexToDailyReportShowSegue", sender: indexPath.row)
    }
}
