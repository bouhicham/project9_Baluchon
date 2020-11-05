//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by hicham on 19/10/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
class WeatherService {
    
    enum City: String {
        
        case roubaix
        case NewYork = "NEW YORK"
        
    }
    private func urlWeather(city: City) -> String {
        let weatherURL =  city.rawValue + GoogleApi.key
        guard let weatherURLconverted = weatherURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        let urlWeather = GoogleApi.baseUrl + weatherURLconverted +  GoogleApi.end
        return urlWeather
    }
   
    var weatherSession: URLSession
    var task: URLSessionDataTask?
    
    
    init(weatherSession: URLSession =  URLSession(configuration: .default)) {
        
        self.weatherSession = weatherSession
        
    }
    
    
    //Method to get the foreigner's city weather from the Yahoo Weather API with a GET request
    func getWeather(city: City, callback: @escaping (Bool, WeatherInfo?) -> Void) {
        
        guard let url = URL(string: urlWeather(city: city)) else { return }
        
        
        
        task?.cancel()
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let weatherResponseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, weatherResponseJSON)
                
            }
        }
        task?.resume()
    }
}


