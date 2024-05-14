//
//  PokemonImage.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

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
