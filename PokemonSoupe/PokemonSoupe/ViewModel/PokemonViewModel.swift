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
    
    func fetchPokemons() async throws {
        try await downloadPokemons(by: apiUrlString) { foundPokemons in
            self.results = foundPokemons
            self.fetching = false
        }
    }
    
    func loadMorePokemons() async throws {
        let nextURL = results.last?.next ?? ""
        
        try await downloadPokemons(by: nextURL) { morePokemons in
            self.results.append(contentsOf: morePokemons)
            if self.allLodadedPokemons == self.results.first?.count {
                self.isMorePokemonsAvailable = false
            }
        }
    }
    
    private func downloadPokemons(by url: String, completion: @escaping ([PokemonListInfo]) -> Void) async throws {
                
        var pokemonsList = try! await downloadPokemonList(by: url)
        let group = DispatchGroup()

        ///
        /// Solution with .flatMap (alternative load of pokemon details). Can be used instead of nested for...in.
        ///
        /*for pokemonInfo in morePokemons.flatMap({ $0.pokemons }) {
            group.enter()
            let pokemon = try! await pokemonInfo.fetchDetails()
            let index = morePokemons.firstIndex(where: { $0.pokemons.contains(pokemonInfo) }) ?? 0
            morePokemons[index].pokemons[morePokemons[index].pokemons.firstIndex(of: pokemonInfo)!].detailsPokemon = pokemon

            group.leave()
        }*/
        ///
        
        for i in 0..<pokemonsList.count {
            for j in 0..<pokemonsList[i].pokemonsInfo.count {
                group.enter()
                let pokemon = try! await pokemonsList[i].pokemonsInfo[j].loadPokemonDetails()
                pokemonsList[i].pokemonsInfo[j].detailsPokemon = pokemon
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(pokemonsList)
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
            self.allLodadedPokemons += result.pokemonsInfo.count
            
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
