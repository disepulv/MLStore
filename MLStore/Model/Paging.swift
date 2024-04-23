//
//  Paging.swift
//  MLStore
//
//  Created by Diego Sepulveda on 23-04-24.
//

import Foundation
struct Paging : Codable {
    let total: Int
    let primaryResults: Int
    let offset: Int
    let limit: Int

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case primaryResults = "primary_results"
        case offset = "offset"
        case limit = "limit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
        primaryResults = try values.decodeIfPresent(Int.self, forKey: .primaryResults) ?? 0
        offset = try values.decodeIfPresent(Int.self, forKey: .offset) ?? 0
        limit = try values.decodeIfPresent(Int.self, forKey: .limit) ?? 0
    }
}
