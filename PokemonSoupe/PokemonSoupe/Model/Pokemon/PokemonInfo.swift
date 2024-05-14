//
//  PokemonInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

struct PokemonInfo: Decodable {
    
    var name: String
    var detailsURL: String
    var detailsPokemon: Pokemon?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case detailsURL = "url"
    }
    
    init(name: String, detailsURL: String) {
        self.name = name
        self.detailsURL = detailsURL
        self.detailsPokemon = nil
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        detailsURL = try container.decode(String.self, forKey: .detailsURL)
    }
    
    func loadPokemonDetails() async throws -> Pokemon? {
        guard let url = URL(string: detailsURL) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemonData = try? JSONDecoder().decode(Pokemon.self, from: data)
            return pokemonData ?? nil
        } catch {
            print("Error fetching pokemon details for \(name):", error)
            return nil
        }
    }
}

extension PokemonInfo: Equatable {
    static func == (lhs: PokemonInfo, rhs: PokemonInfo) -> Bool {
        return lhs.name == rhs.name && lhs.detailsURL == rhs.detailsURL
    }
}

extension PokemonInfo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(detailsURL)
    }
}
