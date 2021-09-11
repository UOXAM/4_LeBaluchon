//
//  MeteoService.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 30/08/2021.
//

import Foundation

extension MeteoService: UrlEncodable {}

final class MeteoService {

    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?
    private let baseUrl: String = "http://api.openweathermap.org/data/2.5/group"
    private let accessKey = ("appid", ApiConfig.owmKey)
//    private let idMontpellierFR = "2992166"
//    private let idNewYorkUS = "5128581"
    private let id = ("id", "2992166,5128581")
    private let metric = ("units", "metric")
    private let language = ("lang", "FR")

    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Network managment
    
    func fetchCurrentWeather(callback: @escaping (Result<Meteo, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: baseUrl) else {return}
        let parameters = [id, accessKey, metric, language]
        let url = encode(baseURL: baseUrl, parameters: parameters)

        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}
