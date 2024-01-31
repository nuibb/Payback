//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionListViewModel

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.transactions, id:\.alias.reference) { transaction in
                            NavigationLink(destination: TransactionDetailsView(transaction: transaction)) {
                                TransactionCardView(transaction: transaction)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(String(localized: "Transactions")), displayMode: .inline)
            .onAppear() {
                viewModel.fetchTransactions()
            }
        }
    }
}

#Preview {
    TransactionListView(
        viewModel: TransactionListViewModel(apiService: ApiService())
    )
}
