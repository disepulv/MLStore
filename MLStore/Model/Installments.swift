//
//  Installments.swift
//  MLStore
//
//  Created by Diego Sepulveda on 22-04-24.
//

import Foundation
struct Installments: Codable, Hashable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyId: String
    var description: String {
        "\(quantity)x $\(amount) sin interés"
    }

    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case amount = "amount"
        case rate = "rate"
        case currencyId = "currency_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0
        amount = try values.decodeIfPresent(Double.self, forKey: .amount) ?? 0.0
        rate = try values.decodeIfPresent(Double.self, forKey: .rate) ?? 0.0
        currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId) ?? ""
    }
}
