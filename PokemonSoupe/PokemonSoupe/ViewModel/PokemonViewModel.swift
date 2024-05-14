//
//  PokemonViewModel.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 09/05/2024.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var results = [PokemonListInfo]()
    @Published var statsList = [StatListInfo]()
    @Published var fetching = true
    
    let pokemonUrlString = "https://pokeapi.co/api/v2/pokemon"
    let statUrlString = "https://pokeapi.co/api/v2/stat"
    
    var isMorePokemonsAvailable = true
    var allLodadedPokemons: Int = 0
    
    func fetchPokemons() async throws {
        try await downloadPokemons(by: pokemonUrlString) { foundPokemons in
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
    
    func fetchStats() async throws {
        try await downloadStats(by: statUrlString) { foundStats in
            self.statsList = foundStats
            
            
        }
    }
    
    func filterStatsWithName(name: String) -> Stat? {
        let statsInfo = self.statsList.first?.stats
        let filteredArray = statsInfo?.filter { $0.name == name }
        return filteredArray?.first?.stat ?? nil
    }
    
    private func downloadPokemons(by url: String, completion: @escaping ([PokemonListInfo]) -> Void) async throws {
                
        var pokemonsList = try! await downloadPokemonList(by: url)
        let group = DispatchGroup()

        /// Solution with .flatMap (alternative load of pokemon details). Can be used instead of nested for...in.
        for pokemonInfo in pokemonsList.flatMap({ $0.pokemonsInfo }) {
            group.enter()
            let pokemon = try! await pokemonInfo.loadPokemonDetails()
            let index = pokemonsList.firstIndex(where: { $0.pokemonsInfo.contains(pokemonInfo) }) ?? 0
            pokemonsList[index].pokemonsInfo[pokemonsList[index].pokemonsInfo.firstIndex(of: pokemonInfo)!].detailsPokemon = pokemon

            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(pokemonsList)
        }
    }
    
    private func downloadStats(by url: String, completion: @escaping ([StatListInfo]) -> Void) async throws {
                
        var statList = try! await downloadStatList(by: url)
        let group = DispatchGroup()
        
        for i in 0..<statList.count {
            for j in 0..<statList[i].stats.count {
                group.enter()
                let stat = try! await statList[i].stats[j].loadStatDetails()
                statList[i].stats[j].stat = stat
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(statList)
        }
    }
    
    private func downloadPokemonList(by url: String?) async throws -> [PokemonListInfo] {
        guard let url = URL(string: url ?? "") else {
            return []
        }
        let result: PokemonListInfo = try await downloadData(from: url, decodingType: PokemonListInfo.self)
        DispatchQueue.main.async {
            self.allLodadedPokemons += result.pokemonsInfo.count
        }
        return [result]
    }

    private func downloadStatList(by url: String?) async throws -> [StatListInfo] {
        guard let url = URL(string: url ?? "") else {
            return []
        }
        let result: StatListInfo = try await downloadData(from: url, decodingType: StatListInfo.self)
        DispatchQueue.main.async {
            self.statsList.append(result)
        }
        return [result]
    }
    
    private func downloadData<T: Decodable>(from url: URL, decodingType: T.Type) async throws -> T {
        do {
            let (data, _)  = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(decodingType, from: data)
            return decodedData
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.valueNotFound(value, context)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw DecodingError.typeMismatch(type, context)
        } catch {
            print("error: ", error)
            throw error
        }
    }
}
