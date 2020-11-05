//
//  TranslateServiceTests.swift
//  LeBaluchonTests
//
//  Created by hicham on 12/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import XCTest
@testable import LeBaluchon
class TranslateServiceTests: XCTestCase {

    
    // call fail
    func testGetTranslateShouldPostFailedCallbackIfError() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorData))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
    // 2 - No data
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
    // 3 - Data ok and reponse KO
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
    
    // 4- response ok and incorrectData
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "Mon tailleur est riche") { (success, translation) in
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
    //  5 - everything is OK
    func testGetTranslationShouldPostSuccessCallbackIfNotErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate(text: "Mon tailleur est riche)") { (success, translation) in
            XCTAssert(success)
            XCTAssertTrue((translation != nil),"My tailor is rich")
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
   func testWhenSettingLanguagesThenLanguagesShouldBeSet() {
     
        TranslateService.shared.setDestinationLanguage(toLanguage: "fr")
        XCTAssertEqual(TranslateService.shared.getDestinationLanguage(), "fr")
    }
}
