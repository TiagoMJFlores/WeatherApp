//
//  WeatherListInteractor.swift
//  WeatherApp
//
//  Created by Tiago Flores on 01/06/2022.
//


import Resolver

protocol WeatherListInteractorProtocol {
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ())
}

final class WeatherListInteractor {
    @Injected var apiClient: WeatherAPIClientProtocol
}

extension WeatherListInteractor: WeatherListInteractorProtocol {
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ()) {
        apiClient.getWeatherList(cityName: "Lisbon", completion: completion)
    }
    
}
