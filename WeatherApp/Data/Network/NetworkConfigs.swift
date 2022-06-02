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

    enum WeatherURLQueryParams: String {
        case cityQuery = "q",
             appid = "appid"
    }

}

