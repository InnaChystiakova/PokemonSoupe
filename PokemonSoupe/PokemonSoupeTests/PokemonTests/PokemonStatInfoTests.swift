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
        do {
            let data = try jsonData(fileName: "PokemonStatInfo")
            let pokemonStatInfo = try JSONDecoder().decode(PokemonStatInfo.self, from: data)
            
            XCTAssertEqual(pokemonStatInfo.baseStat, 100, "Base stat should match")
            XCTAssertEqual(pokemonStatInfo.effort, 2, "Effort should match")
            XCTAssertEqual(pokemonStatInfo.statInfo.name, "hp", "Stat name should match")
            XCTAssertEqual(pokemonStatInfo.statInfo.statURL, "https://pokeapi.co/api/v2/stat/1/", "Stat URL should match")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
    
    func testEquatable() {
        let statInfo = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        let pokemonStatInfo1 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo)
        let pokemonStatInfo2 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo)
        
        XCTAssertEqual(pokemonStatInfo1, pokemonStatInfo2, "Instances should not be equal")
        XCTAssertEqual(pokemonStatInfo1.baseStat, pokemonStatInfo2.baseStat, "BaseStat should not be equal")
        XCTAssertEqual(pokemonStatInfo1.effort, pokemonStatInfo2.effort, "Effort should not be equal")
    }
    
    func testNotEquatable() {
        let statInfo1 = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        let pokemonStatInfo1 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo1)
        let statInfo2 = StatInfo(name: "attack", statURL: "https://pokeapi.co/api/v2/stat/2/")
        let pokemonStatInfo2 = PokemonStatInfo(baseStat: 85, effort: 3, statInfo: statInfo2)
        
        XCTAssertNotEqual(pokemonStatInfo1, pokemonStatInfo2, "Instances should not be equal")
        XCTAssertNotEqual(pokemonStatInfo1.baseStat, pokemonStatInfo2.baseStat, "BaseStat should not be equal")
        XCTAssertNotEqual(pokemonStatInfo1.effort, pokemonStatInfo2.effort, "Effort should not be equal")
    }
    
    func testHashable() {
        let statInfo1 = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        let pokemonStatInfo1 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo1)
        let statInfo2 = StatInfo(name: "attack", statURL: "https://pokeapi.co/api/v2/stat/2/")
        let pokemonStatInfo2 = PokemonStatInfo(baseStat: 80, effort: 2, statInfo: statInfo2)
        
        XCTAssertEqual(pokemonStatInfo1.hashValue, pokemonStatInfo2.hashValue, "Hash values should be equal")
    }
}

