//
//  StatListInfoTests.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 15/10/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class StatListInfoTests: XCTestCase {
    
    func testDecoding() throws {
        let statListInfo = try jsonData(fileName: "StatListInfo")
        
        do {
            let listInfo = try JSONDecoder().decode(StatListInfo.self, from: statListInfo)
            XCTAssertEqual(listInfo.count, 8, "Count should match")
            XCTAssertEqual(listInfo.next, 4, "Next list count should match")
            XCTAssertEqual(listInfo.previous, 3, "Previous list info should match")
            XCTAssertNotNil(listInfo.stats)
            XCTAssertEqual(listInfo.stats.count, 8, "Count of stats should match")
        } catch {
            XCTFail("Decoding failed: \(error.localizedDescription)")
        }
    }
}
