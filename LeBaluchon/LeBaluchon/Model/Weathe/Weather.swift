//
//  Weather.swift
//  LeBaluchon
//
//  Created by hicham on 19/10/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation

//Struct for matching Json response
struct WeatherInfo: Decodable {
  let weather: [WeatherElement]
    let main: Main
    let id: Int
  
}

struct Main: Decodable {
    let temp: Double
}

struct WeatherElement: Decodable {
    let description, main, icon: String
}
