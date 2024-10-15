//
//  PokemonListInfoTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class PokemonListInfoTests: XCTestCase {

    func testDecoding() throws {
        do {
            let data = try jsonData(fileName: "PokemonListInfo")
            let pokemonListInfo = try JSONDecoder().decode(PokemonListInfo.self, from: data)
            
            XCTAssertEqual(pokemonListInfo.count, 1118, "Count should be 1118")
            XCTAssertEqual(pokemonListInfo.next, "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", "Next URL should be 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20'")
            XCTAssertNil(pokemonListInfo.previous, "Previous URL should be nil")
            XCTAssertEqual(pokemonListInfo.pokemonsInfo.count, 3, "There should be 2 PokemonInfo objects")
            XCTAssertEqual(pokemonListInfo.pokemonsInfo[0].name, "bulbasaur", "First Pokemon name should be 'bulbasaur'")
            XCTAssertEqual(pokemonListInfo.pokemonsInfo[0].detailsURL, "https://pokeapi.co/api/v2/pokemon/1/", "First Pokemon details URL should be 'https://pokeapi.co/api/v2/pokemon/1/'")
            XCTAssertEqual(pokemonListInfo.pokemonsInfo[1].name, "ivysaur", "Second Pokemon name should be 'ivysaur'")
            XCTAssertEqual(pokemonListInfo.pokemonsInfo[1].detailsURL, "https://pokeapi.co/api/v2/pokemon/2/", "Second Pokemon details URL should be 'https://pokeapi.co/api/v2/pokemon/2/'")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
    
    func testHashable() {
        let pokemonListInfo1 = PokemonListInfo(
            count: 1118,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            pokemonsInfo: []
        )
        let pokemonListInfo2 = PokemonListInfo(
            count: 1118,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            pokemonsInfo: []
        )
        
        XCTAssertEqual(pokemonListInfo1.hashValue, pokemonListInfo2.hashValue, "Hash values should be equal")
    }
    
    func testInitialization() {
        let pokemonListInfo = PokemonListInfo(
            count: 1118,
            next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            previous: nil,
            pokemonsInfo: []
        )
        XCTAssertNotNil(pokemonListInfo)
    }
}
