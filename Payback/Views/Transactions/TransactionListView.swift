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
                
                //MARK: Header Section
                HStack {
                    
                    if !viewModel.categories.isEmpty {
                        Menu {
                            SwiftUI.Button(action: {
                                viewModel.selectedCategory = String(localized: "Select a category")
                                viewModel.transactions = viewModel.cachedTransactions
                            }) {
                                Text(String(localized:"None"))
                                    .font(.circular(.callout))
                                    .foregroundColor(.textBlack)
                            }
                            
                            ForEach(viewModel.categories, id: \.self.0) { category in
                                Button(action: {
                                    viewModel.selectedCategory = String(category.0)
                                    viewModel.transactions = viewModel.cachedTransactions.filter { $0.categoryType == category.0 }
                                }) {
                                    Text(String(category.0))
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
                    }
                    
                    Spacer()
                    
                    if let currency = viewModel.transactions.first?.currency, !currency.isEmpty, totalAmount > 0 {
                        Text(String(localized:"Total Amount: \(totalAmount.formatted(.currency(code: currency).grouping(.automatic)))"))
                            .foregroundColor(.primaryColor)
                            .font(.circular(.callout))
                    }
                }
                .padding(.horizontal)
                
                //MARK: Transactions
                ZStack {
                    
                    //MARK: Progress View
                    if viewModel.isRequesting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                            .zIndex(1)
                    }
                    
                    if !viewModel.transactions.isEmpty {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(alignment: .leading) {
                                ForEach(viewModel.transactions.sorted { $0.bookingDate < $1.bookingDate }, id:\.id) { transaction in
                                    let color = getTemplateColor(for: transaction.categoryType)
                                    NavigationLink(destination: TransactionDetailsView(transaction: transaction, color: color)) {
                                        TransactionCardView(transaction: transaction)
                                            .padding()
                                            .background(color)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                        }
                        .zIndex(0)
                    } else {
                        if !viewModel.isRequesting {
                            Text(String(localized:"No Transactions Available!"))
                                .font(.circular(.callout))
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
            }
            .navigationBarTitle(Text(String(localized: "Transactions")), displayMode: .inline)
            .showToast(isShowing: $viewModel.showToast, message: viewModel.toastMessage, color: viewModel.messageColor)
            .navigationBarItems(trailing: addRightNavButton())
        }
    }
}

extension TransactionListView {
    @ViewBuilder
    func addRightNavButton() -> some View {
        HStack(spacing: 0) {
            Spacer()
            
            SwiftUI.Button(action: {
                viewModel.fetchTransactions()
            }) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(.primaryColor)
            }
            .disabled(viewModel.isRequesting || viewModel.showToast)
        }
    }
}

extension TransactionListView {
    private var totalAmount: Decimal {
        return viewModel.transactions.reduce(0) { (result, element) in
            return result + element.amount
        }
    }
    
    private func getTemplateColor(for category: Int) -> Color {
        let color = viewModel.categories.first { $0.0 == category }?.1 ?? Color.blue
        return color == .white ? .blue : color /// avoiding same foreground and background color to be invisible
    }
}

#Preview {
    TransactionListView(
        viewModel: TransactionListViewModel(dataProvider: MockDataProvider())
    )
}

#Preview {
    TransactionListView(
        viewModel: TransactionListViewModel(dataProvider: ApiDataProvider())
    )
}

