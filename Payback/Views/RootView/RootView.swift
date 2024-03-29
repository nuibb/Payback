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
            
            /// Injecting dependency for defining data provider based on Schema...
            /// Mock data for local and API response for DEV/QA/DEMO/PROD environment.
            TransactionListView(
                viewModel: TransactionListViewModel(
                    dataProvider: Config.shared.getDataProvider()))
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
