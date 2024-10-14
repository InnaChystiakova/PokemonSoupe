//
//  TestHelper.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/10/2024.
//

import XCTest

extension XCTestCase {
    func jsonData(fileName: String) throws -> Data {
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "MissingFile", code: 404, userInfo: [NSLocalizedDescriptionKey: "Missing file: {\(fileName)}.json"])
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            throw NSError(domain: "FileReadError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to read JSON from file: \(error.localizedDescription)"])
        }
    }
}
