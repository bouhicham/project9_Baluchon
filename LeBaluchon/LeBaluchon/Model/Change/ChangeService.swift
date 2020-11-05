//
//  ChangeService.swift
//  LeBaluchon
//
//  Created by hicham on 08/06/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation

class ChangeService {
    
    // MARK: Singleton Property
    static var shared = ChangeService()
   
    var task: URLSessionDataTask?
    
    // addiction injection
    private var changeSession: URLSession
    
    init(changeSession: URLSession =  URLSession(configuration: .default)) {
        
        self.changeSession = changeSession
        
    }
    var myCurrency: [String] = []
    var myValues: [Double] = []
  
    
    func getChange( callback: @escaping (Bool, Currency?) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=90f203a1163112fdf3731fb4453e6d2c") else { return }
        
        
        task?.cancel()
        task = changeSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
            for (key, value) in Array(weatherResponseJSON.rates.sorted(by: {$0.0 < $1.0})){
                    self.myCurrency.append(key)
                    self.myValues.append(value)
                }
                callback(true, weatherResponseJSON)
                
            }
        }
        task?.resume()
    }
}

