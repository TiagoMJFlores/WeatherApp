//
//  Weather.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

struct WeatherElement: Codable {
    let id: Int
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case icon
    }
}
