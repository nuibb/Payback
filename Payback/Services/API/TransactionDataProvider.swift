//
//  TransactionDataFetcher.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

protocol TransactionDataProvider: HTTPClient {
    func fetchTransactions() async -> Swift.Result<TransactionList, RequestError>
}

extension TransactionDataProvider {
    func fetchTransactions() async -> Swift.Result<TransactionList, RequestError> {
        if self.networkMonitor.isConnected {
            return await getRequest(endpoint: TransactionEndPoints.transactions, responseModel: TransactionList.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}
