//
//  CountryRepositoryImpl.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation

final class CountryRepositoryImpl: CountryRepository {
    let apiClient = CountryAPIClient()
    
    func getCountries() async throws -> [Country] {
        let dtos = try await apiClient.fetchCountries()
        
        return dtos.map { dto in
            Country(
                name: dto.name.common,
                code: dto.cca2,
                flagURL: dto.flags?.png.flatMap { URL(string: $0) }
            )
        }
    }
}
