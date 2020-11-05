//
//  ChangeServiceTests.swift
//  LeBaluchonTests
//
//  Created by hicham on 12/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class ChangeServiceTests: XCTestCase {
    
    // 1- presence error
        func testGetCurrencyShouldPostFailedCallbackIfError() {
            // Given
            let changeService = ChangeService(
             changeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorData))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            changeService.getChange { (success, currency)  in
                // Then
               XCTAssertFalse(success)
                XCTAssertNil(currency)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

    //2 - no data
        func testGetCurrencyShouldPostFailedCallbackIfNoData() {
            // Given
            let changeService = ChangeService(
                changeSession: URLSessionFake(data: nil, response: nil, error: nil))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            changeService.getChange { (success, currency) in
                // Then
                XCTAssertFalse(success)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

    // 3- data correct and incorrect response
        func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
            // Given
            let changeService = ChangeService(
                changeSession: URLSessionFake(
                    data: FakeResponseData.currrencyCorrectData,
                    response: FakeResponseData.responseKO,
                    error: nil))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            changeService.getChange { (success, currency) in
                // Then
                XCTAssertFalse(success)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

    // 4 - no error data incorrect and response ok
        func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
            // Given
            let changeService = ChangeService(
                changeSession: URLSessionFake(
                    data: FakeResponseData.incorrectData,
                    response: FakeResponseData.responseOK,
                    error: nil))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            changeService.getChange{ (success, currency) in
                // Then
                XCTAssertFalse(success)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }

    // 5- completed test ok
        func testGetCurrencyShouldPostSuccesCallbackIfCorrectDataAndNoError() {
            // Given
            let changeService = ChangeService(
                changeSession: URLSessionFake(
                    data: FakeResponseData.currrencyCorrectData,
                    response: FakeResponseData.responseOK,
                    error: nil))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change")
            changeService.getChange { (success, currency) in
                // Then
                XCTAssertTrue(success)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 0.01)
        }
    }

