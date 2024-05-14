//
//  PokemonListView.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($viewModel.results, id: \.self) { element in
                    ForEach(element.pokemonsInfo, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailsView()){
                            vCell(pokemon: pokemon)
                        }
                    }
                }
                if (viewModel.isMorePokemonsAvailable) {
                    BottomView(viewModel: viewModel)
                }
            }
            .overlay {
                if (viewModel.fetching) {
                    ProgressView("Fetching data, please wait...")
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: .accentColor)
                        )
                }
            }
            .task {
                do { try await viewModel.fetchPokemons() }
                catch { print("Error fetching pokemons:", error) }
            }
            .navigationTitle("Pokemons")
        }
    }
}

struct vCell: View {
    @Binding var pokemon: PokemonInfo
    
    var body: some View {
        HStack {
            PokemonImageView(imageURL: pokemon.detailsPokemon?.images?.frontDefault ??
                             pokemon.detailsPokemon?.images?.frontShiny ?? "")
            .frame(width: 50, height: 50)
            Text(pokemon.name)
        }
    }
}

struct BottomView: View {
    var viewModel: PokemonViewModel
    
    var body: some View {
        ProgressView()
            .task {
                do { try await viewModel.loadMorePokemons() }
                catch { print("Error loading more pokemons:", error) }
            }
    }
}

#Preview {
    PokemonListView()
}
