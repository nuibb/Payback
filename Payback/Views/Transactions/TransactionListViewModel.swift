//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import Foundation
import SwiftUI

final class TransactionListViewModel: ObservableObject {
    @Published var toastMessage: String = ""
    @Published var messageColor: Color = MessageType.error.color
    @Published var isRequesting: Bool = false
    @Published var showToast: Bool = false
    @Published var transactions: [Transaction] = []
    @Published var selectedCategory: String = String(localized: "Select a category")
    
    var cachedTransactions: [Transaction] = []
    let dataProvider: TransactionDataProvider
    var categories: [(Int, Color)] = []

    init(dataProvider: TransactionDataProvider) {
        self.dataProvider = dataProvider
        Utils.after(seconds: 1) {
            self.fetchTransactions()
        }
    }
    
    private func fetchTransactions() {
        
        self.isRequesting = true
        
        Task { [weak self] in
            guard let self = self else { return }
            let response = await dataProvider.fetchTransactions()
            if case .success(let data) = response {
                DispatchQueue.main.async {
                    Logger.log(type: .error, "[Response][Data]: \(data)")
                    self.isRequesting = false
                    self.loadData(data.items)
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
    
    private func loadData(_ items: [Transaction]) {
        self.cachedTransactions = items
        self.transactions = self.cachedTransactions
        /// There is a random chance to have same color for multiple categories for this demo. But in real project, there may have defined categories with defined color
        self.categories = Array(Set(self.cachedTransactions.compactMap { $0.categoryType })).sorted().map { ($0, Color.random) }
    }
    
    private func displayMessage(_ msg: String) {
        toastMessage = msg
        showToast = true
        Utils.after(seconds: 5.0) {
            self.toastMessage = ""
        }
    }
}
