//
//  StatListInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct  StatListInfo: Decodable {
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case stats = "results"
    }
    
    let count: Int
    let next: Int?
    let previous: Int?
    var stats: [StatInfo]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try? container.decode(Int.self, forKey: .next)
        previous = try? container.decode(Int.self, forKey: .previous)
        stats = try container.decode([StatInfo].self, forKey: .stats)
    }
}
