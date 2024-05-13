//
//  PokemonListInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 13/05/2024.
//

import Foundation

struct PokemonListInfo: Decodable, Hashable {
    var count: Int
    var next: String?
    var previous: String?
    var pokemons: [PokemonInfo]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case pokemons = "results"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try? container.decode(String.self, forKey: .next)
        previous = try? container.decode(String.self, forKey: .previous)
        pokemons = try container.decode([PokemonInfo].self, forKey: .pokemons)
    }
}
