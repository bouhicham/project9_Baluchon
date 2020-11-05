//
//  URLSessionFake.swift
//  LeBaluchonTests
//
//  Created by hicham on 11/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation

// we create the 2 classes responsible for network calls
class URLSessionFake: URLSession{
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data:Data?, response: URLResponse?, error: Error?){
        self.data = data
       self.response = response
        self.error = error
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
               task.urlResponse = response
               task.responseError = error
        return task
    }
    
override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let task = URLSessionDataTaskFake()
            task.data = data
            task.urlResponse = response
            task.responseError = error
            task.completionHandler = completionHandler
            return task
        }
}
// double de dataTask qui va simuler l'appel, mais ne va pas lancer l'appel
// double of dataTask which will simulate the call
class URLSessionDataTaskFake : URLSessionDataTask {
    // on fait les ovveride des methodes qu'on utilise
    // the ovverides of the methods we use
    // call
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    // appeler le bloc de retour et je lui pase en para les 3 propritet
    
   // call the return block and I pass him by the 3 properties
    override func resume() {
      completionHandler?(data, urlResponse, responseError)
    }
    // anuller l'appel reseau si il y'en a en cour mais c'est un test
    
    //cancel the network call if there is any in court but it is a tes
    override func cancel() {}
}
