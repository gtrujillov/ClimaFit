//
//  CountryDTO.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation

struct CountryDTO: Decodable {
    let name: NameDTO
    let cca2: String
    let flags: FlagDTO?
    
    struct NameDTO: Decodable {
        let common: String
    }

    struct FlagDTO: Decodable {
        let png: String?
    }
}

final class CountryAPIClient {
    func fetchCountries() async throws -> [CountryDTO] {
        let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,cca2,flags")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([CountryDTO].self, from: data)
    }
}
