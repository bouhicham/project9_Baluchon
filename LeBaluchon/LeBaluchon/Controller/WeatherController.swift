//
//  WeatherController.swift
//  Testing
//
//  Created by hicham on 26/05/2020.
//  Copyright © 2020 hicham. All rights reserved.
//

import Foundation
import UIKit

class WeatherController: UIViewController  {
    
    // Local
    @IBOutlet weak var localNameCity: UILabel!
    @IBOutlet weak var howWeatherLocal: UILabel!
    @IBOutlet weak var degressLocal: UILabel!
    @IBOutlet weak var imageLocal: UIImageView!
    // Destination
    @IBOutlet weak var DestinationNameCity: UILabel!
    @IBOutlet weak var howWeatherDestination: UILabel!
    @IBOutlet weak var degressDestination: UILabel!
    @IBOutlet weak var imageDestination: UIImageView!
    // Supporting
    @IBOutlet var background: UIView!
    @IBOutlet weak var buttonCompare: UIButton!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShaddowToQuoteLabel()
        tappedWeatherButton()
    }
    
    //MARK: - Method
    private func addShaddowToQuoteLabel(){
        localNameCity.layer.shadowColor = UIColor.white.cgColor
        localNameCity.layer.shadowOpacity = 1.9
        localNameCity.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        //Destination
        DestinationNameCity.layer.shadowColor = UIColor.white.cgColor
        DestinationNameCity.layer.shadowOpacity = 1.9
        DestinationNameCity.layer.shadowOffset = CGSize(width: 2, height: 2)
        background.backgroundColor = UIColor(patternImage: UIImage(named:"BB")!)
    }
    // City depart
    func tappedWeatherButton() {
        weatherService.getWeather(city: .roubaix) { (result,weather)  in
            DispatchQueue.main.async {
                if result, let weather = weather {
                    self.weatherDestination()
                    self.update(data: weather)
                    self.imageLocal.image = self.setImage(for: weather.weather[0])
                    self.presentAlert(message: "Une erreur est survenue vérifier la ville saisie et la connexion internet")
                    
                }
            }
        }
    }
    // City arrival
    func weatherDestination() {
        weatherService.getWeather(city: .NewYork) { (result,weather)  in
            DispatchQueue.main.async {
                if result, let weather = weather {
                    self.apdate(data: weather)
                    self.imageDestination.image = self.setImage(for: weather.weather[0])
                    
                    self.presentAlert(message: "Une erreur est survenue vérifier la ville saisie et la connexion internet")
                }
            }
        }
    }
    
    
    // Set image for weather description
    private func setImage(for weatherElement: WeatherElement) -> UIImage {
        // Main weather description
        let main = weatherElement.main
        
        // Change image to match main description
        if main.contains("Clouds") {
            return #imageLiteral(resourceName: "02n_Few_Clouds")
        } else if main.contains("Clear") {
            return #imageLiteral(resourceName: "clear-1")
        } else if main.contains("Rain") {
            return #imageLiteral(resourceName: "rain-1")
        } else if main.contains("Thunderstorm") {
            return #imageLiteral(resourceName: "11n_Thunderstorm")
        } else if main.contains("Snow") {
            return #imageLiteral(resourceName: "13n_snow")
        } else if main.contains("Drizzle") {
            return #imageLiteral(resourceName: "rain")
        }
        
        // For all the rest
        return #imageLiteral(resourceName: "suny.jpg")
    }
    // display view
    private func update(data: WeatherInfo) {
        localNameCity.text = "ROUBAIX"
        howWeatherLocal.text = data.weather[0].main
        degressLocal.text = convertToString(value: data.main.temp) + "°C"
        imageLocal.image = WeatherIc.icon[data.weather[0].main]
    }
    // display view
    private func apdate(data: WeatherInfo) {
        DestinationNameCity.text = "NEW YORK"
        howWeatherDestination.text = data.weather[0].main
        degressDestination.text = convertToString(value: data.main.temp) + "°C"
        imageDestination.image = WeatherIc.icon[data.weather[0].icon]
        
    }
}



