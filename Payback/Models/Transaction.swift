//
//  Transaction.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 31/1/24.
//

import Foundation

protocol Transaction {
    var id: String { get }
    var displayName: String { get }
    var categoryType: Int { get }
    var bookingDate: Date { get }
    var description: String { get }
    var currency: String { get }
    var amount: Decimal { get } // Using decimal to ensure accuracy for currency
}

extension TransactionItem: Transaction {
    var id: String { alias.reference }
    var displayName: String { partnerDisplayName }
    var categoryType: Int { category }
    var bookingDate: Date {
        transactionDetail?.bookingDate.toDateFromTimezone() ?? Date()
    }
    var description: String { transactionDetail?.description ?? "" }
    var currency: String {
        transactionDetail?.value?.currency ?? ""
    }
    var amount: Decimal {
        Decimal(max(0, transactionDetail?.value?.amount ?? 0))
    }
}
