//
//  MockDataProvider.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/01/2024.
//

import Foundation

class MockDataProvider: TransactionDataProvider {
    let networkMonitor: NetworkMonitor = NetworkMonitor()

    func fetchTransactions() async -> Result<Transactions, RequestError> {
        if self.networkMonitor.isConnected {
            return Bundle.main.decode("data.json")
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}
