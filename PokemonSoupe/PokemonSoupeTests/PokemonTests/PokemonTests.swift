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
        do {
            let data = try jsonData(fileName: "Pokemon")
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
