//
//  ClothingCategoriyItemView.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 24/5/25.
//

import SwiftUI

struct ClothingCategoryItemView: View {
    let iconName: String
    let onTap: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(AppTheme.wineRed)
                    .frame(width: 60, height: 60)
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
            }
        }
        .onTapGesture {
            onTap()
        }
    }
}
