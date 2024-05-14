//
//  PokemonSoupeApp.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 08/05/2024.
//

import SwiftUI

@main
struct PokemonSoupeApp: App {
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.systemPink,
                .font: UIFont(name: "ArialRoundedMTBold", size: 35)!
        ]
        navBarAppearance.titleTextAttributes = [
            .foregroundColor:UIColor.systemPink,
                .font: UIFont(name: "ArialRoundedMTBold", size: 20)!
        ]
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            PokemonListView()
        }
    }
}
