//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by hicham on 10/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import XCTest


// in order to have access to the classes of our application
@testable import LeBaluchon

// create subclasses
class WeatherServiceTests: XCTestCase {

    // 1 - Testing Error
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: nil, response: nil, error: FakeResponseData.errorData))

        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    // 1- testing Error New York
  func testGetWeatherNewYorkShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: nil, response: nil, error: FakeResponseData.errorData))
        
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .NewYork) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // 2 - No data
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
   //  2- No data
    func testGetWeatherNewYorkShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: nil, response: nil, error: nil))
      
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .NewYork) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // 3- Data correct and response Ko
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
           
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
  // 3 - Response incorect New York
    func testGetWeatherNewYorkShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
    
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .NewYork) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // 4 - data incorrect
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
   // 4 - response incorrect and new York
   func testGetWeatherNewYorkShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
         
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .NewYork) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    
    func testGetWeatherShouldPostFailedCallbackIfNYWeatherError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: FakeResponseData.errorData))
    
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    

    func testGetWeatherShouldPostSuccesCallbackIfCorrectDataAndNoError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .roubaix) { (success, weatherDetails) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherDetails)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    // TEST COMPLETED OK
    func testGetWeatherNewYorkShouldPostSuccesCallbackIfCorrectDataAndNoError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        weatherService.getWeather(city: .NewYork) { (success, weatherDetails) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherDetails)


            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

