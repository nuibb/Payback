//
//  Double.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import Foundation

extension Double {
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return ""
        }
    }
}
