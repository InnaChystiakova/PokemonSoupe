//
//  PokemonListInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 13/05/2024.
//

import Foundation

struct PokemonListInfo: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case pokemons = "results"
    }
    
    var count: Int
    var next: String?
    var previous: String?
    var pokemonsInfo: [PokemonInfo]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try? container.decode(String.self, forKey: .next)
        previous = try? container.decode(String.self, forKey: .previous)
        pokemonsInfo = try container.decode([PokemonInfo].self, forKey: .pokemons)
    }
    
    init(count: Int, next: String?, previous: String?, pokemonsInfo: [PokemonInfo]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.pokemonsInfo = pokemonsInfo
    }
}
