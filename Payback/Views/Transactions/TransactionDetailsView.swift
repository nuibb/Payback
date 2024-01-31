//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import SwiftUI

struct TransactionDetailsView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            TransactionCardView(transaction: transaction)
        }
    }
}
//
//#Preview {
//    TransactionDetailsView(transaction: Transaction())
//}
