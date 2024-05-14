//
//  PokemonStatInfoTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

import XCTest

class PokemonStatInfoTests: XCTestCase {
    
    func testDecoding() throws {
        let json = """
            {
                "base_stat": 100,
                "effort": 2,
                "stat": {
                    "name": "hp",
                    "url": "https://pokeapi.co/api/v2/stat/1/"
                }
            }
            """
        let data = json.data(using: .utf8)!
        let pokemonStatInfo = try JSONDecoder().decode(PokemonStatInfo.self, from: data)
        
        XCTAssertEqual(pokemonStatInfo.baseStat, 100, "Base stat should match")
        XCTAssertEqual(pokemonStatInfo.effort, 2, "Effort should match")
        XCTAssertEqual(pokemonStatInfo.statInfo.name, "hp", "Stat name should match")
        XCTAssertEqual(pokemonStatInfo.statInfo.statURL, "https://pokeapi.co/api/v2/stat/1/", "Stat URL should match")
    }
    
    func testEquatable() {
        let statInfo1 = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        let pokemonStatInfo1 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo1)
        let statInfo2 = StatInfo(name: "attack", statURL: "https://pokeapi.co/api/v2/stat/2/")
        let pokemonStatInfo2 = PokemonStatInfo(baseStat: 85, effort: 3, statInfo: statInfo2)
        
        XCTAssertNotEqual(pokemonStatInfo1, pokemonStatInfo2, "Instances should not be equal")
    }
    
    func testHashable() {
        let statInfo1 = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        let pokemonStatInfo1 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo1)
        let statInfo2 = StatInfo(name: "attack", statURL: "https://pokeapi.co/api/v2/stat/2/")
        let pokemonStatInfo2 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo2)
        
        XCTAssertEqual(pokemonStatInfo1.hashValue, pokemonStatInfo2.hashValue, "Hash values should be equal")
    }
}

