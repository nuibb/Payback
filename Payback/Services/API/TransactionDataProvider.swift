//
//  TransactionDataFetcher.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

protocol TransactionDataProvider: HTTPClient {
    func fetchTransactions() async -> Swift.Result<Transactions, RequestError>
}

extension TransactionDataProvider {
    func fetchTransactions() async -> Swift.Result<Transactions, RequestError> {
        if self.networkMonitor.isConnected {
            return await getRequest(endpoint: TransactionEndPoints.transactions, responseModel: Transactions.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}
