//
//  InfoForFakeResponseData.swift
//  Le BaluchonTests
//
//  Created by ROUX Maxime on 09/09/2021.
//

import Foundation

struct DataTest {
    let url : URL
    let resource : String
}

let meteoTest = DataTest(url: URL(string: "http://api.openweathermap.org/data/2.5/group?id=2992166,5128581&appid=b0717bd21c57372b42c5a757203a9ffe&units=metric&lang=FR")!, resource: "Meteo")
let translationTest = DataTest(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCi-P9_GYOlNswiSFuO_80D0mbGZyS2njA&q=Bonjour&source=fr&target=en")!, resource: "GoogleTranslation")

let currencyTest = DataTest(url: URL(string: "http://data.fixer.io/api/latest?access_key=9a5c242c88ed73b078704e2202c1e5da&symbols=EUR,USD")!, resource: "Currency")
let currencyListTest = DataTest(url: URL(string: "http://data.fixer.io/api/symbols?access_key=9a5c242c88ed73b078704e2202c1e5da")!, resource: "CurrencyList")
