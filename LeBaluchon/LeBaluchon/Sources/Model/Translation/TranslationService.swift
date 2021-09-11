//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 05/09/2021.
//

import Foundation

extension TranslationService: UrlEncodable {}

final class TranslationService {

    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?
    private let baseUrl: String = "https://translation.googleapis.com/language/translate/v2"
    private let accessKey = ("key", ApiConfig.googleKey)
    private let languageInitial = ("source", "fr")
    private let languageFinal = ("target", "en")
    
    
//    key=AIzaSyCi-P9_GYOlNswiSFuO_80D0mbGZyS2njA&q=bonjour&source=fr&target=en

    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Network managment
    
    func fetchTextTranslation(text: String, callback: @escaping (Result<GoogleTranslation, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: baseUrl) else {return}
        let textToTranslate = ("q", text)
        let parameters = [accessKey, textToTranslate, languageInitial, languageFinal]
        let url = encode(baseURL: baseUrl, parameters: parameters)

        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}
