//
//  StatInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct StatInfo: Decodable, Hashable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case statURL = "url"
    }
    
    let name: String
    let statURL: String
    var stat: Stat?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        statURL = try container.decode(String.self, forKey: .statURL)
    }
    
    init(name: String, statURL: String) {
        self.name = name
        self.statURL = statURL
    }
    
    func loadStatDetails() async throws -> Stat? {
        guard let url = URL(string: statURL) else { return nil }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let stat = try? StatMapper.map(data: data, response: response as! HTTPURLResponse) else {
                return nil
            }
            return stat
        } catch {
            print("Error fetching stats for \(name):", error)
            return nil
        }
        
//        guard let url = URL(string: statURL) else {
//            throw GeneralError.invalidURL
//        }
//        
//        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
//            throw GeneralError.connectivity
//        }
//        
//        let stat = try StatMapper.map(data: data, response: response as! HTTPURLResponse)
//        return stat
    }
}
