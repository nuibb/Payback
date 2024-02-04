//
//  ApiService.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

struct ApiDataProvider: TransactionDataProvider {
    let networkMonitor: NetworkMonitor = NetworkMonitor()
}
