//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import Foundation

final class TransactionListViewModel: ObservableObject {
    @Published var toastMessage: String = ""
    @Published var isRequesting: Bool = false
    @Published var showToast: Bool = false
    @Published var transactions: [Transaction] = []
    @Published var selectedCategory: String = "Select a category"
    
    var cachedTransactions: [Transaction] = []
    let dataProvider: TransactionDataProvider

    init(dataProvider: TransactionDataProvider) {
        self.dataProvider = dataProvider
        Utils.after(seconds: 1) {
            self.fetchTransactions()
        }
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
                    self.cachedTransactions = data.items
                    self.transactions = self.cachedTransactions
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
        toastMessage = msg
        showToast = true
        Utils.after(seconds: 5.0) {
            self.toastMessage = ""
        }
    }
}
