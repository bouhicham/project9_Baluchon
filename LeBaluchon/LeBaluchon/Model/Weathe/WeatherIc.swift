//
//  WeatherIc.swift
//  Testing
//
//  Created by hicham on 26/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
import UIKit

class WeatherIc: UIView  {
    // Stock images with their key
    static let icon: [String: UIImage] = ["haze": #imageLiteral(resourceName: "scattered") ,"fewClouds":#imageLiteral(resourceName: "fewClouds") , "mist":#imageLiteral(resourceName: "mist") , "rain":#imageLiteral(resourceName: "10n_Rain") ,"snow": #imageLiteral(resourceName: "snow"),"clear":#imageLiteral(resourceName: "clear")]
}
struct GoogleApi {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    static let body = "method=getWeather&format=json&lang=fr"
    static let format = "&format=text"
    static let key = "&appid=6ee17379b37ec733cc41eaaa47a74ec2"

    static let end = "&units=metric"
    
}

struct TranslateApi {
    static let baseUrl = "https://translation.googleapis.com/language/translate/v2?q="
    static let body = "&source=fr&target=ar"
    static let format = "&format=text"
    static let key = "&key=AIzaSyBj-8NoNMEHUnl0yJNVyIIk84Rebkp8omc"
    
    
}
