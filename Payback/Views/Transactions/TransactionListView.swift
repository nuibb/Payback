//
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/01/2024.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionListViewModel
    
    var totalAmount: Double {
        return viewModel.transactions.reduce(0) { (result, element) in
            return result + (Double(element.amount))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Total Amount: \(totalAmount.formattedValue)")
                        .foregroundColor(.primaryColor)
                        .font(.circular(.headline).weight(.semibold))
                }
                .padding(.trailing)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.transactions.sorted(by: { $0.bookingDate < $1.bookingDate }), id:\.id) { transaction in
                            NavigationLink(destination: TransactionDetailsView(transaction: transaction)) {
                                TransactionCardView(transaction: transaction)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
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
        viewModel: TransactionListViewModel(dataProvider: MockDataProvider())
    )
}
