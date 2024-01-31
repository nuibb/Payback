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
                Text(transaction.partnerDisplayName)
                    .foregroundColor(.white)
                    .font(.circular(.headline))

                Spacer()

                if let currency = transaction.transactionDetail?.value?.currency {
                    Text("\(currency) ")
                        .foregroundColor(.white)
                        .font(.circular(.headline))
                }

                if let amount = transaction.transactionDetail?.value?.amount {
                    Text(String(amount))
                        .foregroundColor(.white)
                        .font(.circular(.headline).weight(.bold))
                }
            }

            Text((transaction.transactionDetail?.bookingDate ?? "").formatDateString)
                .foregroundColor(.white)
                .font(.circular(.subheadline))

            Text(transaction.transactionDetail?.description ?? "")
                .foregroundColor(.white)
                .font(.circular(.subheadline))

        }
    }
}

//#Preview {
//    TransactionCardView(transaction: Transaction(from: <#Decoder#>))
//}
