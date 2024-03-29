//
//  TransactionList.swift
//  WorldOfPAYBACK
//
//  Created by Nurul Islam on 30/1/24.
//

import Foundation

/// MARK: Handle any kind of missing value/property from the server
struct Transactions: Decodable {
    let items: [TransactionItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decodeIfPresent([TransactionItem].self, forKey: .items) ?? []
    }
}

struct TransactionItem: Decodable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail?
    
    enum CodingKeys: String, CodingKey {
        case partnerDisplayName, alias, category, transactionDetail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        partnerDisplayName = try container.decodeIfPresent(String.self, forKey: .partnerDisplayName) ?? ""
        alias = try container.decode(Alias.self, forKey: .alias)
        category = try container.decodeIfPresent(Int.self, forKey: .category) ?? 0
        transactionDetail = try container.decodeIfPresent(TransactionDetail.self, forKey: .transactionDetail)
    }
}

struct Alias: Decodable {
    let reference: String
    
    enum CodingKeys: String, CodingKey {
        case reference
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            reference = try container.decode(String.self, forKey: .reference)
        } catch {
            Logger.log(type: .error, "[Alias][Reference] decode failed: \(error.localizedDescription)")
            reference = ""
        }
    }
}

struct TransactionDetail: Decodable {
    let description: String
    let bookingDate: String
    let value: Value?
    
    enum CodingKeys: String, CodingKey {
        case description, bookingDate, value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        bookingDate = try container.decodeIfPresent(String.self, forKey: .bookingDate) ?? ""
        value = try container.decodeIfPresent(Value.self, forKey: .value)
    }
}

struct Value: Decodable {
    let amount: Int
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case amount, currency
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        amount = try container.decodeIfPresent(Int.self, forKey: .amount) ?? 0
        currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
    }
}
