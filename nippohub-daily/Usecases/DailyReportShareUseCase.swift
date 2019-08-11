//
//  DailyReportShareUsecase.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/08/12.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation

final class DailyReportShareUsecase {
    static let instance = DailyReportShareUsecase()

    private let accessKeyRepository = AccessKeyRepository.instance
    private let dailyReportRepository = DailyReportRepository.instance

    private init() {}

    // TODO: トランザクション張る
    func share(user: Account, dailyReport: DailyReport) -> AccessKey {
        let accessKey = accessKeyRepository.create(user: user, dailyReport: dailyReport)

        dailyReportRepository.updateAccessKey(user: user, dailyReport: dailyReport, accessKey: accessKey)

        return accessKey
    }

    // TODO: トランザクション張る
    func stopSharing(user: Account, dailyReport: DailyReport) {
        dailyReport.accessKey.map {
            accessKeyRepository.delete(accessKeyId: $0)
            dailyReportRepository.updateAccessKey(user: user, dailyReport: dailyReport, accessKey: nil)
        }
    }
}
