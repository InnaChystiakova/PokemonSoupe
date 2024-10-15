//
//  PokemonImageTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class PokemonImageTests: XCTestCase {

    func testDecoding() throws {
        do {
            let data = try jsonData(fileName: "PokemonImage")
            let pokemonImage = try JSONDecoder().decode(PokemonImage.self, from: data)
            
            XCTAssertEqual(pokemonImage.backDefault, "back_default_image_url", "Back default image URL should match")
            XCTAssertEqual(pokemonImage.backFemale, "back_female_image_url", "Back female image URL should match")
            XCTAssertEqual(pokemonImage.backShiny, "back_shiny_image_url", "Back shiny image URL should match")
            XCTAssertEqual(pokemonImage.backShinyFemale, "back_shiny_female_image_url", "Back shiny female image URL should match")
            XCTAssertEqual(pokemonImage.frontDefault, "front_default_image_url", "Front default image URL should match")
            XCTAssertEqual(pokemonImage.frontFemale, "front_female_image_url", "Front female image URL should match")
            XCTAssertEqual(pokemonImage.frontShiny, "front_shiny_image_url", "Front shiny image URL should match")
            XCTAssertEqual(pokemonImage.frontShinyFemale, "front_shiny_female_image_url", "Front shiny female image URL should match")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
}
