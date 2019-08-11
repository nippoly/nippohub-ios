//
//  AccessKeyRepository.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/08/12.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation
import Firebase

final class AccessKeyRepository {
    static let instance = AccessKeyRepository()
    private let ref: DatabaseReference! = Database.database().reference()

    private init() {}

    func fetch(accessKeyId: String, callBack: @escaping (AccessKey) -> Void){
        ref.child("/access_keys/\(accessKeyId)").observeSingleEvent(of: .value, with: { snapshot in
            let dailyReportId = snapshot.value(forKey: "daily_report_id") as! String
            let userId = snapshot.value(forKey: "userId") as! String
            let accessKey = AccessKey(id: snapshot.key, dailyReportId: dailyReportId, userId: userId)

            callBack(accessKey)
        })
    }
    
    func create(user: Account, dailyReport: DailyReport) -> AccessKey {
        let row = ref.child("/access_keys").childByAutoId()

        row.setValue([
            "daily_report_id": dailyReport.id,
            "user_id": user.id
        ])

        return AccessKey(id: row.key, dailyReportId: dailyReport.id, userId: user.id)
    }

    func delete(accessKeyId: String) {
        ref.child("/access_keys/\(accessKeyId)").removeValue()
    }
}
