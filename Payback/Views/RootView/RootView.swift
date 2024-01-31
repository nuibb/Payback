//
//  RootView.swift
//  Payback
//
//  Created by Nurul Islam on 30/01/2024.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TransactionListView(viewModel: TransactionListViewModel(dataProvider: MockDataProvider()))
                .tabItem {
                    Label("Transaction", systemImage: "dollarsign.arrow.circlepath")
                }

            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "paperplane")
                }

            ShoppingView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    RootView()
}
