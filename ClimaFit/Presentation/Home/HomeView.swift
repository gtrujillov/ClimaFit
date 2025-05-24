//
//  HomeView.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 23/5/25.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedClothingCategory: String? = nil

    private var clothingItems: [Dictionary<String, String>.Element] {
        viewModel.clothingRecommendation?.clothCategory.map { $0 } ?? []
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                //MARK: - Location section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ubicación")
                            .font(AppTheme.thinFont(size: .callout))
                        HStack{
                            Image(systemName: "location.fill")
                                .foregroundColor(AppTheme.wineRed)
                                .font(.system(size: 16))
                            Text(viewModel.weather?.name ?? "-")
                                .font(AppTheme.regularFont(size: .subheadline))
                        }
                    }
                    Spacer()
                }
                //MARK: - Weather section
                VStack(spacing: -4) {
                    HStack {
                        Text(viewModel.weather?.temperatureFormatted ?? "0.0º")
                            .font(AppTheme.boldFont(size: .largeTitle))
                        if let url = viewModel.weather?.iconURL {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 70, height: 70)
                        }
                    }
                    Text(viewModel.weather?.description ?? viewModel.weatherDescription)
                        .font(AppTheme.regularFont(size: .small))
                }
                //MARK: - Categories section
                HStack {
                    VStack(alignment: .leading) {
                        Text("Categorias")
                            .font(AppTheme.regularFont(size: .subheadline))
                        Text(viewModel.clothingRecommendation?.summary ?? "")
                            .font(AppTheme.thinFont(size: .small))
                        
                        //MARK: - Categories
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(clothingItems, id: \.key) { item in
                                    ClothingCategoryItemView(
                                        iconName: item.value,
                                        onTap: {
                                            print("Seleccionaste \(item.key)")
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
                .padding(.vertical, 24)
                
                //MARK: - Recomendation section
                VStack(alignment: .leading) {
                    HStack {
                        Text("Outfits recomendados")
                            .font(AppTheme.regularFont(size: .subheadline))
                        Spacer()
                    }
                    //MARK: - Grid of images
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<4) { index in
                            //TODO: Card view with outfit recomendatios
                            CardView(imageURL: "https://i.pinimg.com/736x/c7/bb/b1/c7bbb16bd8115d6afeeb6a2a4b437fe0.jpg")
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea()
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Mock para Preview

private struct MockGetWeatherUseCase: GetWeatherUseCase {
    func execute(lat: Double, lon: Double) async -> Weather {
        return Weather(
            temperature: 23.5,
            humidity: 65,
            windSpeed: 14.2,
            description: "Cielo parcialmente nublado",
            icon: "cloud.sun.fill",
            name: "Lisboa"
        )
    }
}

private struct MockGetLocationUseCase: GetLocationUseCase {
    func execute() async throws -> CLLocationCoordinate2D? {
        CLLocationCoordinate2D(latitude: 40.123432452, longitude: -3.3243534)
    }
}

private struct MockGetClothingRecommendationUseCase: GetClothingRecommendationUseCase {
    func execute(temperature: Double) -> ClothingRecommendation {
        return ClothingRecommendation(
            summary: "Ropa ligera, hace calor.",
            clothCategory: [
                "camiseta": "tshirt",
                "pantalón corto": "shorts",
                "gafas de sol": "sun.max.fill"
            ]
        )
    }
}

#Preview {
    let mockLocationUseCase = MockGetLocationUseCase()
    let mockUseCase = MockGetWeatherUseCase()
    let viewModel = HomeViewModel(getLocationUseCase: mockLocationUseCase, getWeatherUseCase: mockUseCase, getClothingRecomentadionUseCase: MockGetClothingRecommendationUseCase())
    HomeView(viewModel: viewModel)
}
