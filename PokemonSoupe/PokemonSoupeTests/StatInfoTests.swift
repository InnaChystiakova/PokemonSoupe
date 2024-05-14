//
//  StatInfoTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class StatInfoTests: XCTestCase {

    func testDecoding() throws {
        // Given
        let json = """
        {
            "name": "hp",
            "url": "https://pokeapi.co/api/v2/stat/1/"
        }
        """
        let data = json.data(using: .utf8)!
        let statInfo = try JSONDecoder().decode(StatInfo.self, from: data)
        
        XCTAssertEqual(statInfo.name, "hp", "Name should match")
        XCTAssertEqual(statInfo.statURL, "https://pokeapi.co/api/v2/stat/1/", "Stat URL should match")
    }
    
    func testLoadStatDetails() {
        let statInfo = StatInfo(name: "hp", statURL: "https://pokeapi.co/api/v2/stat/1/")
        
        let expectation = XCTestExpectation(description: "Load Stat Details")
        Task {
            do {
                let stat = try await statInfo.loadStatDetails()
                XCTAssertNotNil(stat, "Loaded Stat should not be nil")
            } catch {
                XCTFail("Failed to load Stat details: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
