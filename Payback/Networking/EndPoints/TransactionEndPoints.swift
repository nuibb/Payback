//
//  TransactionEndPoints.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

enum TransactionEndPoints: Endpoint {
    case transactions
}

extension TransactionEndPoints {
    
    // MARK: path includes a leading '/'
    var path: String {
        switch self {
        case .transactions:
            return "/transactions"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .transactions:
            return .get
        }
    }
}
