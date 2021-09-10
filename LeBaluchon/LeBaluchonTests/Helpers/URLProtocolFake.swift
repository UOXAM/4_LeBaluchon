//
//  URLProtocolFake.swift
//  Le BaluchonTests
//
//  Created by ROUX Maxime on 06/09/2021.
//

import Foundation

// URLProtocol gère le chargement des données que nous souhaitons renvoyer
class URLProtocolFake: URLProtocol {
    static var fakeURLs = [URL?: (data: Data?, response: HTTPURLResponse?, error: Error?)]()

    // Détermine si la sous-classe du protocol peut gérer la demande spécifiée
    override class func canInit(with request: URLRequest) -> Bool { true }

    // Renvoie une version canonique de la requête spécifiée
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    // Démarre le chargement, spécifique au protocol, de la demande
    override func startLoading() {
        if let url = request.url {
            if let (data, response, error) = URLProtocolFake.fakeURLs[url] {
                if let responseStrong = response {
                    client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }
                if let dataStrong = data {
                    client?.urlProtocol(self, didLoad: dataStrong)
                }
                if let errorStrong = error {
                    client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    // Arrête le chargement, spécifique au protocol, de la demande
    override func stopLoading() { }
}
