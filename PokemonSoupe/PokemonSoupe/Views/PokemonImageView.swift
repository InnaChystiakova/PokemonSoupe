//
//  PokemonImageView.swift
//  PokemonSoupe
//
//  Created by Inna Chystiakova on 13/05/2024.
//

import SwiftUI

struct PokemonImageView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            Image(systemName: "photo")
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    PokemonImageView(imageURL: "")
}
