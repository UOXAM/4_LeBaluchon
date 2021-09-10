//
//  Exchange.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 19/08/2021.
//

import Foundation

struct CurrencyRates: Decodable {
    let rates : [String: Double]
    let date : String
}

struct CurrencyList: Decodable {
    let symbols : [String: String]
}
