//
//  StatListInfo.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation

struct StatListInfo: Hashable, Equatable {
    let count: Int
    let next: Int?
    let previous: Int?
    var stats: [StatInfo]

    init(count: Int, next: Int?, previous: Int?, stats: [StatInfo]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.stats = stats
    }
}

struct StatListInfoItem: Decodable {
    let count: Int
    let next: Int?
    let previous: Int?
    var results: [StatInfo]
    
    var statListInfoItem: StatListInfo {
        return StatListInfo(count: count, next: next, previous: previous, stats: results)
    }
}

class StatListInfoMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> StatListInfo {
        guard response.statusCode == 200, let statListInfoData = try? JSONDecoder().decode(StatListInfoItem.self, from: data) else {
            throw GeneralError.invalidData
        }
        return statListInfoData.statListInfoItem
    }
}
