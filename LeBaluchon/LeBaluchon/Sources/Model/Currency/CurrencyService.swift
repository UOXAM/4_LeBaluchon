//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 19/08/2021.
//

import Foundation

extension CurrencyService: UrlEncodable {}

final class CurrencyService {

    // MARK: - Properties

    private let session: URLSession
    private let baseUrlCurrencyRates: String = "http://data.fixer.io/api/latest"
    private let baseUrlCurrencyList: String = "http://data.fixer.io/api/symbols"
    private let accessKey = ("access_key", ApiConfig.fixerKey)


    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    
    // MARK: - Network managment
    
    func fetchCurrencyRates(initialCurrency: String, finalCurrency: String, callback: @escaping (Result<CurrencyRates, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: baseUrlCurrencyRates) else {return}
        let symbols = ("symbols", "\(initialCurrency),\(finalCurrency)")
        let parameters = [accessKey, symbols]
        let url = encode(baseURL: baseUrl, parameters: parameters)

        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }

    func fetchCurrencyList(callback: @escaping (Result<CurrencyList, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: baseUrlCurrencyList) else {return}
        let parameters = [accessKey]
        let url = encode(baseURL: baseUrl, parameters: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }


// MARK: - Fonction

    func calculateAmount(initialAmount: Double, initialRate: Double, finalRate: Double) throws -> String {
//        guard initialAmount.integer != nil else { throw BinaryError.numberTooBig }
        let result = initialAmount / initialRate * finalRate
        guard result.integer != nil else { throw CurrencyError.amountTooBig }
        let stringIntegerResult: String = String(format: "%.02f", result)

        return stringIntegerResult
    }
    
    func checkNumberNotTooBig(amount: Double) -> Bool {
        guard amount.integer != nil else {
            return false
        }
        return true
    }
}
