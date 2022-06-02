//
//  WeatherListInteractor.swift
//  WeatherApp
//
//  Created by Tiago Flores on 01/06/2022.
//

import Foundation

protocol WeatherListInteractorProtocol {
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ())
}

class WeatherListInteractor {
    private var apiClient = WeatherAPIClient()
    
}

extension WeatherListInteractor: WeatherListInteractorProtocol {
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ()) {
        apiClient.getLisbonWeatherList(completion: completion)
    }
    
}
