//
//  PokemonInfoTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class PokemonInfoTests: XCTestCase {

    func testDecoding() throws {
        do {
            let data = try jsonData(fileName: "PokemonInfo")
            let pokemonInfo = try JSONDecoder().decode(PokemonInfo.self, from: data)
            
            XCTAssertEqual(pokemonInfo.name, "pikachu", "Name should be 'pikachu'")
            XCTAssertEqual(pokemonInfo.detailsURL, "https://pokeapi.co/api/v2/pokemon/25/", "Details URL should be 'https://pokeapi.co/api/v2/pokemon/25/'")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
    
    func testEquatable() {
        let pokemonInfo1 = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        let pokemonInfo2 = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        
        XCTAssertEqual(pokemonInfo1, pokemonInfo2, "Instances should be equal")
    }
    
    func testHashable() {
        let pokemonInfo1 = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        let pokemonInfo2 = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        
        XCTAssertEqual(pokemonInfo1.hashValue, pokemonInfo2.hashValue, "Hash values should be equal")
    }
    
    func testInitialization() {
        let pokemonInfo = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        XCTAssertNotNil(pokemonInfo)
    }
    
    func testLoadPokemonDetails() async {
        let pokemonInfo = PokemonInfo(name: "pikachu", detailsURL: "https://pokeapi.co/api/v2/pokemon/25/")
        
        do {
            if let pokemon = try await pokemonInfo.loadPokemonDetails() {
                XCTAssertEqual(pokemon.name, "pikachu", "Loaded Pokemon name should be 'pikachu'")
            } else {
                XCTFail("Failed to load Pokemon details")
            }
        } catch {
            XCTFail("Failed to load Pokemon details with error: \(error)")
        }
    }
    
}
