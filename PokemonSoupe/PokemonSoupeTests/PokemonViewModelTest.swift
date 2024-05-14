//
//  PokemonViewModelTest.swift
//  PokemonSoupeTests
//
//  Created by Inna Chystiakova on 14/05/2024.
//

import Foundation
import XCTest

@testable import PokemonSoupe

class PokemonViewModelTests: XCTestCase {

    private let mockPokemonListInfoJson = """
        {
            "count": 3,
            "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            "previous": null,
            "results": [
                {
                    "name": "bulbasaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                    "name": "ivysaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/2/"
                },
                {
                    "name": "venusaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/3/"
                }
            ]
        }
        """

    private let mockStatListInfoJson = """
        {
            "count": 1,
            "next": null,
            "previous": null,
            "results": [
                {
                    "name": "hp",
                    "url": "https://pokeapi.co/api/v2/stat/1/"
                }
            ]
        }
        """

    var viewModel: PokemonViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PokemonViewModel()
        URLProtocol.registerClass(URLProtocolMock.self)
        
        let mockData = mockPokemonListInfoJson.data(using: .utf8)!
        let mockDataStat = mockStatListInfoJson.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "https://pokeapi.co/api/v2/pokemon")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockResponseStat = HTTPURLResponse(url: URL(string: "https://pokeapi.co/api/v2/stat")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        URLProtocolMock.testURLs = [
            URL(string: "https://pokeapi.co/api/v2/pokemon")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/2/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/3/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/5/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/6/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/7/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/8/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/9/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/10/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/11/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/12/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/13/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/14/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/15/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/16/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/17/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/18/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/19/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/pokemon/20/")!: (data: mockData, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/stat")!: (data: mockDataStat, response: mockResponse, error: nil),
            URL(string: "https://pokeapi.co/api/v2/stat/1/")!: (data: mockDataStat, response: mockResponse, error: nil)
        ]
        
        print("1")
    }

    override func tearDown() {
        viewModel = nil
        URLProtocol.unregisterClass(URLProtocolMock.self)
        super.tearDown()
    }

    func testFetchPokemons() async throws {
        viewModel.results.removeAll()
        
        try await viewModel.fetchPokemons()
        
        XCTAssertEqual(viewModel.results.count, 1, "Results count should be 1")
        XCTAssertEqual(viewModel.results[0].count, 3, "Results count should be 3")
        XCTAssertFalse(viewModel.fetching, "Fetching should be false")
        
        XCTAssertFalse(viewModel.fetching, "Fetching should be false")
    }

    func testLoadMorePokemons() async throws {
        viewModel.results.removeAll()
        
        try await viewModel.fetchPokemons()
        try await viewModel.loadMorePokemons()

        XCTAssertEqual(viewModel.results.count, 1, "Results count should be 1")
        XCTAssertEqual(viewModel.results[0].count, 3, "Results count should be 3")
        XCTAssertTrue(viewModel.isMorePokemonsAvailable, "More pokemons should be available")
    }

    func testFetchStats() async throws {
        try await viewModel.fetchStats()

        XCTAssertEqual(viewModel.statsList.count, 1, "Stats list count should be 1")
        XCTAssertEqual(viewModel.statsList[0].count, 1, "Stats count should be 1")
    }
}

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: (data: Data?, response: URLResponse?, error: Error?)]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url, let (data, response, error) = URLProtocolMock.testURLs[url] else {
            fatalError("No test data set for URL: \(request.url?.absoluteString ?? "")")
        }

        if let data = data {
            self.client?.urlProtocol(self, didLoad: data)
        }

        if let response = response {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let error = error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }

        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }
}

