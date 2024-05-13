//
//  PokemonInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

struct PokemonInfo: Decodable, Hashable {
    var name: String
    var detailsURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case detailsURL = "url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        detailsURL = try container.decode(String.self, forKey: .detailsURL)
    }
}
