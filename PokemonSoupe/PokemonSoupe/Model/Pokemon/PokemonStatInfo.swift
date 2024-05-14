//
//  PokemonStat.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct PokemonStatInfo: Decodable {
    let baseStat: Int?
    let effort: Int?
    let statInfo: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort = "effort"
        case statInfo = "stat"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try container.decode(Int.self, forKey: .baseStat)
        effort = try container.decode(Int.self, forKey: .effort)
        statInfo = try container.decode(StatInfo.self, forKey: .statInfo)
    }
}

extension PokemonStatInfo: Equatable {
    static func == (lhs: PokemonStatInfo, rhs: PokemonStatInfo) -> Bool {
        return lhs.baseStat == rhs.baseStat && lhs.effort == rhs.effort
    }
}

extension PokemonStatInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(baseStat)
        hasher.combine(effort)
    }
}
