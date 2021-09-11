//
//  NetworkError.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 23/08/2021.
//

import Foundation

enum NetworkError:  Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData, .invalidResponse, .undecodableData:
            return "The service is momentarily unavailable"
        }
    }
}
