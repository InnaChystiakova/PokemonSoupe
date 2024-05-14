//
//  StringExt.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
}
