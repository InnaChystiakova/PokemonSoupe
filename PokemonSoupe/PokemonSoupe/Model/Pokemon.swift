//
//  Pokemon.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

struct Result: Decodable {
    let pokemons: [Pokemon]
}

enum CodingKeys: String, CodingKey {
    case id = "ID"
    case name = "name"
    case weight = "weight"
    case height = "height"
    case baseExperience = "base_experience"
    case images = "sprites"
    case isDefault = "is_default"
}

struct Pokemon: Codable {
    let id: String
    let name: String
    var weight: Int
    var height: Int
    var baseExperience: Int
    var isdefault: Bool
    
    
}
