//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import SwiftUI

struct TransactionDetailsView: View {
    let transaction: Transaction
    let color: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            
            if !transaction.displayName.isEmpty {
                Text("Name")
                    .foregroundColor(.white)
                    .font(.circular(.footnote))
                
                Text(transaction.displayName)
                    .foregroundColor(.white)
                    .font(.circular(.headline))
                    .padding(.bottom)
            }
            
            if !transaction.description.isEmpty {
                Text("Description")
                    .foregroundColor(.white)
                    .font(.circular(.footnote))
                
                Text(transaction.description)
                    .foregroundColor(.white)
                    .font(.circular(.headline))
            }
        }
        .frame(width: 250, height: 250)
        .background(color)
        .cornerRadius(8)
        .navigationBarTitle(Text(String(localized: "Transaction Details")), displayMode: .inline)
    }
}
