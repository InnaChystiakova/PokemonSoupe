//
//  Stat.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct Stat: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case gameIndex = "game_index"
        case isBattleOnly = "is_battle_only"
    }
    
    let id: Int
    let name: String
    let gameIndex: Int
    let isBattleOnly: Bool
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        gameIndex = try container.decode(Int.self, forKey: .gameIndex)
        isBattleOnly = try container.decode(Bool.self, forKey: .isBattleOnly)
    }
    
    init(id: Int, name: String, gameIndex: Int, isBattleOnly: Bool) {
        self.id = id
        self.name = name
        self.gameIndex = gameIndex
        self.isBattleOnly = isBattleOnly
    }
}
