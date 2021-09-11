//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by ROUX Maxime on 08/09/2021.
//
import Foundation

class FakeResponseData {
    let urlToTest: URL
    let responseOK: HTTPURLResponse
    let responseKO: HTTPURLResponse
    let incorrectData = "erreur".data(using: .utf8)!
    var correctData: Data {
        let url = url
        let data = try! Data(contentsOf: url)
        return data
    }
    private let url: URL
    class NetworkError: Error {}
    let error = NetworkError()
    
    init(with dataToTest: DataTest) {
        self.urlToTest = dataToTest.url
        self.responseOK = HTTPURLResponse(url: dataToTest.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        self.responseKO = HTTPURLResponse(url: dataToTest.url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        self.url = Bundle(for: FakeResponseData.self).url(forResource: dataToTest.resource, withExtension: "json")!
    }
}
