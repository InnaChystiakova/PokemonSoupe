//
//  Pokemon.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case weight = "weight"
    case height = "height"
    case baseExperience = "base_experience"
    case images = "sprites"
    case isDefault = "is_default"
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
    var weight: Int
    var height: Int
    var baseExperience: Int
    var isDefault: Bool
    var images: PokemonImage?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        weight = try container.decode(Int.self, forKey: .weight)
        height = try container.decode(Int.self, forKey: .height)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        images = try? container.decode(PokemonImage.self, forKey: .images)
    }
}

struct PokemonImage: Decodable {
    
    let backDefault: String?
    let backFemale: String?
    var backShiny: String?
    var backShinyFemale: String?
    var frontDefault: String?
    var frontFemale: String?
    var frontShiny: String?
    var frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        backDefault = try? container?.decode(String.self, forKey: .backDefault)
        backFemale = try? container?.decode(String.self, forKey: .backFemale)
        backShiny = try? container?.decode(String.self, forKey: .backShiny)
        backShinyFemale = try? container?.decode(String.self, forKey: .backShinyFemale)
        frontDefault = try? container?.decode(String.self, forKey: .frontDefault)
        frontFemale = try? container?.decode(String.self, forKey: .frontFemale)
        frontShiny = try? container?.decode(String.self, forKey: .frontShiny)
        frontShinyFemale = try? container?.decode(String.self, forKey: .frontShinyFemale)
    }
    
}
