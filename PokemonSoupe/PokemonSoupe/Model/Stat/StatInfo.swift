//
//  StatInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct StatInfo: Decodable {
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
            let (data, _) = try await URLSession.shared.data(from: url)
            let statData = try? JSONDecoder().decode(Stat.self, from: data)
            return statData ?? nil
        } catch {
            print("Error fetching stats for \(name):", error)
            return nil
        }
    }
}
