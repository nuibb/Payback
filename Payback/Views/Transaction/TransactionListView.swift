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
                    }
                }
            }
            .navigationBarTitle(Text(AppConstants.appTitle), displayMode: .inline)
        }
    }
}

#Preview {
    TransactionListView(viewModel: TransactionListViewModel())
}
