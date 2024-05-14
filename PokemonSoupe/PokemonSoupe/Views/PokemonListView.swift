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
        NavigationStack {
            List {
                ForEach($viewModel.results, id: \.self) { element in
                    ForEach(element.pokemonsInfo, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon.detailsPokemon)){
                            vCell(pokemon: pokemon)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
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

struct vCell: View {
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
