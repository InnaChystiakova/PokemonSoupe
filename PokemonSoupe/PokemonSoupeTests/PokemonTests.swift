//
//  PokemonTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class PokemonTests: XCTestCase {

    func testDecoding() {
        let json = """
        {
            "id": 25,
            "name": "Pikachu",
            "weight": 60,
            "height": 4,
            "base_experience": 112,
            "is_default": true,
            "sprites": {
                "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
            },
            "stats": [
                {
                    "base_stat": 35,
                    "effort": 0,
                    "stat": {
                        "name": "hp",
                        "url": "https://pokeapi.co/api/v2/stat/1/"
                    }
                },
                {
                    "base_stat": 55,
                    "effort": 0,
                    "stat": {
                        "name": "attack",
                        "url": "https://pokeapi.co/api/v2/stat/2/"
                    }
                },
                {
                    "base_stat": 40,
                    "effort": 0,
                    "stat": {
                        "name": "defense",
                        "url": "https://pokeapi.co/api/v2/stat/3/"
                    }
                },
                {
                    "base_stat": 50,
                    "effort": 0,
                    "stat": {
                        "name": "special-attack",
                        "url": "https://pokeapi.co/api/v2/stat/4/"
                    }
                },
                {
                    "base_stat": 50,
                    "effort": 0,
                    "stat": {
                        "name": "special-defense",
                        "url": "https://pokeapi.co/api/v2/stat/5/"
                    }
                },
                {
                    "base_stat": 90,
                    "effort": 2,
                    "stat": {
                        "name": "speed",
                        "url": "https://pokeapi.co/api/v2/stat/6/"
                    }
                }
            ]
        }
        """

        let data = json.data(using: .utf8)!
        do {
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            
            XCTAssertEqual(pokemon.id, 25)
            XCTAssertEqual(pokemon.name, "Pikachu")
            XCTAssertEqual(pokemon.weight, 60)
            XCTAssertEqual(pokemon.height, 4)
            XCTAssertTrue(pokemon.isDefault)
            XCTAssertEqual(pokemon.baseExperience, 112)
            
            XCTAssertNotNil(pokemon.images)
            XCTAssertEqual(pokemon.images?.frontDefault, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
            
            XCTAssertEqual(pokemon.stats.count, 6)
            XCTAssertEqual(pokemon.stats[0].baseStat, 35)
            XCTAssertEqual(pokemon.stats[0].effort, 0)
            
            XCTAssertGreaterThan(pokemon.id, 0, "ID is non negative")
            
            XCTAssertFalse(pokemon.name.isEmpty, "Name is not null")
            
            XCTAssertGreaterThan(pokemon.weight, 0, "Non negative")
            XCTAssertGreaterThan(pokemon.height, 0, "Non negative")
            
            XCTAssertGreaterThanOrEqual(pokemon.baseExperience, 0, "Non negative")
            
        } catch {
            XCTFail("Failed to decode Pokemon: \(error)")
        }
    }
}
