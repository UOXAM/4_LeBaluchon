//
//  MeteoServiceTests.swift
//  LeBaluchonTests
//
//  Created by ROUX Maxime on 09/09/2021.
//

import XCTest

@testable import LeBaluchon

// MARK: - Test Network call for current weather

class MeteoServiceTests: XCTestCase {

    // MARK: - Properties
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    // MARK: - fetchCurrentWeather Tests
    private let fakeResponseCurrentWeather = FakeResponseData(with: meteoTest)

    // Error : no data
    func testsFetchCurrentWeather_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrentWeather.urlToTest: (nil, nil, fakeResponseCurrentWeather.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: MeteoService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrentWeather() { result in
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
    func testsFetchCurrentWeather_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrentWeather.urlToTest: (fakeResponseCurrentWeather.correctData, fakeResponseCurrentWeather.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: MeteoService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrentWeather() { result in
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
    func testsFetchCurrentWeather_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrentWeather.urlToTest: (fakeResponseCurrentWeather.incorrectData, fakeResponseCurrentWeather.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: MeteoService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrentWeather() { result in
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
    func testsFetchCurrentWeather_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnCorrectWeather() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrentWeather.urlToTest: (fakeResponseCurrentWeather.correctData, fakeResponseCurrentWeather.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: MeteoService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrentWeather() { result in
            guard case .success(let meteo) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(meteo.list[0].name == "Montpellier")
            XCTAssertTrue(meteo.list[0].sys.country == "FR")
            XCTAssertTrue(meteo.list[0].weather[0].weatherDescription == "ciel dégagé")
            XCTAssertTrue(meteo.list[0].main.temp == 20.73)

            XCTAssertTrue(meteo.list[1].name == "New York")
            XCTAssertTrue(meteo.list[1].sys.country == "US")
            XCTAssertTrue(meteo.list[1].weather[0].weatherDescription == "couvert")
            XCTAssertTrue(meteo.list[1].main.temp == 17.19)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
