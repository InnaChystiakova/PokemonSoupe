//
//  PokemonViewModel.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var results = [PokemonListInfo]()
    @Published var fetching = true
    
    let apiUrlString = "https://pokeapi.co/api/v2/pokemon"
    
    var isMorePokemonsAvailable = true
    var allLodadedPokemons: Int = 0
    
    func fetchPokemons() async {
        
        let foundPokemons = try! await downloadPokemonList(by: apiUrlString)
        DispatchQueue.main.async {
            self.results = foundPokemons
            self.fetching = false
            
            //load pokemons
        }
    }
    
    func loadMorePokemons() async {
        let nextURL = results.last?.next
        
        let morePokemons = try! await downloadPokemonList(by: nextURL)

        DispatchQueue.main.async {
            self.results.append(contentsOf: morePokemons)
            if self.allLodadedPokemons == self.results.first?.count {
                self.isMorePokemonsAvailable = false
            }
        }
    }
    
    private func downloadPokemonList(by url: String?) async throws -> [PokemonListInfo] {
        guard let url = URL(string: url ?? "") else {
            return []
        }
        var foundPokemons: [PokemonListInfo] = []
        
        do {
            let (data, _)  = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(PokemonListInfo.self, from: data)
            foundPokemons.append(result)
            self.allLodadedPokemons += result.pokemons.count
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return foundPokemons
    }
}
