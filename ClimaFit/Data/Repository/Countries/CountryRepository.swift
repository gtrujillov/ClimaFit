//
//  CountryRepository.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation

protocol CountryRepository {
    func getCountries() async throws -> [Country]
}
