//
//  NetworkConfigs.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation

final class NetworkConfigs {
    static let weatherAPIKey =  "5b9b1ff07f3972c825ba43eb281a31c7"
    static let weatherAPIBaseURL =  "https://api.openweathermap.org/data/2.5"

    enum WeatherURLQueryKeyParams: String {
        case cityQuery = "q",
             appID = "appid",
             temperatureUnit = "units"
    }
    
    enum WeatherURLQueryValueParams: String {
        case temperatureKevin = "metric"
    }
    

    enum WeatherURLPaths: String {
        case forecast = "forecast"
    }

}

