//
//  StatTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class StatTests: XCTestCase {

    func testDecoding() throws {
        let json = """
        {
            "id": 1,
            "name": "hp",
            "game_index": 1,
            "is_battle_only": false
        }
        """
        let data = json.data(using: .utf8)!
        
        let stat = try JSONDecoder().decode(Stat.self, from: data)
        
        XCTAssertEqual(stat.id, 1, "ID should match")
        XCTAssertEqual(stat.name, "hp", "Name should match")
        XCTAssertEqual(stat.gameIndex, 1, "Game index should match")
        XCTAssertFalse(stat.isBattleOnly, "isBattleOnly should be false")
    }
}
