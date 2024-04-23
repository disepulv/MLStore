//
//  Sort.swift
//  MLStore
//
//  Created by Diego Sepulveda on 23-04-24.
//

import Foundation
struct Sort : Codable, Hashable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
