//
//  YearMonth.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/07/14.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation

struct YearMonth {
    let year: Int
    let month: Int
    private let calendar = Calendar.current

    func add(month: Int) -> YearMonth{
        let temporaryMonth = (self.month - 1) + month

        if temporaryMonth >= 0 {
            return YearMonth(year: self.year + (temporaryMonth / 12), month: temporaryMonth % 12 + 1)
        } else {
            return YearMonth(year: self.year + ((temporaryMonth + 1) / 12 - 1), month: 13 + temporaryMonth % 12)
        }
    }

    func sub(month: Int) -> YearMonth{
        let temporaryMonth = (self.month - 1) - month

        if temporaryMonth >= 0 {
            return YearMonth(year: self.year + (temporaryMonth / 12), month: temporaryMonth % 12 + 1)
        } else {
            return YearMonth(year: self.year + ((temporaryMonth + 1) / 12 - 1), month: 13 + temporaryMonth % 12)
        }
    }

    func firstDateOfYearMonth() -> Date {
        return calendar.date(from: DateComponents(year: year, month: month, day: 1))!
    }

    func lastDateOfYearMonth() -> Date {
        if month == 2 {
            if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) {
                return calendar.date(from: DateComponents(year: year, month: month, day: 29))!
            } else {
                return calendar.date(from: DateComponents(year: year, month: month, day: 28))!
            }
        } else if month == 4 || month == 6 || month == 9 || month == 11 {
            return calendar.date(from: DateComponents(year: year, month: month, day: 30))!
        } else {
            return calendar.date(from: DateComponents(year: year, month: month, day: 31))!
        }
    }

    func string() -> String {
        return "\(year)-\(month)"
    }
}
