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
            HStack(alignment: .top) {
                Text(transaction.partnerDisplayName)
                    .foregroundColor(.textBlack)
                    .font(.circular(.headline))

                Spacer()

                Text(transaction.transactionDetail?.value?.currency ?? "" + String(transaction.transactionDetail?.value?.amount ?? 0))
                    .foregroundColor(.primaryColor)
                    .font(.circular(.headline).weight(.semibold))
            }

            Text((transaction.transactionDetail?.bookingDate ?? "").formatDateString)
                .foregroundColor(.textBlack)
                .font(.circular(.subheadline))

            Text(transaction.transactionDetail?.description ?? "")
                .foregroundColor(.textBlack)
                .font(.circular(.subheadline))

        }
    }
}

//#Preview {
//    TransactionCardView(transaction: Transaction(from: <#Decoder#>))
//}
