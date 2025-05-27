//
//  SearchLocationViewModel.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation
import SwiftUI

@MainActor
final class SearchLocationViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getCountriesUseCase: GetCountriesUseCase
    
    init(getCountriesUseCase: GetCountriesUseCase) {
        self.getCountriesUseCase = getCountriesUseCase
    }
    
    func loadCountries() async {
        isLoading = true
        errorMessage = nil
        
        do {
            countries = try await getCountriesUseCase.execute()
        } catch {
            errorMessage = "No se pudieron cargar los países: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

