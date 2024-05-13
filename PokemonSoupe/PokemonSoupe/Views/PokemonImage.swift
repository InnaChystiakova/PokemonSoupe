//
//  PokemonImage.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 13/05/2024.
//

import SwiftUI

struct PokemonImage: View {
    let imageURL: URL

    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "photo")
                .frame(width: 50, height: 50)
                .overlay {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
        }
    }
}
