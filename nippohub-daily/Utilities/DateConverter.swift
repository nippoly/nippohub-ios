//
//  DateConverter.swift
//  nippohub-daily
//
//  Created by うさきち on 2019/03/31.
//  Copyright © 2019 うーぴょん. All rights reserved.
//

import Foundation

final class DateConverter {
    private let instance = DateFormatter()
    static let converter = DateConverter()
    
    private init() {
        instance.dateFormat = "yyyy-MM-dd"
    }
    
    func toDate(from: String) throws -> Date  {
        let dateOptional = instance.date(from: from)
        
        if let date = dateOptional {
            return date
        }
        
        throw InvalidDate()
    }
    
    func toString(from: Date) -> String {
        return instance.string(from: from)
    }
    
    class InvalidDate: Error {}
}
