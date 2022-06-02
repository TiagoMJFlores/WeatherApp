//
//  WeatherEndPoint.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation

enum WeatherEndPoint {
    case forecast(city: String)
    
    
    var path: String {
        switch self {
        case .forecast(_):
            return "\(NetworkConfigs.weatherAPIBaseURL)/\(NetworkConfigs.WeatherURLPaths.forecast)"
        }
    }
    
    var queryParams: [String: String] {
        switch self {
        case .forecast(let city):
            return [NetworkConfigs.WeatherURLQueryParams.cityQuery.rawValue: city, NetworkConfigs.WeatherURLQueryParams.appid.rawValue: NetworkConfigs.weatherAPIKey]
        }
    }

}
