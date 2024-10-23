//
//  Stat.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct Stat: Hashable, Equatable {
    let id: Int
    let name: String
    let gameIndex: Int
    let isBattleOnly: Bool
    
    init(id: Int, name: String, gameIndex: Int, isBattleOnly: Bool) {
        self.id = id
        self.name = name
        self.gameIndex = gameIndex
        self.isBattleOnly = isBattleOnly
    }
}

struct StatItem: Decodable {
    let id: Int
    let name: String
    let game_index: Int
    let is_battle_only: Bool
    
    var stat: Stat {
        return Stat(id: id, name: name, gameIndex: game_index, isBattleOnly: is_battle_only)
    }
}

class StatMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> Stat {
        guard response.statusCode == 200, let statData = try? JSONDecoder().decode(StatItem.self, from: data) else {
            throw GeneralError.invalidData
        }
        return statData.stat
    }
}
