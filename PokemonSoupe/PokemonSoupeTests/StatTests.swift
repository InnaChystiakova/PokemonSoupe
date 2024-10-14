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
        let statData = try jsonData(fileName: "StatData")
        
        do {
            let stat = try JSONDecoder().decode(Stat.self, from: statData)
            XCTAssertEqual(stat.id, 1, "ID should match")
            XCTAssertEqual(stat.name, "hp", "Name should match")
            XCTAssertEqual(stat.gameIndex, 1, "Game index should match")
            XCTAssertFalse(stat.isBattleOnly, "isBattleOnly should be false")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
    
    func testInitialization() {
        let testStat = Stat(id: 123, name: "Test Stat", gameIndex: 3, isBattleOnly: true)
        XCTAssertNotNil(testStat)
    }
}
