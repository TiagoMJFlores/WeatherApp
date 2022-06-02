//
//  City.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation


struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone, sunrise, sunset: Int
}

