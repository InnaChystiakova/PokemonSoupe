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
                    ForEach(element.pokemons, id: \.self) { pokemon in
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
                await viewModel.fetchPokemons()
            }
            .navigationTitle("Pokemons")
        }
    }
}

struct vCell: View {
    @Binding var pokemon: PokemonInfo
    
    var body: some View {
        HStack {
            Image(systemName: "photo") // Placeholder image
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
                await viewModel.loadMorePokemons()
            }
    }
}

#Preview {
    PokemonListView()
}
