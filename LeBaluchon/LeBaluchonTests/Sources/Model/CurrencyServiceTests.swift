//
//  CurrencyServiceTests.swift
//  LeBaluchonTests
//
//  Created by ROUX Maxime on 06/09/2021.
//

import XCTest

@testable import LeBaluchon

// MARK: - Test Network call for Currency rates
class CurrencyServiceTests: XCTestCase {
    
    // MARK: - Test Network call for Currency rates


    // Properties
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()

    // fetchCurrencyRate Tests
    private var fakeResponseCurrencyRate = FakeResponseData(with: currencyTest)

    // Error : no data
    func testsFetchCurrencyRate_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyRate.urlToTest: (nil, nil, fakeResponseCurrencyRate.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyRates(initialCurrency: "EUR", finalCurrency: "USD") { result in
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
    func testsFetchCurrencyRate_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyRate.urlToTest: (fakeResponseCurrencyRate.correctData, fakeResponseCurrencyRate.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyRates(initialCurrency: "EUR", finalCurrency: "USD") { result in
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
    func testsFetchCurrencyRate_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyRate.urlToTest: (fakeResponseCurrencyRate.incorrectData, fakeResponseCurrencyRate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyRates(initialCurrency: "EUR", finalCurrency: "USD") { result in
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
    func testsFetchCurrencyRate_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnCorrectRates() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyRate.urlToTest: (fakeResponseCurrencyRate.correctData, fakeResponseCurrencyRate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyRates(initialCurrency: "EUR", finalCurrency: "USD") { result in
            guard case .success(let currency) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(currency.rates["USD"] == 1.187366)
            XCTAssertTrue(currency.rates["EUR"] == 1)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

// MARK: - Test Network call for Currency list
    
    // Property
    
    private var fakeResponseCurrencyList = FakeResponseData(with: currencyListTest)
        
    // fetchCurrencyList Tests

    // Error : no data
    func testsFetchCurrencyList_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyList.urlToTest: (nil, nil, fakeResponseCurrencyList.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyList { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            print(error)
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Error : invalid response
    func testsFetchCurrencyList_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyList.urlToTest: (fakeResponseCurrencyList.correctData, fakeResponseCurrencyList.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyList { result in
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
    func testsFetchCurrencyList_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyList.urlToTest: (fakeResponseCurrencyList.incorrectData, fakeResponseCurrencyList.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyList { result in
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
    func testsFetchCurrencyList_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnCorrectCurrencyList() {
        URLProtocolFake.fakeURLs = [fakeResponseCurrencyList.urlToTest: (fakeResponseCurrencyList.correctData, fakeResponseCurrencyList.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: CurrencyService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.fetchCurrencyList { result in
            guard case .success(let currencyList) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(currencyList.symbols["EUR"] == "Euro")
            XCTAssertTrue(currencyList.symbols["USD"] == "United States Dollar")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    
    // MARK: - Function CalculateAmount
    
    func testsCalculateAmount_WhenValidAmountAndRatesArePassed_ThenShouldReturnCorrectAmount() {
        let sut: CurrencyService = .init()

        let result = try? sut.calculateAmount(initialAmount: 100, initialRate: 1, finalRate: 1.187366)
        XCTAssertTrue(result! == "118.74")
    }
    
    func testsCalculateAmount_WhenTooBigAmountIsPassed_ThenShouldReturnResultAsNil() {
        let sut: CurrencyService = .init()

        let result = try? sut.calculateAmount(initialAmount: 1000000000000000013287555072, initialRate: 1, finalRate: 1.187366)
        XCTAssertTrue(result == nil)
    }
    
    // MARK: - Function CalculateAmount

    func testCheckNumberNotTooBig_WhenValidAmountNotTooBigIsPassed_ThenShouldReturnTrue() {
        let sut: CurrencyService = .init()
        let amountIsNotTooBig = sut.checkNumberNotTooBig(amount: 168775)
        
        XCTAssertTrue(amountIsNotTooBig == true)
        
    }
    
    func testCheckNumberNotTooBig_WhenUnvalidAmountTooBigIsPassed_ThenShouldReturnFalse() {
        let sut: CurrencyService = .init()
        let amountIsNotTooBig = sut.checkNumberNotTooBig(amount: 1687800000000000119537664)
        
        XCTAssertTrue(amountIsNotTooBig == false)
        
    }

}
