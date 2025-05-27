//
//  Country.swift
//  ClimaFit
//
//  Created by Gonzalo Trujillo Vallejo on 27/5/25.
//

import Foundation

struct Country: Identifiable {
    var id: String { code }
    let name: String
    let code: String
    let flagURL: URL?
}
