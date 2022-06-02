//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

import Foundation
import Alamofire

protocol WeatherAPIClientProtocol {
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ())
}

final class WeatherAPIClient {
    
}

extension WeatherAPIClient: WeatherAPIClientProtocol {
    
    func getLisbonWeatherList(completion: @escaping (Result<WeatherDataContainer, Error>) -> ()) {
        AF.request("https://api.openweathermap.org/data/2.5/forecast", parameters: ["q": "Lisbon", "appid": "5b9b1ff07f3972c825ba43eb281a31c7"])
            .validate()
            .responseDecodable(of: WeatherDataContainer.self) { (response) in
                guard let data = response.value else {
                    
                    completion(.failure(NSError(domain: "error", code: -1) as Error))
                    return
                    
                }
                
                completion(.success(data))
            }
    }
}
