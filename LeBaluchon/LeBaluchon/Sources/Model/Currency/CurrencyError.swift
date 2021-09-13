//
//  CurrencyError.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 13/09/2021.
//

import Foundation

enum CurrencyError: Error {
    case amountTooBig
}

extension CurrencyError: CustomStringConvertible {
    var description: String {
        switch self {
        case .amountTooBig: return "The amount is too big !"
        }
    }
}
