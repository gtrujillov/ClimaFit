//
//  GetCountriesUseCase.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation

final class GetCountriesUseCase {
    
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Country] {
        try await repository.getCountries()
    }
}
