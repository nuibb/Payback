//
//  Item.swift
//  Payback
//
//  Created by Nurul Islam on 29/1/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
