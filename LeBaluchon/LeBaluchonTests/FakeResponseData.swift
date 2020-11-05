//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by hicham on 11/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
class FakeResponseData {

   
    // we create 2 instance of the HTTPURLRESPONSE
    static  let responseOK = HTTPURLResponse(url:  URL(string: "https//openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])! // nil
    
    
   static  let responseKO = HTTPURLResponse(url:  URL(string: "https//openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields:[:])!
    
    // Create error
    

        static  var currrencyCorrectData: Data? {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "Currency", withExtension: "json")!
            return try? Data(contentsOf: url)
        }

      static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        // ! unpack my url
        let data = try! Data(contentsOf: url!)
        return data
    }

      static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        // ! unpack my url
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    
    // JSON DAMAGED
  static  let incorrectData = "erreur".data(using: .utf8)
    
    class BaluchonError: Error {}
         // create instance
     static let errorData = BaluchonError()
     
     
    }
    
    
    

