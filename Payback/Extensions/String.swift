//
//  String.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

extension Optional where Wrapped == String {
    var unwrapped: String {
        return (self ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension String {
    var formatDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            let dateYear = calendar.component(.year, from: date)

            let formatter = DateFormatter()

            if currentYear == dateYear {
                formatter.dateFormat = "EEE, d MMMM"
            } else {
                formatter.dateFormat = "EEE, d MMMM YYYY"
            }

            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
