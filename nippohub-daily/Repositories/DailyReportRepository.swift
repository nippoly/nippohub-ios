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
    
    func fetch(user: Account, dateGt: Date? = nil, dateLt: Date? = nil, callBack: @escaping ([DailyReport]) -> Void) {
        var query = self.ref.child("users/\(user.id)/daily_reports")
            .queryOrdered(byChild: "date")
            .queryLimited(toLast: 30)

        if let startDate = dateGt {
            query = query.queryStarting(atValue: DateConverter.converter.toString(from: startDate))
        }

        if let endDate = dateLt {
            query = query.queryEnding(atValue: DateConverter.converter.toString(from: endDate))
        }

        query.observeSingleEvent(of: .value, with: { snapshot in
            let dailyReports = snapshot.children.map({ dailyReportRaw -> DailyReport in
                let dailyReport = dailyReportRaw as! DataSnapshot
                // TODO: 変換失敗時の処理を考える
                let date = (try? DateConverter.converter.toDate(from: dailyReport.childSnapshot(forPath: "date").value as! String)) ?? Date()

                return DailyReport(
                    id: dailyReport.key,
                    date: date,
                    title: dailyReport.childSnapshot(forPath: "title").value as! String,
                    content: dailyReport.childSnapshot(forPath: "content").value as! String,
                    accessKey: dailyReport.childSnapshot(forPath: "access_key").value as? String
                )
            }).sorted { $0.date >= $1.date }

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
        
        return DailyReport(id: newRecord.key, date: date, title: title, content: content, accessKey: nil)
    }
    
    func update(user: Account, dailyReport: DailyReport) {
        ref.child("/users/\(user.id)/daily_reports/\(dailyReport.id)").updateChildValues([
            "date": DateConverter.converter.toString(from: dailyReport.date),
            "title": dailyReport.title,
            "content": dailyReport.content
        ])
    }

    func updateAccessKey(user: Account, dailyReport: DailyReport, accessKey: AccessKey?) {
        ref.child("/users/\(user.id)/daily_reports/\(dailyReport.id)/accessKey").setValue(accessKey?.id)
    }
}
