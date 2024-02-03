//
//  TransactionCardView.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import SwiftUI

struct TransactionCardView: View {
    let transaction: Transaction

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                Text(transaction.displayName)
                    .foregroundColor(.white)
                    .font(.circular(.headline))

                Spacer()

                if transaction.amount > 0 && !transaction.currency.isEmpty {
                    Text(transaction.amount.formatted(.currency(code: transaction.currency).grouping(.automatic)))
                        .foregroundColor(.white)
                        .font(.circular(.headline).weight(.bold))
                }
            }

            Text(transaction.bookingDate.formatted())
                .foregroundColor(.white)
                .font(.circular(.subheadline))

            Text(transaction.description)
                .foregroundColor(.white)
                .font(.circular(.subheadline))
        }
    }
}
