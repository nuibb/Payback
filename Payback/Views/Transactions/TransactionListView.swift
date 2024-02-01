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
    
    var types: [Int] {
        return Array(Set(viewModel.cachedTransactions.compactMap { $0.categoryType })).sorted()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Menu {
                        SwiftUI.Button(action: {
                            viewModel.selectedCategory = "Select a category"
                            viewModel.transactions = viewModel.cachedTransactions
                        }) {
                            Text("None")
                                .font(.circular(.callout))
                                .foregroundColor(.textBlack)
                        }
                        
                        ForEach(types, id: \.self) { type in
                            Button(action: {
                                viewModel.selectedCategory = String(type)
                                viewModel.transactions = viewModel.cachedTransactions.filter { $0.categoryType == type }
                            }) {
                                Text(String(type))
                            }
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 8) {
                            Image("funnel")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16, alignment: .center)
                                .foregroundColor(.primaryColor)

                            Text(viewModel.selectedCategory)
                                .font(.circular(.callout))
                                .foregroundColor(.primaryColor)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Total Amount: \(totalAmount.formattedValue)")
                        .foregroundColor(.primaryColor)
                        .font(.circular(.callout))
                }
                .padding(.horizontal)
                
                ZStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.transactions.sorted { $0.bookingDate < $1.bookingDate }, id:\.id) { transaction in
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
                    .zIndex(0)
                    
                    if viewModel.isRequesting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .zIndex(1)
                    }
                }
            }
            .navigationBarTitle(Text(String(localized: "Transactions")), displayMode: .inline)
            .showToast(isShowing: $viewModel.showToast, message: viewModel.toastMessage)
        }
    }
}

#Preview {
    TransactionListView(
        viewModel: TransactionListViewModel(dataProvider: MockDataProvider())
    )
}
