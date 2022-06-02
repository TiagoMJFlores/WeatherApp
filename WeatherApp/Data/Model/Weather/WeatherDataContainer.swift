//
//  Welcome.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

struct WeatherDataContainer: Codable {
    let cod: String
    let message, cnt: Int
    let weatherList: [WeatherList]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case cod, message, cnt, city , weatherList = "list"
    }
}
