//
//  PokemonDetailsView.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import SwiftUI

struct PokemonDetailsView: View {
    @StateObject var viewModel = PokemonViewModel()
    @Binding var pokemon: Pokemon?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                PokemonImageView(imageURL: pokemon?.images?.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 450)
                    .overlay {
                        VStack(alignment: .leading) {
                            let imageName = (pokemon?.isDefault ?? false) ? "circle.badge.checkmark" : "circle.badge.xmark"
                            Image(systemName: imageName)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: 0,
                                    maxHeight: .infinity,
                                    alignment: .topTrailing
                                )
                                .padding()
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .padding(.top, 40)
                            
                            HStack(alignment: .bottom) {
                                let descriptionID = "ID: " + String(pokemon?.id ?? 0)
                                VStack(alignment:.leading, spacing: 5) {
                                    Text(pokemon?.name.capitalizedFirstLetter ?? "Unknown")
                                        .font(.custom("Nunito-Bold", size: 35, relativeTo: .largeTitle))
                                    Text(descriptionID)
                                        .font(.custom("Nunito-Regular", size: 16, relativeTo: .subheadline))
                                        .padding(.all, 5)
                                }
                                
                                Spacer()
                                
                                let hp = "HP: " + String(pokemon?.baseExperience ?? 0)
                                let weight = "Weight: " + String(pokemon?.weight ?? 0)
                                let height = "Height: " + String(pokemon?.height ?? 0)
                                
                                VStack(alignment:.trailing, spacing: 5) {
                                    Text(hp)
                                        .font(.custom("Nunito-Regular", size: 18, relativeTo: .largeTitle))
                                    Text(weight)
                                        .font(.custom("Nunito-Regular", size: 16, relativeTo: .subheadline))
                                    Text(height)
                                        .font(.custom("Nunito-Regular", size: 16, relativeTo: .subheadline))
                                }
                            }
                        }
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .bottomLeading
                        )
                        .foregroundStyle(.white)
                        .padding()
                    }
                let stats = pokemon?.stats ?? []
                ForEach(stats, id: \.self) { stat in
                    let stat = viewModel.filterStatsWithName(name: stat.statInfo.name)
                    VStack (alignment: .leading, spacing: 5){
                        PokemonStatView(stat: stat)
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .bottomLeading
                    )
                    .foregroundStyle(.white)
                    .padding()
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                }
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
        .task {
            do { try await viewModel.fetchStats() }
            catch { print("Error fetching pokemons:", error) }
        }
    }
}

struct PokemonStatView: View {
    var stat: Stat?
    
    var body: some View {
        let id = "Stat ID: " + String(stat?.id ?? 0)
        let name = "Stat name: " + String(stat?.name ?? "Unknown")
        let gameIndex = "Stat game index: " + String(stat?.gameIndex ?? 0)
        
        VStack(alignment: .center, spacing: 5) {
            Text("Pokemon Stat")
            HStack (alignment:.center, spacing: 5) {
                VStack(alignment:.leading, spacing: 5) {
                    Text(id)
                        .font(.custom("Nunito-Regular", size: 18, relativeTo: .largeTitle))
                    Text(name)
                        .font(.custom("Nunito-Regular", size: 16, relativeTo: .subheadline))
                    Text(gameIndex)
                        .font(.custom("Nunito-Regular", size: 16, relativeTo: .subheadline))
                }
                Spacer()
                Image(systemName: (stat?.isBattleOnly ?? false) ? "figure.baseball" : "")
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topTrailing
                    )
                    .padding()
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonDetailsView(pokemon:
                .constant(
                    PokemonViewModel().results.first?.pokemonsInfo.first?.detailsPokemon
                )
        )
    }
}
