//
//  CardView.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 26/5/25.
//

import SwiftUI

struct CardView: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
        } placeholder: {
            ProgressView()
        }
        .cornerRadius(AppTheme.cornerRadius)
    }
}

#Preview {
    CardView(imageURL: "https://via.placeholder.com/150x200")
}
