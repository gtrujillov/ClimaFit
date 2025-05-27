//
//  SearchLocationView.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import SwiftUI
struct SearchLocationView: View {
    @StateObject var viewModel: SearchLocationViewModel

    var onDismiss: (() -> Void)? = nil

    @State private var searchText = ""

    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredCountries) { country in
                Text(country.name)
            }
            .searchable(text: $searchText)
            .navigationTitle("Buscar país")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        onDismiss?()
                    }
                }
            }
            .task {
                await viewModel.loadCountries()
            }
        }
    }
}

#Preview {
    SearchLocationView(viewModel: SearchLocationViewModel(getCountriesUseCase: GetCountriesUseCase(repository: CountryRepositoryImpl())))
}
