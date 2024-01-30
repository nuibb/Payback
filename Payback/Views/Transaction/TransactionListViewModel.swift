//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import Foundation

final class TransactionListViewModel: ObservableObject {
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }

}
