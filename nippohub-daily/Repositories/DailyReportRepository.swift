//
//  DailyReportRepository.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/07/02.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation
import Firebase

final class DailyReportRepository {
    static let instance = DailyReportRepository()
    private let ref: DatabaseReference! = Database.database().reference()
    
    private init() {}
    
    func fetch(user: Account, callBack: @escaping ([DailyReport]) -> Void) {
        self.ref.child("users/\(user.id)/daily_reports")
            .queryOrdered(byChild: "date")
            .queryLimited(toLast: 30)
            .observeSingleEvent(of: .value, with: {snapshot in
                let dailyReports = snapshot.children.map({ dailyReportRaw -> DailyReport in
                    let dailyReport = dailyReportRaw as! DataSnapshot
                    // TODO: 変換失敗時の処理を考える
                    let date = (try? DateConverter.converter.toDate(from: dailyReport.childSnapshot(forPath: "date").value as! String)) ?? Date()
                    
                    return DailyReport(id: dailyReport.key, date: date, title: dailyReport.childSnapshot(forPath: "title").value as! String, content: dailyReport.childSnapshot(forPath: "content").value as! String)
                }).sorted(by: { (report1, report2) -> Bool in
                    report1.date >= report2.date
                })
                
                callBack(dailyReports)
            })
    }
    
    @discardableResult
    func create(user: Account, date: Date, title: String, content: String) -> DailyReport {
        let newRecord = ref.child("users/\(user.id)/daily_reports").childByAutoId()
        newRecord.setValue([
            "date": DateConverter.converter.toString(from: date),
            "title": title,
            "content": content,
            "createdAt": Int(Date().timeIntervalSince1970 * 1000)
        ])
        
        return DailyReport(id: newRecord.key, date: date, title: title, content: content)
    }
    
    func update(user: Account, dailyReport: DailyReport) {
        ref.child("/users/\(user.id)/daily_reports/\(dailyReport.id)").updateChildValues([
            "date": DateConverter.converter.toString(from: dailyReport.date),
            "title": dailyReport.title,
            "content": dailyReport.content
        ])
    }
}
