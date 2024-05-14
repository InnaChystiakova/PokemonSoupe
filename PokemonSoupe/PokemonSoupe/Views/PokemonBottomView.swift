//
//  PokemonBottomView.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import SwiftUI

struct PokemonBottomView: View {
    var viewModel: PokemonViewModel
    
    var body: some View {
        ProgressView()
            .task {
                do { try await viewModel.loadMorePokemons() }
                catch { print("Error loading more pokemons:", error) }
            }
    }
}
