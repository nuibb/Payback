//
//  Bundle.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

extension Bundle {
    var isProduction: Bool {
    #if DEBUG
        return false
    #else
        guard let path = self.appStoreReceiptURL?.path else {
            return true
        }
        return !path.contains("sandboxReceipt")
    #endif
    }
}
