//
//  String+.swift
//  Reminder
//
//  Created by 아라 on 7/5/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.date(from: self)
    }
}
