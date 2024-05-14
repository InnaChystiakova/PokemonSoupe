//
//  PokemonListView.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonViewModel()
    @State private var searchText = ""
    @State private var isSearchDrawerOpen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.results, id: \.self) { element in
                    ForEach(element.pokemonsInfo, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon.detailsPokemon)){
                            PokemonCell(pokemon: pokemon)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                if (viewModel.isMorePokemonsAvailable) {
                    PokemonBottomView(viewModel: viewModel)
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
            .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea())
            .task {
                do { try await viewModel.fetchPokemons() }
                catch { print("Error fetching pokemons:", error) }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemons")
            .navigationBarTitleDisplayMode(.automatic)
            .tint(.white)
        }
    }
}

#Preview {
    PokemonListView()
}
