//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import Foundation

final class TransactionListViewModel: ObservableObject {
    @Published var responseMessage: String = ""
    @Published var isRequesting: Bool = false
    @Published var transactions: [Transaction] = []
    
    let dataProvider: TransactionDataProvider

    init(dataProvider: TransactionDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func fetchTransactions() {
        
        self.isRequesting = true
        
        Task { [weak self] in
            guard let self = self else { return }
            let response = await dataProvider.fetchTransactions()
            if case .success(let data) = response {
                DispatchQueue.main.async {
                    Logger.log(type: .error, "[Response][Data]: \(data)")
                    self.isRequesting = false
                    self.transactions = data.items
                }
            } else if case .failure(let error) = response {
                Logger.log(type: .error, "[Request] failed: \(error.description)")
                DispatchQueue.main.async {
                    self.isRequesting = false
                    self.displayMessage(error.description)
                }
            } else {
                DispatchQueue.main.async {
                    self.isRequesting = false
                    self.displayMessage(RequestError.unknown.description)
                }
            }
        }
    }
    
    func displayMessage(_ msg: String) {
        responseMessage = msg
        Utils.after(seconds: 5.0) {
            self.responseMessage = ""
        }
    }

}
