//
//  PokemonCell.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import SwiftUI

struct PokemonCell: View {
    @Binding var pokemon: PokemonInfo
    
    var body: some View {
        HStack(spacing: 20) {
            PokemonImageView(imageURL: pokemon.detailsPokemon?.images?.frontDefault ??
                             pokemon.detailsPokemon?.images?.frontShiny ?? "")
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            Text(pokemon.name.capitalizedFirstLetter)
                .font(.custom("Zapfino", size: 15))
        }
    }
}
