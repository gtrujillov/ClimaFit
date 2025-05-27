//
//  SearchCountryCoordinatorImpl.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation
import SwiftUI

protocol SearchCountryCoordinator {
    @MainActor
    func start() -> AnyView
}

@MainActor
final class SearchCountryCoordinatorImpl: SearchCountryCoordinator {
    
    var didFinish: (() -> Void)?
    
    func start() -> AnyView {
        // Crear repositorio y caso de uso
        let countryRepository = CountryRepositoryImpl()
        let getCountriesUseCase = GetCountriesUseCase(repository: countryRepository)
        
        // Crear ViewModel inyectando el caso de uso
        let viewModel = SearchLocationViewModel(getCountriesUseCase: getCountriesUseCase)
        
        // Crear la vista pasando el ViewModel y el callback
        let searchCountryView = SearchLocationView(viewModel: viewModel) {
            self.didFinish?()
        }
        
        return AnyView(searchCountryView)
    }
}
