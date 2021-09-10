//
//  TranslationService.swift
//  LeBaluchonTests
//
//  Created by ROUX Maxime on 09/09/2021.
//

import XCTest

@testable import LeBaluchon

// MARK: - Test Network call for current weather

class TranslationServiceTests: XCTestCase {

    // MARK: - Properties
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    // MARK: - fetchTranslation Tests
    private let fakeResponseTranslation = FakeResponseData(with: translationTest)
    
    // Error : no data
    func testsFetchTranslation_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseTranslation.urlToTest: (nil, nil, fakeResponseTranslation.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslationService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchTextTranslation(text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            print(result)
            print(error)
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Error : invalid response
    func testsFetchTranslation_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseTranslation.urlToTest: (fakeResponseTranslation.correctData, fakeResponseTranslation.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslationService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchTextTranslation(text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // Error : undecodable data
    func testsFetchTranslation_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseTranslation.urlToTest: (fakeResponseTranslation.incorrectData, fakeResponseTranslation.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslationService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchTextTranslation(text: "Bonjour") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // Success
    func testsFetchTranslation_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnCorrectTranslation() {
        URLProtocolFake.fakeURLs = [fakeResponseTranslation.urlToTest: (fakeResponseTranslation.correctData, fakeResponseTranslation.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslationService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchTextTranslation(text: "Bonjour") { result in
            guard case .success(let translation) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(translation.data.translations[0].translatedText == "Hello")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}

    
    
