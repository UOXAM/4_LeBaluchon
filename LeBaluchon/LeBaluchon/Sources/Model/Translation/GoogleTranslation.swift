//
//  GoogleTranslation.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 05/09/2021.
//

import Foundation

struct GoogleTranslation: Decodable {
    let data: DataClass

    struct DataClass: Decodable {
        let translations: [Translation]

        struct Translation: Decodable {
            let translatedText: String
        }
    }
}

